X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: master and origin
Date: Sun, 29 Oct 2006 15:19:44 -0800 (PST)
Message-ID: <118164.43697.qm@web31807.mail.mud.yahoo.com>
References: <4d8e3fd30610291329n7fe59873r87cbee9ccbd4b720@mail.gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 29 Oct 2006 23:19:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=RDM4DkaUOcCX2RtGymgIRnFsgLw01V2MJ//fzU74EUGFxo2RHmsnUiRBbzJ57QMXYZhTIX0mYALh0o0lgMLlcCPDfcj21Uugvo/VBO9WwnqI1Z5/PNEeRJOeCbMVlsPJQkcRe8zVW2YBQ8gh55bl83rRCs0LOZaFoT/+QnDnQns=  ;
X-YMail-OSG: RmeUtzAVM1loOm2bHy8cyZeVDzx6TGQ6sKHVicxnyUSQdW8kAwDoaZdf1uGsTCTrPYiRz4hZ5k70jItzWCRscdga1mw2PWGdXfOTjNZ3nfrNxvIbuhktSzSLZ.EGUDxxoAkkRbf6_oI-
In-Reply-To: <4d8e3fd30610291329n7fe59873r87cbee9ccbd4b720@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30472>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeJwS-0001uv-Pe for gcvg-git@gmane.org; Mon, 30 Oct
 2006 00:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030430AbWJ2XTp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 18:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWJ2XTp
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 18:19:45 -0500
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:1148 "HELO
 web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1030430AbWJ2XTp (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006
 18:19:45 -0500
Received: (qmail 43706 invoked by uid 60001); 29 Oct 2006 23:19:44 -0000
Received: from [71.80.233.118] by web31807.mail.mud.yahoo.com via HTTP; Sun,
 29 Oct 2006 15:19:44 PST
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, Jakub Narebski
 <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

--- Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> 
> So in this case, there is a difference between doing my local
> development under master or myownlocalbranch. Right?
> I mean, if I do my own development under master and I pull, the master
> branch will include origin and my local changes. Corret?
> While if I work in my local branch the datas are not modified with a
> pull, because pull will update only the local copy of the remote
> branch. Correct?

Following GIT's working flow isn't that much different than
other SCM's workflow.

Leave master and origin branches alone.  Imagine they are your
local copy of that imaginary "root" repo.

If you want to do development, create your own branch off of
master at some point, say HEAD, using git-branch, call it my-branch.

Then do your development in my-branch, occasionally pulling from
master, all the while you update master on a regular basis
from the remote repo.  That pull into my-branch would schedule
the merge for you and if it cannot auto-merge, it will leave it
up to you do _resolve_ and then commit.  Eventually
you get into the habit of following the same commands in the
same steps.

Note the key words here: pull, merge, commit.  Pull and merge is
is done by git-pull, and if there's things to resolve you do that
manually, in most simplistic ways.

If you're coming from another SCM, picking up git is a snap.
I think the only "hurdle" coming from another SCM especially
centralized is the decentralized nature of git.

Reading git-fetch, git-pull documentation very carefully
should clear things up.

     Luben
