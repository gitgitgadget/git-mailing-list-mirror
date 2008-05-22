From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: git gui: Possible to see which commands are executed?
Date: Thu, 22 May 2008 21:55:57 +0100
Message-ID: <320075ff0805221355y6d5dd4dcgdd12fad9582ea588@mail.gmail.com>
References: <48301B17.30309@dirk.my1.cc> <20080519022125.GV29038@spearce.org>
	 <4833206E.1080300@dirk.my1.cc> <20080520194403.GC29038@spearce.org>
	 <bd6139dc0805201305k61807561k8026b4c6509e4041@mail.gmail.com>
	 <20080520201722.GF29038@spearce.org>
	 <bd6139dc0805201322r6c8dae8cy45d31af6c25fd25a@mail.gmail.com>
	 <20080520203153.GH29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 22 22:58:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzHr8-0008E7-QG
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 22:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757826AbYEVU4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 16:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756115AbYEVU4x
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 16:56:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:9419 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426AbYEVU4w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 16:56:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so186629fgg.17
        for <git@vger.kernel.org>; Thu, 22 May 2008 13:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0IKhLsNuzM3RAhwNu9iwFqlI4aNx1jgPEb7ayfZWgpg=;
        b=tjh3YDSHMsDLhR/M+ScJT455OYsYAMJaLVRm0cyfHybmiyvSA5fXIrt2w9cxIGulp3nhKIAA9Rt/G0wC/7N8xBnZeuWQW8lBTtd2KL1KHKVPyvy+FsokmgNunW8uKHhIGFju7qlP4kNJ8dBy3lmMniurz4fsdzWJF70WqWQIbHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DcCktXUBtY5bArFePE3fDHtBCxmOTeX1AxciCN9lSDfOKlZm0Dmik1dvxqvvkFs3QxJgwgK34HQxt+2n1A/M5ErSIM4iUMgZEMH4gi9LcfXktlluVMiWba9co5we4O6QUtzA7rCh45sme6sey/S3NkrOtZ00ha0FepD69o4vHsw=
Received: by 10.82.157.6 with SMTP id f6mr47911bue.5.1211489757191;
        Thu, 22 May 2008 13:55:57 -0700 (PDT)
Received: by 10.82.168.20 with HTTP; Thu, 22 May 2008 13:55:57 -0700 (PDT)
In-Reply-To: <20080520203153.GH29038@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82653>

> I'm not worried about users leaving git-gui.  Hell, if git-gui
> was just git on training wheels and all git users left git-gui
> after a while for the command line that would be telling as it
> says the graphical interface is not desired.  Or that git-gui's
> interface is not well suited to the task.
>
> Far from it.  Some users like git-gui for its ability to show
> the modified files, and let you stage/unstage individual hunks.
> Others like its ability to perform checkout+pull in one mouse
> click.  Many like to point at things with a rodent than to use
> the keyboard and enter (to them) isoteric commands.
>
> Right now there are really only two git GUIs; git-gui and QGit.
> Each has its strengths.  Maybe this time next year we will have
> a 3rd; name yet to be determined but it would come out of the
> egit/jgit project as a stand-alone SWT/Java based Git UI.
>

I have to say - git is the first SCM that I've used that commandline
usage is actually pleasant in - so much so, the lack of easy cut&paste
from 'git status' in colleagues cygwin windows becomes a serious pain!

git-gui is good though - but there's a few things I wish it had. I
often find the need to flip between git gui and gitk (for a 'where the
heck am I at the moment' overview) - the 2 tools seems to confuse
people coming at git, even given 'visualize branch'. It'd be nice to
be able to add files / directories to .gitignore, and to view the
staged/unstaged changes as trees - helpful for when a build has
created a non-ignored directory with thousands of files. Maybe I
should get qgit - but git gui has the massive advantage of being in
every install by default, and so is available in msysgit.

Whilst I'm thinking about it - I'm surprised in retrospect how little
prominence the index is given in the frontends I've seen. It's easy,
coming from SVN, to gloss over the index as the same as just checking
off files at commit time, and miss stuff like 'git add --patch' and
'git mergetool' altogether.
