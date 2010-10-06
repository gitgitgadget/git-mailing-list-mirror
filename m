From: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
Subject: Re: Error on git clone
Date: Wed, 6 Oct 2010 03:34:00 -0700 (PDT)
Message-ID: <571212.33119.qm@web114615.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 06 12:34:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3RK4-0001mD-U1
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 12:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532Ab0JFKeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 06:34:03 -0400
Received: from web114615.mail.gq1.yahoo.com ([98.136.183.80]:27891 "HELO
	web114615.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754217Ab0JFKeB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 06:34:01 -0400
Received: (qmail 33571 invoked by uid 60001); 6 Oct 2010 10:34:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1286361240; bh=XMeeoH0hWJIzLpXAhqGtCi4N/lgwCtg1GsTlHopa6eM=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type; b=wIh2u/b3Vd2Aa/1facmZCAHT45ifhc50inSSFyLpNlbCxJbapZ1wVNyAMuzsrU4Pt6VigHNZVNXr0m7t2GDCSnyt5BYWlhQOki0mEkvbwrDiL8RSuVX081jqzonie9YZw9ATBCzlMdDEy6r6hLsh4/lj4rbhzJYC/v4zdY9ON/E=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type;
  b=P1aTXN8wcK/lNoiBD52cE2rV9Kohb+awGDGiTDBg/vPra+tO+q/L2tEtgk4Kd1IYBsmZOvj4OLhuQp949rUEOvTctEzmpcQKd41JNIL09hM4V+YGw230rGY+AqQVbJj6x2JaKoRZAIFDX3AQQiNNv2wutrcGxjWgpgkDX2HTaJE=;
X-YMail-OSG: ZDmZRIUVM1neTx8qCaBSEQH66cevUzrpHmKZ9hYJ2fvYyde
 X6foWLUyBKo6COf2zcuM1Y_FWaBT.0ujfW1ctoNnLoKbpBLDgMEShp1rkx1U
 zaLbZURCUa14mjDKKDpvx8XBLARGsFuy3MOqEFbGGPsbreJQ4HjdRhQoeNGI
 .Cocq7NMnUd8DagPkXsrjJy2zBGThMLuI9lEI.sEGstx8jR7UIOGdRF7cuEj
 Wrnx9fWCQxFBkWP0VlhorPw9RvLCpMciRAWXWlIeWPXzaGEICGAwV98X1vCM
 8XNmnz__msA8i5I2i
Received: from [76.83.7.252] by web114615.mail.gq1.yahoo.com via HTTP; Wed, 06 Oct 2010 03:34:00 PDT
X-Mailer: YahooMailRC/497 YahooMailWebService/0.8.105.279950
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158279>


Thanks to Sverre Rabbelier who reminded me to do a 'git init' to get rid of that 
"Not a git repository' error.  So I did:

$ mkdir sss3
$ cd sss3
$ git init
$ git remote add origin git@github.com:XXX/YYY.git
$ git fetch
Enter passphrase for key 'C:\.....\privateKey':
remote: Counting objects: 478, done.
remote: Compressing objects: 100% (303/303), done.
Receiving objects: 100% (478/478), 96.57 MiB | 166 KiB/s, done.
Resolving deltas: 100% (21/21), done.
From github.com:XXX/YYY
 * [new branch]      master     -> origin/master
$ git checkout -b master origin/master
Checking out files: 43%
tagging': Invalid argumenttory at 'public/images/tagging

I'm still getting the same print over error messages. Thanks for any help that 
might help me to resolve this perplexing problem.
Hoca





----- Original Message ----
From: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
To: Johannes Sixt <j.sixt@viscovery.net>
Cc: git@vger.kernel.org
Sent: Wed, October 6, 2010 12:50:13 AM
Subject: Re: Error on git clone


Yes, this is with "Git for Windows" (a Git Bash Shell window).

So I did what you suggested:

mkdir sss3
cd sss3
git remote add origin git@github.com:XXX/YYY.git

Then an error occurs:
fatal: Not a git repository (or any of the parent directories): .git

Any thoughts?

Thanks.
Hoca




----- Original Message ----
From: Johannes Sixt <j.sixt@viscovery.net>
To: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
Cc: git@vger.kernel.org
Sent: Wed, October 6, 2010 12:22:28 AM
Subject: Re: Error on git clone

Am 10/6/2010 10:13, schrieb Hocapito Cheteamo:
> I could consistently reproduce the problem.  The command that I used is:
>     git clone -v git@github.com:XXX/YYY.git sss
> where XXX & YYY are replaced with the actual data.

Just to make sure: This is with "Git for Windows", not Cygwin's git?

Do the clone in separate the steps:

mkdir sss
cd sss
git remote add origin git@github.com:XXX/YYY.git
git fetch
git checkout -b master origin/master

Do you see any errors?

-- Hannes


      
