From: David Lang <dlang@digitalinsight.com>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 09:57:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0610230943230.7756@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>  <453A7D7E.8060105@utoronto.ca>
  <20061022074513.GF29927@artax.karlin.mff.cuni.cz>  <200610221105.26421.jnareb@gmail.com>
  <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> 
 <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Carl Worth <cworth@cworth.org>,
	Erik =?iso-8859-1?Q?B=E5gfors?= <zindar@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 23 18:59:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc38o-0006Um-RZ
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 18:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWJWQ7H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 12:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWJWQ7G
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 12:59:06 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:15291 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932184AbWJWQ7D
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 12:59:03 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Mon, 23 Oct 2006 09:59:03 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Mon, 23 Oct 2006 09:58:29 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <20061022185350.GW75501@over-yonder.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29847>

>> This special treatment influences or directly causes many of the
>> things in bzr that we've been discussing:
>  [...]
>> I've been arguing that all of these impacts are dubious. But I can
>> understand that a bzr user hearing arguments against them might fear
>> that they would lose the ability to be able to see a view of commits
>> that "belong" to a particular branch.
>
> Dead center.
>
>
>> The mainline..featureA syntax literally just means:
>>
>> 	the set of commits that are reachable by featureA
>> 	and excluding the set of commits reachable by mainline
>
> From what I can gather from this, though, that means that when I merge
> stuff from featureA into mainline (and keep on with other stuff in
> featureA), I'll no longer be able to see those older commits from this
> command.  And I'll see merged revisions from branches other than
> mainline (until they themselves get merged into mainline), correct?
> It sounds more like a 'bzr missing --mine-only' than looking down a
> mainline in log...

one thing you are missing 'mainline' in this git command is not saying 
'everything that's in the 'main' published branch'. it's saying 'everything 
reachable by the tag 'mainline'

so when you branched off for your feature development you could set a tag that 
says 'branchpoint' and no matter what gets merged in mainline after that you can 
always do branchpoint..featureA and find what you've done.

that being said, mainline..featureA is also extremely useful, it tells you what 
development stuff you have done that have not yet been merged into mainline

David Lang
