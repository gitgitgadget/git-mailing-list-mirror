From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: --first-parent plus path limiting
Date: Tue, 29 Jan 2008 10:18:32 +0100
Message-ID: <479EEF68.7080505@viscovery.net>
References: <479EE405.1010001@viscovery.net>	<7vk5ltow61.fsf@gitster.siamese.dyndns.org>	<479EEC3D.9030100@viscovery.net> <7v63xdov20.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 10:19:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJmcX-0000nL-0Z
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 10:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbYA2JSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 04:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753344AbYA2JSh
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 04:18:37 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:15610 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbYA2JSf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 04:18:35 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JJmbi-0002J3-4M; Tue, 29 Jan 2008 10:18:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 395166D9; Tue, 29 Jan 2008 10:18:32 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v63xdov20.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71972>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> I was expecting that it works like "First follow the first-parent, and
>> then simplify the history with respect to builtin-fetch.c."
> 
> If you first follow the first-parent, the result will by
> definition not have any merges, so there is nothing left to
> simplify.  History simplification is about merge removal,
> looking at all parents.
> 
> Removing commits from a single strand of pearls that do not
> touch the specified pathspecs is called "--dense" (which is on
> the default) and can be disabled with "--sparse".
> 
> So, no, it is not a matter of definition, as "first follow the
> first-parent then simplify" does not make much sense.

OK.

Is there a combination of options that does --first-parent on the full
history, but then --dense on the resulting strand of pearls with respect
to a certain path?

-- Hannes
