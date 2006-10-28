X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add "next" link to commitdiff view
Date: Sat, 28 Oct 2006 18:10:36 +0200
Message-ID: <200610281810.36892.jnareb@gmail.com>
References: <200610230037.57183.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 28 Oct 2006 16:10:33 +0000 (UTC)
Cc: Junio Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RqdBdgv/uWqD2IAseEZwrkDmiZgXTCrsoWBZVDPunbCe6zooY0x77RXpmQF0P2mIb8dKaBHZmIQgQ4DQq0YcXDVHu661ySpUCs+rQNrM9DtyOHOb5edr2gigTLFVBcsBDVs/QJJlskM2OvFdcl7BbpB8JcH4jNVpc/RYrysEJxQ=
User-Agent: KMail/1.9.3
In-Reply-To: <200610230037.57183.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30381>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdql4-00088W-DA for gcvg-git@gmane.org; Sat, 28 Oct
 2006 18:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750948AbWJ1QJv convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006 12:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWJ1QJv
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 12:09:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:38720 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1750948AbWJ1QJv
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 12:09:51 -0400
Received: by ug-out-1314.google.com with SMTP id 44so938207uga for
 <git@vger.kernel.org>; Sat, 28 Oct 2006 09:09:49 -0700 (PDT)
Received: by 10.66.224.3 with SMTP id w3mr1434875ugg; Sat, 28 Oct 2006
 09:09:49 -0700 (PDT)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id s1sm792296uge.2006.10.28.09.09.48; Sat, 28 Oct
 2006 09:09:49 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Add a kind of "next" view in the bottom part of navigation bar for
> "commitdiff" view.
>=20
> For commitdiff between two commits:
> =A0 (from: _commit_)
> For commitdiff for one single parent commit:
> =A0 (parent: _commit_)
> For commitdiff for one merge commit
> =A0 (merge: _commit_ _commit_ ...)
> For commitdiff for root (parentless) commit
> =A0 (initial)
> where _link_ denotes hyperlink. SHA1 is shortened to 7 characters on
> display, everything is perhaps unnecessary esc_html on display.
>=20
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>=20
> Junio (and others), is it what you wanted? The idea was to change
> "commitdiff" view only in minimal way, and preserve similarity
> to "commit" format.

Any reasons not to accept this patch? I find it very useful.

The idea to use fixed string instead of shortened SHA-1 of commit
was abandoned after some discussion in this thread.
--=20
Jakub Narebski
