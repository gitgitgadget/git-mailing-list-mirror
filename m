X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: how to pass ssh options to git?
Date: Thu, 2 Nov 2006 11:31:53 +0200
Message-ID: <20061102093153.GF7468@mellanox.co.il>
References: <vpqejsm433c.fsf@ecrins.imag.fr>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 09:29:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <vpqejsm433c.fsf@ecrins.imag.fr>
User-Agent: Mutt/1.4.2.1i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30696>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfYsv-000077-Vn for gcvg-git@gmane.org; Thu, 02 Nov
 2006 10:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752749AbWKBJ3N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 04:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbWKBJ3N
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 04:29:13 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:6272 "EHLO
 dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1752749AbWKBJ3N (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 04:29:13 -0500
Received: from mellanox.co.il ([194.90.237.34]) by dev.mellanox.co.il
 (8.13.1/8.13.1) with SMTP id kA29T0fM010402; Thu, 2 Nov 2006 11:29:01 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu,  2 Nov 2006
 11:31:53 +0200
To: Matthieu Moy <Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org

Quoting r. Matthieu Moy <Matthieu.Moy@imag.fr>:
> Subject: Re: how to pass ssh options to git?
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
> > How is it possible to pass ssh options to git?
> > for example, I use these options to log into some machine:
> > ssh -i <private> -o HostKeyAlias=<alias> -p <port> -l <user> <address>
> 
> Not answering the question, but this can go to ~/.ssh/config :
> 
> Host *.domain.net
> User some_user
> IdentityFile ~/.ssh/foobar
> 

I know, problem is I want to use different options at different times.
I could use -F configfile ssh option, but how to pass *that* to git?

-- 
