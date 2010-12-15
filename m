From: Scott Johnson <scottj75074@yahoo.com>
Subject: Re: [PATCH 0/4] --word-regex sanity checking and such
Date: Wed, 15 Dec 2010 12:48:50 -0800 (PST)
Message-ID: <254678.14296.qm@web110704.mail.gq1.yahoo.com>
References: <561247.22837.qm@web110707.mail.gq1.yahoo.com> <cover.1292424926.git.trast@student.ethz.ch> <913156.57703.qm@web110711.mail.gq1.yahoo.com> <201012152051.15159.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 15 21:49:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSyHj-0003WQ-EQ
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 21:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237Ab0LOUsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 15:48:53 -0500
Received: from nm26-vm1.bullet.mail.sp2.yahoo.com ([98.139.91.231]:26782 "HELO
	nm26-vm1.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752749Ab0LOUsv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Dec 2010 15:48:51 -0500
Received: from [98.139.91.63] by nm26.bullet.mail.sp2.yahoo.com with NNFMP; 15 Dec 2010 20:48:50 -0000
Received: from [98.139.91.35] by tm3.bullet.mail.sp2.yahoo.com with NNFMP; 15 Dec 2010 20:48:50 -0000
Received: from [127.0.0.1] by omp1035.mail.sp2.yahoo.com with NNFMP; 15 Dec 2010 20:48:50 -0000
X-Yahoo-Newman-Property: ymail-5
X-Yahoo-Newman-Id: 581805.67425.bm@omp1035.mail.sp2.yahoo.com
Received: (qmail 14547 invoked by uid 60001); 15 Dec 2010 20:48:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1292446130; bh=UsX37XHyFpEHPwW25zSl23sp0UTZxsD8Mr3oopxwqOQ=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=Ldjk7SSPySDgN9N98sEZPFTnqkLnOyZcvvNuGJJSnuHQXGODnbfKHQYBoSJds6X/5aDpMPCJtnDWmcOsPvZ2Rpaua0ZUScyF5s2XltKM8MPq4ZGodaaf9mYX0P2eaZjFGzWXWyOXOrRlMpzX6mYmme8YANI6UEZAoIxnJZ7bRzo=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=HnNZafx0VkEUzi3Sg1auwKUOnwZdebI3OJiXD8LmnpjcUxhPhgsdCgEmkACCFQzPyFwM4lDLZE38O17Qmp4ahoZCjpCNncSsfhjsNA7spiDV+b7kvQbP9cdajYVeTBO+5Q5wS9QR9AFxMC6oN0O4FTqium4HHd0LVnHE57p58nc=;
X-YMail-OSG: 6WIkLKgVM1nRRiFMX7431FH.7Bn59XTTgpdLqOetV_SxrDg
 zwj2L4w.W8OD6Dqb21ZA3iscaRI6dm1l228tfNKeOKS7ChFU0kbsnwnPy7Cx
 Jklzn..ptK4snUv6I2sanclQPOsLK2fc2UAdCPu3cs4Enfkp5JGY7Vz_Ctwv
 toA2EwreDb4XtB9MQ7AMjDuagJsIcTnJzGjPCj6avGbpMIWtIm_udeWVojGP
 u_tuSvCBQrIlDTuLbv4K3BEnCUYV9DKHEyxmYc8KXBhwJbIzRp9SpTtlawD.
 x4PtcsJedYv8Z7ktVlmv4UWFjQiZo6wl6M3aS21a1sjM35Uhw8zeutt1Fzoc
 2o8I51mYzyXEi7nM3CAdPAXrX43rp32qib66kxo2fHojZ59rbbfacOpgrBRa
 2LYSYVgLLCJw2qm6rGg--
Received: from [99.189.91.206] by web110704.mail.gq1.yahoo.com via HTTP; Wed, 15 Dec 2010 12:48:50 PST
X-Mailer: YahooMailRC/553 YahooMailWebService/0.8.107.285259
In-Reply-To: <201012152051.15159.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163791>

Turns out to be system-dependent. I built v1.7.3.3 from source on three 
different boxes and only one of them is broken.


The /etc/redhat-release shows:

Broken:
Fedora Core release 6 (Zod)

Correct:
Red Hat Enterprise Linux WS release 4 (Nahant Update 6)
Fedora release 9 (Sulphur)

So I guess that means the problem is in some library that has most likely been 
fixed since Fedora 6.



----- Original Message ----
From: Thomas Rast <trast@student.ethz.ch>
To: Scott Johnson <scottj75074@yahoo.com>
Cc: Michael J Gruber <git@drmicha.warpmail.net>; Matthijs Kooijman 
<matthijs@stdin.nl>; git@vger.kernel.org
Sent: Wed, December 15, 2010 11:51:14 AM
Subject: Re: [PATCH 0/4] --word-regex sanity checking and such

Scott Johnson wrote:
> I've attached a pre and post with the complete file that is showing this 
> problem. I hope you'll be able to reproduce the issue with this.

I can't reproduce.  I did this:

  $ ls -l
  total 16
  -rw-r--r-- 1 thomas users 2128 2010-12-15 20:42 post.html
  -rw-r--r-- 1 thomas users 2354 2010-12-15 20:42 pre.html
  $ echo '*.html diff=html'  >.gitattributes
  $ git diff --no-index pre.html post.html
  diff --git 1/pre.html 2/post.html
[...]
  -        <li class="ydn-patterns"><em></em><a href="#">ydn-patterns</a></li>
  -        <li class="ydn-mail"><em></em><a href="#">ydn-mail</a></li>
  -        <li class="yws-maps"><em></em><a href="#">yws-maps</a></li>
  -        <li class="ydn-delicious"><em></em><a href="#">ydn-delicious</a></li>
  -        <li class="yws-flickr"><em></em><a href="#">yws-flickr</a></li>
  -        <li class="yws-events"><em></em><a href="#">yws-events</a></li>
  +        <li><em></em><a href="#">ydn-patterns</a></li>
  +        <li><em></em><a href="#">ydn-mail</a></li>
  +        <li><em></em><a href="#">yws-maps</a></li>
  +        <li><em></em><a href="#">ydn-delicious</a></li>
  +        <li><em></em><a href="#">yws-flickr</a></li>
  +        <li><em></em><a href="#">yws-events</a></li>
         </ul>
       </div><!-- wrap -->
     </div><!-- folder_list -->
  $ git diff --word-diff --no-index pre.html post.html
  diff --git 1/pre.html 2/post.html
[...]
          <li[-class="ydn-patterns"-]><em></em><a href="#">ydn-patterns</a></li>
          <li[-class="ydn-mail"-]><em></em><a href="#">ydn-mail</a></li>
          <li[-class="yws-maps"-]><em></em><a href="#">yws-maps</a></li>
          <li[-class="ydn-delicious"-]><em></em><a 
href="#">ydn-delicious</a></li>
          <li[-class="yws-flickr"-]><em></em><a href="#">yws-flickr</a></li>
          <li[-class="yws-events"-]><em></em><a href="#">yws-events</a></li>
        </ul>
      </div><!-- wrap -->
    </div><!-- folder_list -->

That's running bleeding-edge git, like I always do, but the userdiff
stuff hasn't changed in ages.

What does

  git config diff.html.wordregex

say on your system?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
