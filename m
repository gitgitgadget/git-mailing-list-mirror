From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [ANNOUNCE qgit-0.94]
Date: Sun, 11 Sep 2005 01:10:20 -0700 (PDT)
Message-ID: <20050911081020.27248.qmail@web26303.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 10:11:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEMuw-0006yy-LB
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 10:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVIKIKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 04:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVIKIKW
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 04:10:22 -0400
Received: from web26303.mail.ukl.yahoo.com ([217.146.176.14]:35994 "HELO
	web26303.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750748AbVIKIKV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 04:10:21 -0400
Received: (qmail 27250 invoked by uid 60001); 11 Sep 2005 08:10:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fAoOLUKh4E0zElk+5jvc3nBLLVr+XsEfpa56YLPvhEf2dpDX2eDy78z41ae1ZVSW7AZBuBfaH3uBqQ/kMbj76dLD7lyzQ1nZIPXEGEoKIqK0hNB+i5LPOmqEjrIUKc8DecOpBV8FNslV3WaIHwkkjr1lS4nmqQGiUbk7SJYvU20=  ;
Received: from [151.42.200.67] by web26303.mail.ukl.yahoo.com via HTTP; Sun, 11 Sep 2005 01:10:20 PDT
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8274>

Junio C Hamano wrote:

>
>You do not seem to have the following files there:
>
>    ~mcostalba/qgit.git/info/refs
>    ~mcostalba/qgit.git/objects/info/packs 
>
>which explains why git-fetch and git-clone do not slurp from
>there (they think the repository is broken).
>
>These files are necessary if you publish your repository over
>http for any serious use (i.e. other than only letting people
>slurp from HEAD, known branches and/or tags, without allowing
>discovery).  Especially on a site like digilander.libero.it/
>which does not give directory index, peek into what branches
>you have by looking in ~mcostalba/qgit.git/refs/ hierarchy would
>not even work, and that is the reason why you need to have these
>files to help the downloaders.
>

Thanks, I will put the files.

Please, there is some doc where is explained how to convert a git-init-db 
created archive to a 'serious' one ;-) ?

What is the proper way of doing it?

Thanks
Marco


P.S: Due to a subtle but nasty bug that I found too late I have upgraded the release to
qgit-0.94.1 I strongly suggest to upgrade.

I am very sorry for this.



	
		
______________________________________________________ 
Yahoo! for Good 
Watch the Hurricane Katrina Shelter From The Storm concert 
http://advision.webevents.yahoo.com/shelter 
