From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: GSoC intro
Date: Wed, 21 Mar 2012 22:16:27 +0100
Message-ID: <11105663.xsXc2sBkNH@flobuntu>
References: <11292500.AVmZFUUvNi@flobuntu> <CAFfmPPPabm_H9f2Zr8eWc7Wxo6UDz-km_Vg8cc-O38XhGCrj7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 22:18:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SASvq-0001HZ-BL
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 22:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759114Ab2CUVSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 17:18:55 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:33164 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760247Ab2CUVSr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 17:18:47 -0400
Received: from flobuntu.localnet (m-149.vc-graz.ac.at [193.170.224.149])
	(authenticated bits=0)
	by mailrelay1.tugraz.at (8.14.4/8.14.4) with ESMTP id q2LLIP0D020124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 21 Mar 2012 22:18:26 +0100 (CET)
User-Agent: KMail/4.7.3 (Linux/3.0.0-16-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <CAFfmPPPabm_H9f2Zr8eWc7Wxo6UDz-km_Vg8cc-O38XhGCrj7Q@mail.gmail.com>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.3
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193619>

Hi!

After the exam today, I started to dig into the topic a little.
So I accumulated some questions ..

On Wednesday 21 March 2012 00:19:41 David Barr wrote:
> Much of the progress so far has been merged into master.
> Still outstanding are some of Dmitry's patches:
> remote-svn-alpha_v2 [1]
> svn-fe-options_v7 [2]

I tried to find svn-related parts in gits sources. I found:
 - the huge ./git-svn.perl, which seems to be the git-svn implementation.
 - ./contrib/svn-fe/ and ./vcs-svn/, 
those you pointed me at.
Did I miss something?
Is there any seperate source documentation? The source files I looked at 
contain only very few comments. And nothing about the big picture.
I built make doc, but it seems it's mostly user documentation.

> Yes, that's the plan. To be fair, it is a stretch goal. Two GSoC
> students have brought us as far as a read-only remote helper. So I
> think there's at least two summers' worth of work remaining.

What is the remote helper? How can I use/try it?
> [1] https://github.com/divanorama/git/tree/remote-svn-alpha_v2
Is it in here? Should my project continue on this work?
Until now, I've never used any remote that was not git.

> > About me and GSoC
> > In summer 2010 I participated in GSoC for hugin writing a
> > Makefile-creation library in C++, which is used to drive the panorama
> > creation [1]. It was a great experience and a cool, successful summer
> > job! ( and it was merged in hugin's master branch :-) )
> > 
> > [1] http://hugin.hg.sourceforge.net/hgweb/hugin/hugin/branches branch:
> > gsoc2010_makefilelib (unfortunately the web fronted doesn't display a
> > specific branch)
> 
> A track record is a plus.

If you like, I could provide more references, e.g. a university course project 
in C using git.

> Some extra reading:
> [...]
Haven't yet read it.

Hm, and there are still some general questions:
What about git-svn? Whats wrong with it? (I haven't used it) I saw the huge 
perl script, this looks a little extreme ;). But it provides bi-directional 
access?!

svn-fe reads a dump of the svn repo. How can this approach ever be 
bidirectional? Probably I've to do the extra reading first .. 

-- 
Florian 
