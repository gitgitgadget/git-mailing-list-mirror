X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf@b-i-t.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 12:45:31 +0100
Message-ID: <ekp4l0$idb$1@sea.gmane.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612011029.28059.andyparkins@gmail.com> <20061201104256.GQ12463MdfPADPa@greensroom.kotnet.org> <200612011102.17079.andyparkins@gmail.com> <20061201111027.GR12463MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 11:46:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 25
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157015184.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <20061201111027.GR12463MdfPADPa@greensroom.kotnet.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32903>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq6qg-0004fz-Pe for gcvg-git@gmane.org; Fri, 01 Dec
 2006 12:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936472AbWLALq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 06:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936473AbWLALq1
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 06:46:27 -0500
Received: from main.gmane.org ([80.91.229.2]:220 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S936472AbWLALq0 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 06:46:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gq6qC-0004XO-UT for git@vger.kernel.org; Fri, 01 Dec 2006 12:46:05 +0100
Received: from ip-213157015184.dialin.heagmedianet.de ([213.157.15.184]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 12:46:04 +0100
Received: from sf by ip-213157015184.dialin.heagmedianet.de with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 01
 Dec 2006 12:46:04 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sven Verdoolaege wrote:
> On Fri, Dec 01, 2006 at 11:02:15AM +0000, Andy Parkins wrote:
>> On Friday 2006 December 01 10:42, Sven Verdoolaege wrote:
>> 
>> > He showed it to you in the example.  The "submodule object" is the COMMIT
>> > of the submodule itself.
>> 
>> That's no different from mine.  I need more detail than that.
> 
> You were proposing to create an extra object containing some random value
> that is disconnected from the repo.
> 
>> Is that commit in the submodule or the supermodule?
> 
> It's in BOTH.  That's why it's a *sub*module.

I would say it is only in the supermodule because that is the branch you 
are working on. If you are working on the submodule in an independent 
branch then you can pull from the submodule commit. But you do not want 
to pull the supermodule commit itself but only the commit in path libxcb 
(see my proposed syntax).

Regards

Stephan
