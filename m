From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 13:58:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903111353340.10498@intel-tinevez-2-302>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de> <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 14:00:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhO33-0005c2-Dm
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 14:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871AbZCKM6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 08:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755810AbZCKM6P
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 08:58:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:48631 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754372AbZCKM6O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 08:58:14 -0400
Received: (qmail invoked by alias); 11 Mar 2009 12:58:10 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp065) with SMTP; 11 Mar 2009 13:58:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1W40EKV71PwMq67fvr9HZR6Kt0YNAgbozI69bfJ
	V8gj3sAz/2PpE3
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112924>

Hi,

On Wed, 11 Mar 2009, saurabh gupta wrote:

> On Wed, Mar 11, 2009 at 5:28 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Wed, 11 Mar 2009, Saurabh Gupta wrote:
> >
> > > /*About GSoC GIT ideas; */Here are the ideas which I found to be 
> > > interested in. Although, I would like to discuss any other idea than 
> > > these in GIT organization.
> > >
> > > *1) Domain specific merge helpers* Intelligence in the merger can be 
> > > put which modifies the source file according the format. Different 
> > > file formats can be put in the merger to support.
> >
> > You said that you are interested in this project, but from your mails 
> > I do not see what are the specific reasons why.
> 
> All right. May be I lacked in my mail to specify the reason for my 
> interest.

Oh, sorry, I did not mean to imply any offense...

> The reason is that from my past experience, I got the notion that this 
> project is according to my interest and is doable in the three months 
> time period.
>
> Another reason is that I have been using the versioning tools like svn 
> and now perforce for a long time and this added up to my interest.

Sounds good!

> > IMHO this project can only fly if you have a specific file format that 
> > you absolutely want to be able to merge; otherwise, it will be an 
> > uphill fight.
> 
> Well, as suggested on the wiki, I would like to work on the xml file 
> formats as I have quite experience of working with xml files and parsing 
> them using msxml and nsxml libraries and some of personal wrappers.

As I am known to not exactly like Microsoft's products, if you wanted to 
have me as a mentor, you'd need to use Open Source libraries to do the 
parsing.

> How about my idea of making the support of new file formats in the 
> plug-ins (suggested in my last post).

Sorry, I missed that idea.  Could you describe it again?

> > Personally, I would _love_ to see a good graphical tool (maybe written 
> > in Tcl/Tk) to help merging conflicts in LaTeX files, but I just do not 
> > have the time...
> 
> Ok. What I am thinking is to implement something  like that of
> graphical *diff* command output but in these special file formats, it
> ought to have intelligence to bring out the difference of two files
> (like latex or xml) in a readable manner. For example, in case of xml
> files, if one file contains an inner tag block , then merger GUI
> should notify the user in a readable manner about this added tag
> rather than only the difference in lines.

A diff would be a first step, but the real issue are the merge helpers.  
And they need first and foremost a thought-through user interface design.  
The technical issues are all solveable, I am sure.

Ciao,
Dscho
