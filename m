X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicholas Allen <allen@ableton.com>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 18:44:50 +0100
Message-ID: <456C7592.6020700@ableton.com>
References: <45357CC3.4040507@utoronto.ca>	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>	<87slhcz8zh.wl%cworth@cworth.org>	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr>	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>	<456B7C6A.80104@webdrake.net>	<845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>	<ekhaeg$etk$1@sea.gmane.org>	<Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 17:45:49 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32555>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp711-0003MV-Nj for gcvg-git@gmane.org; Tue, 28 Nov
 2006 18:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935976AbWK1Roz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 12:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935982AbWK1Roz
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 12:44:55 -0500
Received: from mail.ableton.net ([62.96.12.115]:46275 "EHLO
 mail.ableton.net") by vger.kernel.org with ESMTP id S935971AbWK1Roy (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 12:44:54 -0500
Received: from client0055.office.ableton.com ([10.1.15.66]) by
 mail.ableton.net with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.62)
 (envelope-from <allen@ableton.com>) id 1Gp716-00059V-Fl; Tue, 28 Nov 2006
 18:45:12 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org


>
> The reason this is a good example is simply the fact that it should 
> totally silence anybody who still thinks that tracking file identities is 
> a good thing. It explains well why tracking file identities is just 
> _stupid_.
I'm unfamiliar with git so I could be totally wrong here!

I know that bzr supports file renames/moves very effectively and I 
understood that git doesn't support this to the same extent (correct me 
if I am wrong as I have not used git at all!).

If that is the case, could that be because bzr gives each file its own 
id and can detect this easily but git's content based approach can't? If 
so then claiming file identifiers is *stupid* seems a bit extreme. So I 
would have thought *both* file identifiers and line/content identifiers 
are needed for tracking changes made to the files and to their contents 
respectively. When a file is copied then the contents are copied and it 
is given a new file identifier. When a file is moved it keeps the same 
identifier. So don't you need file identifiers as well as line/content 
identifiers?

