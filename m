X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 02 Dec 2006 13:48:17 +0100
Organization: At home
Message-ID: <ekrsio$1qe$1@sea.gmane.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 2 Dec 2006 12:46:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 15
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33020>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqUGE-00034W-HO for gcvg-git@gmane.org; Sat, 02 Dec
 2006 13:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162988AbWLBMq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 07:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162990AbWLBMq1
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 07:46:27 -0500
Received: from main.gmane.org ([80.91.229.2]:40677 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162988AbWLBMq1 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 07:46:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqUG8-00033R-Bv for git@vger.kernel.org; Sat, 02 Dec 2006 13:46:24 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 13:46:24 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 02 Dec 2006
 13:46:24 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

[cut]

From this discussion I think it follows that supermodule should track HEAD
version of submodule. Perhaps the supermodule index should have sha1 of
submodule commit, so (as usual) you have to update-index in supermodule to
record changes in submodule; the difference being that you update to HEAD
version, not to working directory version. Or you can just git-commit -a
in supermodule which would take working directory version of files, and HEAD
version of submodules.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

