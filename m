X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Re: [PATCH 1.2/2 (fixed)] git-svn: fix output reporting from the delta fetcher
Date: Tue, 28 Nov 2006 10:45:24 -0200
Message-ID: <9e7ab7380611280445r4ebe344cw69cbc18a74c6122f@mail.gmail.com>
References: <loom.20061124T143148-286@post.gmane.org>
	 <20061128054448.GA396@soma> <20061128102958.GA5207@soma>
	 <20061128105017.GA20366@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 12:45:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=bFfs1Cox3ar3Qu+3uIgzqwWg5jcd581InqFFRYZxoiy0FJR6fFbxoRmww9pYHFPL0liLJMuBfVZkiMzpoc7FXQwdET2KMS2FKQNIxOiziH6mdawCxrh3BX/HpwtNBImxBmmMlJX4PGRSLQNx98SV7R4Hys6DzwIpPBOcGS6rzOE=
In-Reply-To: <20061128105017.GA20366@soma>
Content-Disposition: inline
X-Google-Sender-Auth: aebeee1bd85cdcb2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32518>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp2L6-0000Nc-Uc for gcvg-git@gmane.org; Tue, 28 Nov
 2006 13:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758490AbWK1Mp1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 07:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758594AbWK1Mp1
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 07:45:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:13907 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1758490AbWK1MpZ
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 07:45:25 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2564385nfa for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 04:45:24 -0800 (PST)
Received: by 10.49.20.8 with SMTP id x8mr4529564nfi.1164717924066; Tue, 28
 Nov 2006 04:45:24 -0800 (PST)
Received: by 10.48.216.6 with HTTP; Tue, 28 Nov 2006 04:45:24 -0800 (PST)
To: "Eric Wong" <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

I've tried applying the patch, and running init'ing a new git-svn
repository for my project. The initial commit was fetched OK (and very
fast!), but now I get the following error trying to fetch any later
revision:

Error from SVN, (200003): Incomplete data: Delta source ended unexpectedly
 at /opt/local/lib/perl5/vendor_perl/5.8.8/darwin-2level/SVN/Ra.pm line 157
512 at /Users/pazu/bin/git-svn line 448
        main::fetch_lib() called at /Users/pazu/bin/git-svn line 319
        main::fetch() called at /Users/pazu/bin/git-svn line 178

I'm on Mac OS X 10.4.8 (Intel), with perl 5.8.8 compiled from
macports, and SVN perl bindings from subversion 1.4.0, also compiled
from macports. git was built from 'master' plus your patches.

