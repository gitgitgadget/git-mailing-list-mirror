X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf@b-i-t.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 14:21:20 +0100
Message-ID: <45702C50.9050307@b-i-t.de>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se> <45701A24.5060500@b-i-t.de> <20061201121110.GP18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 13:22:23 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 25
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157015184.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <20061201121110.GP18810@admingilde.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32919>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq8LD-0003Gb-Vs for gcvg-git@gmane.org; Fri, 01 Dec
 2006 14:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936496AbWLANWI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 08:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759157AbWLANWI
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 08:22:08 -0500
Received: from main.gmane.org ([80.91.229.2]:49824 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1758067AbWLANWF (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 08:22:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gq8Kk-0003Bf-RJ for git@vger.kernel.org; Fri, 01 Dec 2006 14:21:43 +0100
Received: from ip-213157015184.dialin.heagmedianet.de ([213.157.15.184]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 14:21:42 +0100
Received: from sf by ip-213157015184.dialin.heagmedianet.de with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 01
 Dec 2006 14:21:42 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:
> hoi :)
> 
> On Fri, Dec 01, 2006 at 01:03:48PM +0100, sf wrote:
>> Andreas Ericsson wrote:
>> 2. You can never prune the main (the supermodule's) repository, at least 
>> not with what git provides today.
> 
> It even already works (well, not with what git provides today, but with
> my implementation). git-prune simply walks all the submodules, too, when
> doing it's reachability analysis.
> 
> What does not work is a prune inside the submodule, because it does not
> know about all the commits used by the supermodule.

I just had a short (really short) look at your work. My impression is 
that your repository setup is much too complicated.

As I proposed elsewhere: For submodules to work you only need to allow 
commits in tree objects (that is what your implementation requires as 
well). Everything else is in the tools. Much simpler.

Regards

Stephan
