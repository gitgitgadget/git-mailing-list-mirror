From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] Add proper 'stage' command
Date: Thu, 29 Aug 2013 20:38:41 +0200
Message-ID: <vpq8uzks5ou.fsf@anie.imag.fr>
References: <20130829180129.GA4880@nysa>
	<1377799744-5201-1-git-send-email-felipe.contreras@gmail.com>
	<1377799744-5201-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:39:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF77R-0000y4-W5
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381Ab3H2Siy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:38:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56695 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844Ab3H2Six (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:38:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7TIce6a010413
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 20:38:40 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VF77C-00031l-26; Thu, 29 Aug 2013 20:38:42 +0200
In-Reply-To: <1377799744-5201-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 29 Aug 2013 13:09:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Aug 2013 20:38:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TIce6a010413
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378406324.7762@ZZURus4bouiv98Fw77HuJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233329>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +COMMANDS
> +--------
> +
> +With no arguments, it's a synonym for linkgit:git-add[1].

This would not be very useful since "git add" errors out when called
without arguments ;-).

The accurate description of your code would be closer to "When the first
argument is not a subcommand, it's a synonym for linkgit:git-add[1].".
I'm not sure I like it, as it creates ambiguities (e.g. need to spell
"git stage -- diff" to add a file called "diff". Not a strong objection
though, as we already have refs Vs filename ambiguities in many places.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
