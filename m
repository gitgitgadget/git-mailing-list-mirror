X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Marko Macek <marko.macek@gmx.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 20:05:27 +0100
Message-ID: <455B64F7.9040506@gmx.net>
References: <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <Pine.LNX.4.64.0611151315291.2591@xanadu.home> <20061115184914.GA24122@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 19:08:45 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	cworth@cworth.org, pasky@suse.cz
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #420190
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20061115184914.GA24122@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31473>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkQ7Q-0006Ee-At for gcvg-git@gmane.org; Wed, 15 Nov
 2006 20:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030900AbWKOTIM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 14:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030905AbWKOTIM
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 14:08:12 -0500
Received: from mail.gmx.de ([213.165.64.20]:27347 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1030903AbWKOTIK (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 14:08:10 -0500
Received: (qmail invoked by alias); 15 Nov 2006 19:08:08 -0000
Received: from BSN-77-245-67.dial-up.dsl.siol.net (EHLO [192.168.2.7])
 [193.77.245.67] by mail.gmx.net (mp020) with SMTP; 15 Nov 2006 20:08:08 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> Nicolas Pitre <nico@cam.org> wrote:
>> As for the fraction of people complaining being a small fraction of 
>> current GIT users: that is easily explainable by the fact that most 
>> people who would have grown the complainers group are simply not GIT 
>> users anymore since they were turned away by GIT's current user 
>> interface issues.  The only complainers remaining are those who see 
>> value in the GIT technology but who would like to bring more 
>> intuitiveness to the GIT interface instead of going for the alternative 
>> technology.  And those kind of people are always few.
> 
> Or they are by proxy.
> 
> *I* don't see that much of a problem with git pull; I can use it
> without trouble at this point.  But I find it difficult to teach
> to others.
> 
> My complaints about git pull/fetch/push are by proxy for about 10
> other users who aren't on the mailing list but whom I interact with
> through Git.  They don't like pull/fetch/push very much.
> 
> So count my complaints 10 times.  :)
> 
> Ok, that's still a drop in the bucket of current Git users.
> But still, I'm sure there are others.  I think Carl was recently
> talking about complaints from some Fedora folks...

Agreed. Personally, the first thing that I notice when trying to switch
 from Subversion to git is the behavior of 'index', mainly in git-diff, git-status and 
git-commit.

For people switching from CVS and SVN it would be much better if the index was hidden 
behind the scenes by using different defaults:

git-commit -a
git-status -a
git-diff HEAD

BTW, currently there's a minor bug: git-diff HEAD doesn't work before you 
make the first commit. Perhaps this should be special cased.

I could personally get used to this, but I'd surely get blank 
stares from people when teaching them the difference.

I guess this is the reason that the GIT Tutorial for CVS/SVN users is talking about _cogito_ instead.
(which is very confusing for someone coming to _git_ home page, trying to learn git).

