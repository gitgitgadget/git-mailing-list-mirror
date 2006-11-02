X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: how to pass ssh options to git?
Date: Thu, 2 Nov 2006 12:06:39 +0100
Message-ID: <20061102110639.G523a966f@leonov.stosberg.net>
References: <vpqejsm433c.fsf@ecrins.imag.fr> <20061102093153.GF7468@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 11:06:51 +0000 (UTC)
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061102093153.GF7468@mellanox.co.il>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30719>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaPF-00032P-Gr for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752838AbWKBLGm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbWKBLGm
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:06:42 -0500
Received: from kleekamp.stosberg.net ([85.116.201.130]:23682 "EHLO
 kleekamp.stosberg.net") by vger.kernel.org with ESMTP id S1752838AbWKBLGl
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:06:41 -0500
Received: by kleekamp.stosberg.net (Postfix, from userid 500) id 1DD4EC5E0E;
 Thu,  2 Nov 2006 12:06:40 +0100 (CET)
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Sender: git-owner@vger.kernel.org

Michael S. Tsirkin wrote:

> I know, problem is I want to use different options at different times.
> I could use -F configfile ssh option, but how to pass *that* to git?
 
You can set the path of the ssh executable to use with the GIT_SSH
environment variable.  Create a shell script like

#!/bin/sh
exec ssh --your-options-- $*

and make GIT_SSH point to it.

Regards,
