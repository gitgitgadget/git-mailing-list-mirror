From: bigbear <urs.rau@gmail.com>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Sat, 21 Apr 2012 10:25:10 -0700 (PDT)
Message-ID: <1335029110871-7487506.post@n2.nabble.com>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 21 19:25:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLe3k-0002uQ-Lj
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 19:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375Ab2DURZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 13:25:12 -0400
Received: from sam.nabble.com ([216.139.236.26]:55230 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022Ab2DURZM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 13:25:12 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <urs.rau@gmail.com>)
	id 1SLe3b-0005IJ-Fl
	for git@vger.kernel.org; Sat, 21 Apr 2012 10:25:11 -0700
In-Reply-To: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196053>


Matthias Nothhaft wrote
> 
> Hi,
> 
> I'm new to Git but I really already love it. ;-)
> 
> I would like to have repository that transparently encrypts and
> decrypts all files using GPG.
> 
> What I need is a way to automatically modify each file
> 
> a) before it is written in the repository
> b) after it is read from the repository
> 
> Is there a way to get this work somehow? Can someone give me some
> hints where I need to begin?
> 
> regards,
> Matthias
> 
> 

Have come across this on my own search for an encrypted git repo. Matthias
it looks as if somebody has come up with a "working" system that uses the
'smudge & clean' filter features of git. 
Seems to me that to use it for storing the repo on a non trusted or possibly
public git repo with some private content in the files this seems to be a
workable solution.

Transparent Git Encryption
https://gist.github.com/873637
and/or possibly 
https://github.com/shadowhand/git-encrypt

The way to do this is to use git's "smudge" and "clean" filters, but it's
not necessarily recommended for reasons that are explained here by Junio C
Hamano, the maintainer of git:

    http://article.gmane.org/gmane.comp.version-control.git/113221






--
View this message in context: http://git.661346.n2.nabble.com/Transparently-encrypt-repository-contents-with-GPG-tp2470145p7487506.html
Sent from the git mailing list archive at Nabble.com.
