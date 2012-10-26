From: David Michael Barr <b@rr-dav.id.au>
Subject: Re: Subtree in Git
Date: Sat, 27 Oct 2012 00:58:23 +1100
Message-ID: <2DDAA35052EA4F88A6EAC4FBDDF7FCCD@rr-dav.id.au>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
 <nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl>
 <87fwbgbs0h.fsf@smith.obbligato.org>
 <7v8vh78dag.fsf@alter.siamese.dyndns.org> <4FA82799.1020400@initfour.nl>
 <nngzk9jvemb.fsf@transit.us.cray.com>
 <nngaa0z3p8b.fsf@transit.us.cray.com>
 <87bokpxqoq.fsf@smith.obbligato.org> <4FD89383.70003@initfour.nl>
 <nng4npe6zsj.fsf@transit.us.cray.com> <50830374.9090308@initfour.nl>
 <7vbofwgwso.fsf@alter.siamese.dyndns.org> <5084102A.2010006@initfour.nl>
 <nnga9vefu1v.fsf@transit.us.cray.com> <508A8BD3.9020901@initfour.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: dag@cray.com, Junio C Hamano <gitster@pobox.com>,
	greened@obbligato.org, Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Herman van Rink <rink@initfour.nl>
X-From: git-owner@vger.kernel.org Fri Oct 26 15:58:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRkQu-0007jx-BK
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 15:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892Ab2JZN6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 09:58:32 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:49202 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab2JZN6b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 09:58:31 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1318021dak.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 06:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:x-gm-message-state;
        bh=48P392e9F1d64PWQ+o/b74dZCXz4pgezboQsoDNOFhU=;
        b=bf5Uf2s0p5BocgK66OGlrEO1Angtt4ehsUI9Z5/e5qRIYmAhQN18XE9MXfghflpuXb
         2oWAb948rHRcmPCSA1CxUHh7nbOufcIl7cJoC4pBAXt8Ss5Vxe/nofmmldSFCyL5P8Gm
         XFdiEekcZBcWLsawqnCC+KSlmrcGfKIFfrFxlU96Z5Kdl11FnahNm7w1f6pwmkeyp6iR
         mByD36by3fYY19+pGFaqZfogg6cYcoNpNoencOUZHA5mgvqGx09+ASRQoi921zPqnRNv
         Ss/VNJNkIbW5wl9qZ7oLa8ijiXZ74lX99FbKWhrxHJisa5GOiIEWrCSIlysfoIl8NHxg
         nAhg==
Received: by 10.66.76.98 with SMTP id j2mr62086669paw.65.1351259911327;
        Fri, 26 Oct 2012 06:58:31 -0700 (PDT)
Received: from [192.168.0.12] (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id gl9sm1212240pbc.51.2012.10.26.06.58.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Oct 2012 06:58:28 -0700 (PDT)
In-Reply-To: <508A8BD3.9020901@initfour.nl>
X-Mailer: sparrow 1.6.4 (build 1176)
Content-Disposition: inline
X-Gm-Message-State: ALoCoQl9+vcdhNg/7255PamjVUT85vWbjXYfUJqIfmcarvNDH+Y0SZ+wJji5RKQ+54W67igLu28p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208446>

On Saturday, 27 October 2012 at 12:10 AM, Herman van Rink wrote:
> On 10/22/2012 04:41 PM, dag@cray.com (mailto:dag@cray.com) wrote:
> > Herman van Rink <rink@initfour.nl (mailto:rink@initfour.nl)> writes:
> > 
> > > On 10/21/2012 08:32 AM, Junio C Hamano wrote:
> > > > Herman van Rink <rink@initfour.nl (mailto:rink@initfour.nl)> writes:
> > > > 
> > > > > Junio, Could you please consider merging the single commit from my
> > > > > subtree-updates branch? https://github.com/helmo/git/tree/subtree-updates
> > > > 
> > > > 
> > > > In general, in areas like contrib/ where there is a volunteer area
> > > > maintainer, unless the change something ultra-urgent (e.g. serious
> > > > security fix) and the area maintainer is unavailable, I'm really
> > > > reluctant to bypass and take a single patch that adds many things
> > > > that are independent from each other.
> > > 
> > > 
> > > Who do you see as volunteer area maintainer for contrib/subtree?
> > > My best guess would be Dave. And he already indicated earlier in the
> > > thread to be ok with the combined patch as long as you are ok with it.
> > 
> > 
> > Let's be clear. Junio owns the project so what he says goes, no
> > question. I provided some review feedback which I thought would help
> > the patches get in more easily. We really shouldn't be adding multiple
> > features in one patch. This is easily separated into multiple patches.
> > 
> > Then there is the issue of testcases. We should NOT have git-subtree go
> > back to the pre-merge _ad_hoc_ test environment. We should use what the
> > usptream project uses. That will make mainlining this much easier in
> > the future.
> > 
> > If Junio is ok with overriding my decisions here, that's fine. But I
> > really don't understand why you are so hesitant to rework the patches
> > when it should be realtively easy. Certainly easier than convincing me
> > they are in good shape currently. :)
> 
> 
> 
> If it's so easy to rework these patches then please do so yourself.
> It's been ages since I've worked on this so I would also have to
> re-discover everything.

>From a quick survey, it appears there are no more than 55 patches
squashed into the submitted patch.
As I have an interest in git-subtree for maintaining the out-of-tree
version of vcs-svn/ and a desire to improve my rebase-fu, I am tempted
to make some sense of the organic growth that happened on GitHub.
It doesn't appear that anyone else is willing to do this, so I doubt
there will be any duplication of effort.



--
David Michael Barr
