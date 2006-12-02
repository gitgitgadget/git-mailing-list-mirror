X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 02 Dec 2006 14:08:58 +0100
Organization: At home
Message-ID: <ekrtph$6nh$1@sea.gmane.org>
References: <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703375.4050500@b-i-t.de> <20061201145817.GY18810@admingilde.org> <45704EA3.40203@b-i-t.de> <20061201165418.GD18810@admingilde.org> <45706758.2020907@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 2 Dec 2006 13:07:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 19
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33021>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqUah-0007EP-BK for gcvg-git@gmane.org; Sat, 02 Dec
 2006 14:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162996AbWLBNHY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 08:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162998AbWLBNHY
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 08:07:24 -0500
Received: from main.gmane.org ([80.91.229.2]:14291 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162996AbWLBNHX (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 08:07:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqUaA-00076D-7V for git@vger.kernel.org; Sat, 02 Dec 2006 14:07:06 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 14:07:06 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 02 Dec 2006
 14:07:06 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Stephan Feder wrote:

> That's it: There is no need for a separate branch or repository. If you 
> have the subproject's commit in the superproject's object database (and 
> we really have that, see 1. and 2. above), why do you _have to_ store it 
> elsewhere?

It would be much simpler to have subproject's commit in subproject object
database, and have it available in superproject's object database by the
way of alternates.

Otherwise when commiting new submodule state in supermodule you would have
to fetch all the needed objects (submodule mighe have evolved few commits
in history inbetween) into superproject's object database.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

