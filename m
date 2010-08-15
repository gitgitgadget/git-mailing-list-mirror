From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] git-rebase--interactive.sh: use printf instead of echo to print commit message
Date: Sun, 15 Aug 2010 10:56:21 +0200
Message-ID: <vpqmxso45l6.fsf@bauges.imag.fr>
References: <D1A252AE-5D4C-4E51-9359-F4A443BB8A2E@silverinsanity.com>
	<vFgTzGXLhalxcMpLoOFhqi1W6sU5I3lJ9CWjrrJjoRmkMjHSswmpLXU2vVL8PS5JJNEO727l9q8@cipher.nrlssc.navy.mil>
	<4BE6DADC-6846-4942-B361-639DCD308F09@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, avarab@gmail.com,
	gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 17:35:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkfEp-0003uw-VG
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 17:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757623Ab0HOPfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 11:35:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48391 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755715Ab0HOPe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 11:34:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7F8jIY9032023
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 15 Aug 2010 10:45:18 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OkZ0w-0003V5-04; Sun, 15 Aug 2010 10:56:22 +0200
In-Reply-To: <4BE6DADC-6846-4942-B361-639DCD308F09@silverinsanity.com> (Brian Gernhardt's message of "Fri\, 13 Aug 2010 17\:34\:07 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 15 Aug 2010 10:45:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7F8jIY9032023
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1282466722.01693@slBqXmy+KHGSMpjac7gElA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153603>

Brian Gernhardt <benji@silverinsanity.com> writes:

> On Aug 13, 2010, at 4:47 PM, Brandon Casey wrote:
>
>> Replace the echo statements that operate on $rest with printf's to restore
>> what was lost from 938791cd.  This avoids any mangling that XSI-conformant
>> echo's may introduce.
>
> ACK, this was exactly the problem.  Thanks for the quick response!

Both patches sound good, yes.

Junio: I think you can either apply them on top of mine, or squash
them all together.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
