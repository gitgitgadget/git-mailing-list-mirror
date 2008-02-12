From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: new stacked git feature
Date: Tue, 12 Feb 2008 16:42:46 +0000
Organization: ARM Ltd
Message-ID: <1202834567.14175.68.camel@pc1117.cambridge.arm.com>
References: <20080111194946.GA7504@redhat.com>
Reply-To: catalin.marinas@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	David =?ISO-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Yann Dirson <ydirson@altern.org>, git <git@vger.kernel.org>
To: Jason Baron <jbaron@redhat.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 18:04:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOyY9-00047r-Ho
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 18:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759923AbYBLRD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 12:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759870AbYBLRD2
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 12:03:28 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:37225 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758691AbYBLRD1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 12:03:27 -0500
X-Greylist: delayed 1206 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Feb 2008 12:03:27 EST
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id m1CGgjbG002939;
	Tue, 12 Feb 2008 16:42:45 GMT
Received: from [10.1.79.3] ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Feb 2008 16:42:44 +0000
In-Reply-To: <20080111194946.GA7504@redhat.com>
X-Mailer: Evolution 2.12.1 
X-OriginalArrivalTime: 12 Feb 2008 16:42:44.0609 (UTC) FILETIME=[4AB70710:01C86D96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73674>

Hi Jason,

On Fri, 2008-01-11 at 14:49 -0500, Jason Baron wrote:
> I was just wondering if there was any progress on the feature, mentioned 
> below that we were discussing...I'd be more than happy to help explain
> it further or help out with it...maybe there a mailing i should be sending
> this to?

Sorry for the loooooong delay. I've been pretty busy and not able to do
much work on StGIT (though the other contributors did a lot of changes).
Now I'm trying to get up to speed with the latest StGIT structure :-).

I cc'ed the other StGIT people and the GIT mailing list.

Catalin Marinas wrote:
> Jason Baron wrote:
> > I also want to be able to go back to a git tag and reproduce a state of
> > the tree...i'm not sure i can do this with two git repositories...i almost
> > want an stgit mode where changes to the patches directory resulst in git
> > commits. IE if i refresh and patch or remove a patch i get a commit to the
> > patches directory. Maybe this can be a 'commit' mode or something that is
> > set when we do 'stgit init'? thoughts?
> 
> This could be made to work but I usually run refresh really often. Maybe
> the commits to the patches directory should have an additional log
> describing what it does (like the 'refresh --annotate').

The background of this discussion is to have two or more StGIT
repositories and keep them in sync. An idea is to share the exported
patches directory and automatically synchronise them between various
repositories (we already have a 'stg sync' command which I use for this
kind of things but it's not automated).

Yet another idea is to add some metadata to each commit log, something
like a unique id so that one can recreate the stack with only a GIT
revision id, without knowing the base.

-- 
Catalin
