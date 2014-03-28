From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 7/8] ls-files: support --max-depth
Date: Fri, 28 Mar 2014 14:52:18 +0100
Message-ID: <vpqtxaiqvl9.fsf@anie.imag.fr>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
	<1395310551-23201-8-git-send-email-pclouds@gmail.com>
	<1457323768.788823.1395737758945.JavaMail.zimbra@imag.fr>
	<CACsJy8Awu6oNOS-m5_DNh_HGeHKgcnowUY+iz4efo3s1HYycnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 14:52:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTXD5-0000ig-Tr
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 14:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbaC1NwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 09:52:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54347 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080AbaC1NwX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 09:52:23 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2SDqH7U025696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 28 Mar 2014 14:52:17 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2SDqIX8013655;
	Fri, 28 Mar 2014 14:52:18 +0100
In-Reply-To: <CACsJy8Awu6oNOS-m5_DNh_HGeHKgcnowUY+iz4efo3s1HYycnQ@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 25 Mar 2014 18:15:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 28 Mar 2014 14:52:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2SDqH7U025696
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1396619538.10798@AKNeAAxQeqkxNBdxMn1gDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245388>

Duy Nguyen <pclouds@gmail.com> writes:

> I'd rather go with no trailing slash by default and add -F (which
> seems to be more than just '/')

... and then add a configuration variable to let users enable it by
default.

For GNU ls, I have "alias ls='ls -F --color=auto'" in my shell's
configuration, but I cannot push the analogy by aliasing "git ls"
because Git doesn't allow aliasing existing commands.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
