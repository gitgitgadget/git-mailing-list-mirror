From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: SVN -> Git *but* with special changes
Date: Wed, 28 Sep 2011 19:44:24 +0200
Message-ID: <vpq62kc36kn.fsf@bauges.imag.fr>
References: <16808473.33899.1317229852319.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Abscissa <bus_nabble_git@semitwist.com>, git@vger.kernel.org
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 19:45:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8yBo-0005c3-3V
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 19:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633Ab1I1Roj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 13:44:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36561 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104Ab1I1Roi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 13:44:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p8SHgCWi013140
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Sep 2011 19:42:12 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R8yBF-0006IE-53; Wed, 28 Sep 2011 19:44:25 +0200
In-Reply-To: <16808473.33899.1317229852319.JavaMail.root@mail.hq.genarts.com>
	(Stephen Bash's message of "Wed, 28 Sep 2011 13:10:52 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Sep 2011 19:42:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8SHgCWi013140
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1317836534.04608@hQ6Cn57dJBzyiH5ryEx9hQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182350>

Stephen Bash <bash@genarts.com> writes:

>> 2. Keeping binary files in version control isn't a big deal because
>> the whole repo doesn't get copied to everyone's system or use up 
>> people's GitHub storage space.
>
> I'd eliminate these on the SVN side before converting to Git. If you
> have svnadmin access to the SVN repo svnadmin dump, svndumpfilter,
> svnadmin load is a pretty easy process.

Otherwise, you can do it on the Git side with:

  git filter-branch --tree-filter 'rm -f some-large-blob'

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
