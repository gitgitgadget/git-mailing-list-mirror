From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Cogito Tutorial If It Helps
Date: Wed, 27 Apr 2005 19:22:07 +0100
Message-ID: <200504271922.07765.alan@chandlerfamily.org.uk>
References: <1114548747.3083.1.camel@kryten>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 27 20:18:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQr5j-0000aq-B5
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 20:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVD0SWQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 14:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVD0SWQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 14:22:16 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:22749
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S261926AbVD0SWI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 14:22:08 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1DQrAm-0005gp-4d
	for git@vger.kernel.org; Wed, 27 Apr 2005 19:22:08 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8
In-Reply-To: <1114548747.3083.1.camel@kryten>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 26 April 2005 21:52, James Purser wrote:
> I reworked the previous tutorial to take in the changes in the scripts.
> Will make this a series of tutorials to cover all aspects. Any
> suggestions or hints or spelling corrections would be most welcome.
>
> http://ksit.dynalias.com/articles.php?s_id=46&art_id=41

Although I have been reading this mailing list since almost the beginning, I 
have not had a chance to download and try anything.  Using this message as an 
incentive to start, I started to follow this.

However I have run into problems.  

Let me try and explain.

The first part of the tutorial of loading the tarball and building things is 
fine (should be, its a well trodden mental model) - and actually for me I did 
not have libcurl3-dev installed the first time - but because I already had 
the mental model in my mind on this stage it was easy to fit.

I then issued the cg-clone command to get a fresh copy of cogito.  This is 
where I think it would be useful to take time-out from the tutorial and 
explain what I have here.  For me at least, if I don't have a mental model of 
what is happening, I am totally confused.

I "think" I understand the git repository with the various content addressable 
objects.  Reading the README file describes that quite well.  I assume that 
is what is stored in the .git subdirectory (although I have yet to find any 
text that formally says that).

Where I am confused is the relationship between what is in the .git 
subdirectory and the project tree of cogito that sits around it.  Obviously I 
understand that its the latest version of the project as represented by the 
objects in the repository, but what I don't really understand (and neither 
your tutorial nor all the explanations of each of the commands in the README 
really explain it either) is how the various commands adjust the 
relationship.

For instance cg-branch-add seems to add a branch to the repository from a url 
(I assume it downloads any "blobs" etc that are not already in my local 
repository and creates a tag that identifies the head of a tree object), but 
a don't understand how I am supposed see that particular branch as expanded 
code.  (I suspect it might be cg-seek, but I am not really sure - and if it 
is how do you find out what branch this expanded code is now pointed to?).  
But what do cg-update and cg-pull do in terms of the uncompressed code 
sitting in the surrounding directory round the repository, particularly when 
you perform them on a branch that is not the one that the code refers to.  


The reason I raise all this, is when I follow through on your tutorial and get 
to the cg-diff stage I get this

xargs: cg-Xdiffdo: No such file or directory

And I have absolutely no idea whats wrong or where to start looking.



-- 
Alan Chandler
http://www.chandlerfamily.org.uk
