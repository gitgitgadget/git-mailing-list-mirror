From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] simplified the chain if() statements of  install_branch_config() function in branch.c
Date: Mon, 10 Mar 2014 10:05:49 +0100
Message-ID: <vpqha76e842.fsf@anie.imag.fr>
References: <loom.20140310T083649-236@post.gmane.org>
	<loom.20140310T085652-521@post.gmane.org>
	<vpqd2huihsc.fsf@anie.imag.fr> <loom.20140310T094407-5@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Nemina Amarasinghe <neminaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 10:06:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMwAB-0004P2-Po
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 10:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbaCJJGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 05:06:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49208 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349AbaCJJGL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 05:06:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2A95nq3020194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Mar 2014 10:05:49 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2A95nSK017453;
	Mon, 10 Mar 2014 10:05:50 +0100
In-Reply-To: <loom.20140310T094407-5@post.gmane.org> (Nemina Amarasinghe's
	message of "Mon, 10 Mar 2014 08:51:05 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Mar 2014 10:05:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2A95nq3020194
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395047152.99077@rMpAL35OnIWD07gRbeWLLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243717>

Nemina Amarasinghe <neminaa@gmail.com> writes:

>> 
>> Nemina Amarasinghe <neminaa <at> gmail.com> writes:
>> 
>> Is it me, or is (origin || !origin) a tautology?
>> 
> Thanks for the advices Matthieu. I will go through the documentations again. 
> Is there anything wrong with my logic? 
> What I wanted to express is
> ((!remote_is_branch && origin) || (!remote_is_branch || !origin))

(The second || should be a && in this sentence)

I'm not saying your rewrite is incorrect, but there's no reason to keep
(origin || !origin) in a logical formula.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
