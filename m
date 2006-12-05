X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 2/4] git-svn: collect SVK source URL on mirror paths
Date: Tue, 05 Dec 2006 13:39:48 +1100
Message-ID: <4574DBF4.8010007@vilain.net>
References: <20061204235724.5393E1380C2@magnus.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 02:40:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <20061204235724.5393E1380C2@magnus.utsl.gen.nz>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33289>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrQE9-0004uM-9q for gcvg-git@gmane.org; Tue, 05 Dec
 2006 03:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968039AbWLECkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 21:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937324AbWLECkJ
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 21:40:09 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:52350 "EHLO
 magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937319AbWLECkH (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 21:40:07 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534) id 1D2EB139B0D;
 Tue,  5 Dec 2006 15:40:02 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by magnus.utsl.gen.nz (Postfix) with ESMTP id
 E141B1380C2 for <git@vger.kernel.org>; Tue,  5 Dec 2006 15:39:57 +1300 (NZDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sam Vilain wrote:
> +		my $uuid = $props->{'svm:uuid'};
> +		$uuid =~ m{^[0-9a-f\-]{41,}}
> +		    or croak "doesn't look right - svm:uuid is '$uuid'";

This joke back-fired.  41 is too long; UUIDs just *look* longer than
SHA1's :).  "36" seems a more appropriate value...

