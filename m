From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Wed, 11 Mar 2009 17:41:36 +0530
Message-ID: <ab9fa62a0903110511u63e7d46dr3bb783ee891ca4ae@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 13:13:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhNJ6-0005i2-GS
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 13:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbZCKMLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 08:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755217AbZCKMLk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 08:11:40 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:53050 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078AbZCKMLj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 08:11:39 -0400
Received: by yw-out-2324.google.com with SMTP id 5so482476ywh.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=990DMC4FvP3ZrScdNERQiSpjMSyjq7z7xyTVSN0QoXQ=;
        b=nJz8CAwtfAAc4piCaDR6vxttOIqeCK/It1HL1QWDcH7aHFDfwOP4/C0OmYfNgJgKDU
         9GTcyPLQD6ahGdG9eDFLDm2psvq/yx11h31DnnTEt2yTIh+/CKKQBhjjgsynuS/68cwP
         qbrr2Gd0MZSV2WA1VA+rl67pujuhhTo1BqJ5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ck/8O+VFhzgHbciqJKiVNLkC5xRW0QErgZcVJ3GuY2bBCBk0S8VQJUKocYgFt+bYFZ
         t+G6dYSEzF3OrJg3vSAlBhydWkg15BDafW8kQIgfnpEQec2Tx0vK7lfNd9DjPUA+ukVx
         dAVIegqopZar019seG50qD1ufPk3V9N6pL9EA=
Received: by 10.231.19.204 with SMTP id c12mr1963446ibb.55.1236773496396; Wed, 
	11 Mar 2009 05:11:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903111255470.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112919>

On Wed, Mar 11, 2009 at 5:28 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> Welcome, Saurabh!
>
> On Wed, 11 Mar 2009, Saurabh Gupta wrote:
>
> > /*About GSoC GIT ideas; */Here are the ideas which I found to be
> > interested in. Although, I would like to discuss any other idea than
> > these in GIT organization.
> >
> > *1) Domain specific merge helpers* Intelligence in the merger can be put
> > which modifies the source file according the format. Different file
> > formats can be put in the merger to support.
>
> You said that you are interested in this project, but from your mails I do
> not see what are the specific reasons why.
>

All right. May be I lacked in my mail to specify the reason for my
interest. The reason is that from my past experience, I got the notion
that this project is according to my interest and is doable in the
three months time period.
Another reason is that I have been using the versioning tools like svn
and now perforce for a long time and this added up to my interest.


> IMHO this project can only fly if you have a specific file format that you
> absolutely want to be able to merge; otherwise, it will be an uphill
> fight.
>

Well, as suggested on the wiki, I would like to work on the xml file
formats as I have quite experience of working with xml files and
parsing them using msxml and nsxml libraries and some of personal
wrappers.

How about my idea of making the support of new file formats in the
plug-ins (suggested in my last post). I would like to discuss more on
this and any new suggestions or methods are welcome.

> Personally, I would _love_ to see a good graphical tool (maybe written
> in Tcl/Tk) to help merging conflicts in LaTeX files, but I just do not
> have the time...

Ok. What I am thinking is to implement something  like that of
graphical *diff* command output but in these special file formats, it
ought to have intelligence to bring out the difference of two files
(like latex or xml) in a readable manner. For example, in case of xml
files, if one file contains an inner tag block , then merger GUI
should notify the user in a readable manner about this added tag
rather than only the difference in lines.

>
> Ciao,
> Dscho
>

Regards...

--
Saurabh Gupta
Senior,
NSIT,New Delhi, India
