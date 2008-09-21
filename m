From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: ignoring files/directories in git
Date: Sun, 21 Sep 2008 20:19:18 +0300
Message-ID: <48D68216.1080404@panasas.com>
References: <19596152.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: mwolfe38 <mwolfe38@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 19:23:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhSf8-0007bg-2C
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 19:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbYIURT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 13:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbYIURT2
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 13:19:28 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:13776 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbYIURT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 13:19:28 -0400
Received: by ey-out-2122.google.com with SMTP id 6so331812eyi.37
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=xl+ZAT4XuBtXujijREX107WWslF/VDpj9k8IgJxIQWY=;
        b=cRc2WpiGlIkjzuDjZurZMNW5MKszYfB+1wgs3raPdARGCeN86bwV0uzCW4IxuwVOir
         kfByYi81DmKuTowZcx0pFFhXdft51N5JfJu2TJZGIKGk7gLB+LB7XHhZQv2wFDHH1iVH
         teLplwR3lINkRCONHLpBLn3SzhyFJi4+Dt28M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=Xtr9nLfiY5+A/VTtStqyBd8BLCE0CK98/H/5rhDG8LUJWw0XfON29RWgtzL8hMzwNf
         dq78eUsRs+p2JtkxO+xXA1tNTuBEDgHG3PfqDLhjCNi3Gso2taR4qPlbWKKr3aw8bVOd
         p21tVwzFyZi6C4BCgNCBiikzBNCZ28bSZQGVc=
Received: by 10.210.27.20 with SMTP id a20mr3581010eba.86.1222017565939;
        Sun, 21 Sep 2008 10:19:25 -0700 (PDT)
Received: from bh-buildlin2.bhalevy.com ( [212.235.53.3])
        by mx.google.com with ESMTPS id 10sm6008465eyd.6.2008.09.21.10.19.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 10:19:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <19596152.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96413>

mwolfe38 wrote:
> I'm working on a project by myself and using git mostly just to learn about
> it.
> In my project I have several directories I want to have git ignore. One of
> them being
> cache/ and the other log/
> I've added them to the .gitignore file which I have in the initial directory
> of the repository
> The contents of my gitignore are:
> 
> .settings
> .cache
> cache/
> log/

If I use "patches/" in my .gitignore file and then git-status 
then I get all these extra files in the "Untracked files:" section
but if I use plain "patches" (No slash at end) then it works. Sounds
like a bug to me but it sure is a workaround.

> .project
> 
> However, if I do 
> git add .
> It will add the files from cache and log anyways.
> I know git add . will add anything that hasn't been added but shouldn't it
> ignore files in .gitignore?
> If not, what is the point, I would just ignore them manually anyways. 
> The main reason i like doing git add .
> is because i'm using symfony php framework which makes good use of scripts
> which generates lots if initial files for you and thus adding one at a time
> would be a pain.
> 
> Any idea what might be going on here?  I thought maybe I had added those
> directories before putting them in .gitignore so i used git rm -r to remove
> them but they still show back up with doing git add .
> 
> Thanks in advance

Boaz
