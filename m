From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: staging specific lines out of a hunk for a commit
Date: Tue, 21 Sep 2010 13:31:11 +0200
Message-ID: <vpqocbrjpts.fsf@bauges.imag.fr>
References: <AANLkTin4U78N_8LV8fCWuinNH9AFeOsRBjnvHM0qt2ZH@mail.gmail.com>
	<AANLkTim=FQyBHcaHEX92YLgODrvpesuA7e4xwXuWcFg4@mail.gmail.com>
	<AANLkTinJRT7x-TS0R1C00-djVk3rKOt_Axys+orBhZfx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 13:31:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy14D-0003sW-UH
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 13:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157Ab0IULbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 07:31:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52337 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab0IULbP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 07:31:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o8LBQa0w022330
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 21 Sep 2010 13:26:36 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oy144-000154-32; Tue, 21 Sep 2010 13:31:12 +0200
In-Reply-To: <AANLkTinJRT7x-TS0R1C00-djVk3rKOt_Axys+orBhZfx@mail.gmail.com> (Graeme Geldenhuys's message of "Tue\, 21 Sep 2010 13\:00\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 21 Sep 2010 13:26:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8LBQa0w022330
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1285673197.90138@qxeRI2fFCmsYifqOxRLnVg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156712>

Graeme Geldenhuys <graemeg.lists@gmail.com> writes:

> On 21 September 2010 12:52, Bert Wesarg wrote:
>>
>> Just select the lines you would like to add, and than you can stage
>> them at once.
>
> I tried that last night on my home laptop and it didn't work. Trying
> it now at work, it indeed does work. Clearly my git versions are
> different - when I thought they were the same. Thanks for the help.

Otherwise, "git add -p", 'e' for 'e'dit, and delete the parts you
don't want.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
