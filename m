From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH jl/maint-submodule-gitfile-awareness] Windows: start_command:
 Support non-NULL dir in struct child_process
Date: Sun, 11 Apr 2010 23:51:13 +0200
Message-ID: <4BC24451.8010304@web.de>
References: <7vmxxar5h7.fsf@alter.siamese.dyndns.org> <loom.20100411T174751-103@post.gmane.org> <4BC233AC.3090603@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Wm9sdMOhbkbDvHplc2k=?= <zfuzesi@eaglet.hu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 23:51:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O153u-0001Zb-46
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 23:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066Ab0DKVvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 17:51:21 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:60442 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab0DKVvU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 17:51:20 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 7B89515D8B700;
	Sun, 11 Apr 2010 23:51:18 +0200 (CEST)
Received: from [80.128.50.239] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O153m-0000tR-00; Sun, 11 Apr 2010 23:51:18 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BC233AC.3090603@kdbg.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18Nvl19FebaYiZHrBNQUnJeixQFoUvnNxBdUoyR
	fw1IHUrEKrEDQ8hZLVy7hOf2hbVbw2lmHKogeXPyrKLDYc82hs
	r5KBbPPJLq2bGVobFo3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144689>

Am 11.04.2010 22:40, schrieb Johannes Sixt:
> A caller of start_command can set the member 'dir' to a directory to
> request that the child process starts with that directory as CWD. The first
> user of this feature was added recently in eee49b6 (Teach diff --submodule
> and status to handle .git files in submodules).
> 
> On Windows, we have been lazy and had not implemented support for this
> feature, yet. This fixes the shortcoming.

Thanks, I didn't know this was missing from the Windows port.
