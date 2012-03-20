From: David Barr <davidbarr@google.com>
Subject: Re: GSoC intro
Date: Wed, 21 Mar 2012 00:19:41 +1100
Message-ID: <CAFfmPPPabm_H9f2Zr8eWc7Wxo6UDz-km_Vg8cc-O38XhGCrj7Q@mail.gmail.com>
References: <11292500.AVmZFUUvNi@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 14:19:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9yye-0006iw-O5
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 14:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756627Ab2CTNTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 09:19:43 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55382 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab2CTNTm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 09:19:42 -0400
Received: by gghe5 with SMTP id e5so20179ggh.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record;
        bh=QW42j+TbycVYOaPoinMUI3VBk17Tbaub0EkRVSQbXk8=;
        b=QB07K6yQQmBCVFHb7hmu9NJKZ6DONMfaq1KAk6z3vV/Chfnc8JTtCMl4HU0w7+0992
         20b4DNPhze9JcdGLKHq+FXVUUxkNgO389mO7X0jVaxHdJNm0MO9mnXjAiIHKM+3LyxyF
         37ZSavwHxszIYeF6MJpyy4CXdAq2bXcWPh5jlKbdRCrJhjynoh/zWwQ9nEkp59qXifaC
         YPXyv+Ev0FH1CvjdpSdOFMqh3IbrnPBgq46S3x5DX+FgRcPh9fc3sqd7ujj6gRSufj77
         pYK7KZFLP1lYUQ2bdYx/piFSxVmAvu4cy0lE3XfoNscnHnILlzpWjM9bDUotxiO5aljo
         40rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=QW42j+TbycVYOaPoinMUI3VBk17Tbaub0EkRVSQbXk8=;
        b=IB2nM1TZPSgxtWTUqL+HcqauKQ1Wc8W7PfhFljXYxsVYEF91ji7gxmHqmqK/Kurtnb
         MqEwrqAlsRvKn65vJgsMNlfM7bN7MvDDZ5ScieDHQKBvrK6GFoBBlpOvGO94xZwFtxsP
         CbdOejmNt4SMKzXJt/Q44vMHPazX8rGqsJWPGhM4Nm++3+5JC9oKHkDyDVHGyUv+0V33
         lYliLtqEJVzx7av1+5ig4WL1KDLbfJSHKxbpDXmWTYpcCBPDFzgBy4VvN8tEu3A7+NiX
         oXIkuab8DSFeI9VEg3V1EwUfKYIpGCk09qAkAAyAdmBcneYNf8FN5naaZNHj0M6EDNCn
         t8KA==
Received: by 10.236.75.232 with SMTP id z68mr17077766yhd.6.1332249581891;
        Tue, 20 Mar 2012 06:19:41 -0700 (PDT)
Received: by 10.236.75.232 with SMTP id z68mr17077749yhd.6.1332249581747; Tue,
 20 Mar 2012 06:19:41 -0700 (PDT)
Received: by 10.101.154.34 with HTTP; Tue, 20 Mar 2012 06:19:41 -0700 (PDT)
In-Reply-To: <11292500.AVmZFUUvNi@flobuntu>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQnjNpP57HoQL5VKzNFcTQ8p60f22SxcF8nbUcxOPKtKKnmhtbjL6i4p4QHAg+WIWNYpFExhZLOPMF071RFy2sSMUT8DR8qCkhkGVj+PXA5sSYBk+FHzLlLHNcv2TtVCeiP6KQtYl50dTWdUMWXDFYDk2mrBtA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193510>

Hi Florian,

> I'm curious about applying for GSoC 2012 considering the idea "Remote helper
> for Subversion".
> I'm using git since years and have converted my svn repos to git years ago,
> but I'm not yet familiar with the pre-work on this topic. Is there a branch in
> git's git?

Much of the progress so far has been merged into master.
Still outstanding are some of Dmitry's patches:
remote-svn-alpha_v2 [1]
svn-fe-options_v7 [2]

> Does a "full-featured bi-directional git-remote-svn" mean, that it should work
> like any remote git repository where you can push to and fetch from?

Yes, that's the plan. To be fair, it is a stretch goal. Two GSoC
students have brought us as far as a read-only remote helper. So I
think there's at least two summers' worth of work remaining.

> Below I briefly introduce myself, for those who are interested.
>
> About me
> My name is Florian Achleitner (IRC: FlyingFlo). I'm
> from Austria and I study Telematics (a blend of computer science and
> electric engineering) at the Graz University of Technology. I'm currently in
> the first year of the master program. Before starting my studies I worked for
> four years as a developer of embedded systems in industry.
>
> My programming experience grew since I started writing programs on TI
> calculators in school probably 15 years ago.
> I'm open-source enthusiast, exclusively using Linux since years.
> I currently work as teaching assistant for an exercise about programming
> operating systems. In this course we also teach the students to use git.

Thanks for the introduction. When I first got involved with this
sub-project, I gave a quick self introduction [3]. As a potential
mentor, it would be prudent to let you know what my commitments are.
My day job is primarily to contribute to chromium.org and webkit.org.
I also have a 20% commitment to git-core and related projects.

> About me and GSoC
> In summer 2010 I participated in GSoC for hugin writing a Makefile-creation
> library in C++, which is used to drive the panorama creation [1]. It was a
> great experience and a cool, successful summer job! ( and it was merged in
> hugin's master branch :-) )

> [1] http://hugin.hg.sourceforge.net/hgweb/hugin/hugin/branches branch:
> gsoc2010_makefilelib (unfortunately the web fronted doesn't display a specific
> branch)

A track record is a plus.

> Why git?
> - I use git daily. It's always good to work on things you use and a chance to
> contribute something.

I'm sure this is the reason most git contributors are here.

> - I like C
> - I used svn. Nowadays I only use it if i have to ;)

You're in good company.

> - The community interaction aspect of open source development is very
> interesting.. as the ideas page says ".. and get it merged into upstream Git."

The git contributors are mostly a pleasure to work with. The volume
and quality of feedback to contribution, especially from newcomers,
sets it apart from the other communities I participate in.

Some extra reading:

To catch up on the current state of the art with respect to
translating Subversion history read:
Another bite of the reposturgeon, Eric S. Raymond [4].
Unfortunately, he hasn't published the code quite yet.
However, he did what we have been lax to do and contacted the
Subversion developers to assist updating protocol documentation [5].
I think the corner cases for the Subversion delta format are still
undocumented [6].

[1] https://github.com/divanorama/git/tree/remote-svn-alpha_v2
[2] https://github.com/divanorama/git/tree/svn-fe-options_v7
[3] http://thread.gmane.org/gmane.comp.version-control.git/143187/focus=143201
[4] http://esr.ibiblio.org/?p=4071
[5] http://svn.apache.org/repos/asf/subversion/trunk/notes/dump-load-format.txt
[6] http://svn.apache.org/repos/asf/subversion/trunk/notes/svndiff

> Regards,
> Flo

--
David Barr
