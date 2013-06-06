From: =?UTF-8?B?Q8OpbGVzdGluIE1hdHRl?= <celestin.matte@ensimag.fr>
Subject: Re: git diff bug?
Date: Thu, 06 Jun 2013 23:42:14 +0200
Message-ID: <51B10236.2030009@ensimag.fr>
References: <CANd8icJ_1mqT9m-n3wPPdjzG1oNjwxfQeUA6YL6KVxbq0iEa1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Sarma Tangirala <vtangira@buffalo.edu>
X-From: git-owner@vger.kernel.org Thu Jun 06 23:42:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukhwt-0005R5-Pz
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 23:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab3FFVmT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 17:42:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41849 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908Ab3FFVmT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 17:42:19 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r56LgAYA022951
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Jun 2013 23:42:10 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r56LgCT8022616;
	Thu, 6 Jun 2013 23:42:12 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r56LgCSX010091;
	Thu, 6 Jun 2013 23:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CANd8icJ_1mqT9m-n3wPPdjzG1oNjwxfQeUA6YL6KVxbq0iEa1g@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 06 Jun 2013 23:42:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r56LgAYA022951
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371159730.89439@AJzgd43+kb+yAovUJQfr9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226565>

Le 06/06/2013 23:26, Sarma Tangirala a =C3=A9crit :
> Hello All,
>=20
> If I did 'git diff HEAD^..HEAD -- file' should git not report some
> kind of warning if it could not match the file? For example, if 'file=
'
> were infact 'dir/file' and 'file' were unique, would it not be a good
> idea to report that in the present working directory 'file' were not
> found but 'dir/file' were a match?

I don't know any program doing such a thing, and I don't think it is th=
e
role of the program to predict which file the user actually wanted to
provide in the command line.
That would imply looking for files with the same name or a close name i=
n
the current directory and its subdirectories - and maybe even in the
superdirectory? It is hard to decide when you have to stop looking for
the file.
