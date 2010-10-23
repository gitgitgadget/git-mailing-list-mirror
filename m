From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 08/10] Use 'remote-tracking branch' in generated merge messages
Date: Sat, 23 Oct 2010 21:53:46 +0200
Message-ID: <vpqiq0sk7n9.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1287851481-27952-9-git-send-email-Matthieu.Moy@imag.fr>
	<20101023190441.GK21040@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 21:58:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9kEi-0000Li-SP
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 21:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758459Ab0JWT4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 15:56:40 -0400
Received: from imag.imag.fr ([129.88.30.1]:36743 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758358Ab0JWT4k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 15:56:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o9NJrkeZ019606
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 23 Oct 2010 21:53:47 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P9k9y-0008CC-N2; Sat, 23 Oct 2010 21:53:46 +0200
In-Reply-To: <20101023190441.GK21040@burratino> (Jonathan Nieder's message of "Sat\, 23 Oct 2010 14\:04\:41 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 23 Oct 2010 21:53:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159824>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> [Subject: [PATCH 08/10] Use 'remote-tracking branch' in generated merge messages]
>
> Maybe this should be squashed with the corresponding "git fetch" hunk
> in 7/10 for bisectability.

Actually, the "git fetch" hunk is not directly used by fmt-merge-msg,
it is parsed, and re-pretty-printed. I'm not sure I understood all the
details of the code, but the tests do pass between patch 7 and patch
8.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
