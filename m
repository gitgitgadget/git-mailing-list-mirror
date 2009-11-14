From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCHv3] Add branch management for releases to gitworkflows
Date: Sat, 14 Nov 2009 00:35:43 -0500
Message-ID: <4AFE41AF.8050802@fastmail.fm>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm>	<1258055164-11876-2-git-send-email-rocketraman@fastmail.fm>	<20091114071946.6117@nanako3.lavabit.com>	<4AFDE421.5050307@fastmail.fm> <20091114081040.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 06:36:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9BIj-00032T-Qg
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 06:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbZKNFfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 00:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbZKNFfp
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 00:35:45 -0500
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:32707 "HELO
	smtp100.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751427AbZKNFfp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Nov 2009 00:35:45 -0500
Received: (qmail 40321 invoked from network); 14 Nov 2009 05:35:50 -0000
Received: from CPE000db9166236-CM00186845d2ae.cpe.net.cable.rogers.com (rocketraman@99.224.155.40 with login)
        by smtp100.rog.mail.re2.yahoo.com with SMTP; 13 Nov 2009 21:35:50 -0800 PST
X-Yahoo-SMTP: 5CKRlKeswBAtrcX.EVB04BFKSgZiN0yKOK0iylIm064Zdzo-
X-YMail-OSG: ltS6R5wVM1lDmO_5UDAQ9I095rwhsSXeGL8Y9IEQ3HHb9LzqhazjAroRgZiLr66Azw--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id E829621C05CC;
	Sat, 14 Nov 2009 00:35:49 -0500 (EST)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iqBldJb54+sn; Sat, 14 Nov 2009 00:35:43 -0500 (EST)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id E9FDA21C0538;
	Sat, 14 Nov 2009 00:35:43 -0500 (EST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <20091114081040.6117@nanako3.lavabit.com>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132860>

Nanako Shiraishi wrote:
> Quoting Raman Gupta <rocketraman@fastmail.fm>
>> I noticed you removed the discussion I added about the situation in
>> which maint will *not* be a subset of master i.e. when the user has
>> cherry-picked commits from other branches. This type of cherry-pick is
>> described as a valid operation, though one to generally be avoided
>> earlier in the man page. If we tell users that the occasional
>> cherry-pick to maint is ok, then shouldn't we explain how that affects
>> the release process?
> 
> It is irrelevant that you can cherry-pick to 'maint'.
> 
> You can, and Junio does, cherry-pick some commits from master to 
> maint from time to time. But even if you have such cherry-picked 
> commits on the maintenance branch, the result, with zero or more 
> other maintenance commits on top, is always merged back to the 
> master branch (you can look at "gitk origin/maint origin/master" 
> to see yourself).
> 
> So when Junio tags the release from the tip of the master branch, 
> it is a superset of the maintenace branch; it is irrelevant if 
> maint has some commits that are cherry-picked from master.

Thanks for the explanation. Makes sense.

Ok, another dumb question: since you have now submitted a patch on top
of my patch, what is the proper etiquette for proceeding? Who
maintains this patch series until it is committed? Since your patch
applies on top of mine I can't really make any more changes without
affecting your patch right? I can't find any guidance in the
SubmittingPatches document.

Cheers,
Raman
