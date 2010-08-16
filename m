From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Questions for "Git User's Survey 2010" - features used, features wanted
Date: Mon, 16 Aug 2010 08:51:52 +0200
Message-ID: <vpqy6c7uk1j.fsf@bauges.imag.fr>
References: <201008152357.29889.jnareb@gmail.com>
	<20100815221327.GB2666@burratino>
	<201008160051.23283.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 08:52:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OktYE-0004U2-Hj
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 08:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab0HPGv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 02:51:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36663 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609Ab0HPGv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 02:51:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o7G6n96H029743
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Aug 2010 08:49:09 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OktY1-0001QG-0y; Mon, 16 Aug 2010 08:51:53 +0200
In-Reply-To: <201008160051.23283.jnareb@gmail.com> (Jakub Narebski's message of "Mon\, 16 Aug 2010 00\:51\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 16 Aug 2010 08:49:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7G6n96H029743
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1282546153.6011@16lByb9pRkWBbIrZk8Of8A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153651>

Jakub Narebski <jnareb@gmail.com> writes:

>> > 16. Which of the following features would you like to see implemented
>> >     in git?
>> [...]
>> >  + environmental variables in config, expanding ~ and ~user
>> 
>> I think we have ~ and ~user now.
>
> Thanks, will fix.

To be more precise, Git knows how to expand ~ and ~user (that's
git_config_pathname() in C, and "git config --path" from the
command-line), and does it for some configuration variables
(core.excludesfile for example).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
