X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/n] gitweb: Secure against commit-ish/tree-ish with the same name as path
Date: Thu, 2 Nov 2006 09:49:33 +0100
Message-ID: <200611020949.34276.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com> <200611010140.56834.jnareb@gmail.com> <7vac3awtj4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 2 Nov 2006 08:49:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EQtGE37bsZYiyuv/CcR6nJKke7gdqyeUHE7bkAjFS9j2s4nkB2DbI3rL/UNQOJdNUyUrpXDKs6uJJSRksfqaS2s2A938ionjEvq+RTJjR09NuIjtXU2eIyHhaHUlxw+fMbww4nFvu6EWcAwAO/zQMM9zRFQ7iFzkBbG9LF3rW7I=
User-Agent: KMail/1.9.3
In-Reply-To: <7vac3awtj4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30692>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfYGF-0001Ve-Nj for gcvg-git@gmane.org; Thu, 02 Nov
 2006 09:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752742AbWKBItQ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006 03:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbWKBItQ
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 03:49:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:32035 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752742AbWKBItP
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 03:49:15 -0500
Received: by ug-out-1314.google.com with SMTP id m3so66059ugc for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 00:49:14 -0800 (PST)
Received: by 10.67.22.2 with SMTP id z2mr231207ugi.1162457354400; Thu, 02 Nov
 2006 00:49:14 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 20sm1650428uga.2006.11.02.00.49.14; Thu, 02 Nov
 2006 00:49:14 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> I'll be pushing out a "master" update
> sometime today, and do not expect to be able to get to your "n
> turned out to be ten" series, so it might be worthwhile to
> reroll the remaining bits that you still care about on top of
> what I push out tonight to make sure we are on the same page.

I'll wait a while if there are any comments (for example on formatting
used), and resend cleaned-up series.

> Preferably:
>
> =A0- you should avoid making a series out of more-or-less
> =A0 =A0unrelated things;

Well, truly unrelated were adding "--" to secure against ref with
the same name as path in the repository (but it was discovered
during testing the series) and replacing ' ' with '&nbsp;' in blob
and diff body for non-CSS aware browsers.

Better quoting and unquoting was needed for better commitdiff view.
Ah, well, perhaps it is unrelated.

Securing against filenames with LF for example has sense only if
there can be filenames with LF, and earlier gitweb unquoted it halfway
leaving '\n' instead of LF.

> =A0- if you are doing related things in one series, do not send
> =A0 =A0half-baked early parts out until you are finished and are
> =A0 =A0confident with it.

I've send series early to get some comments, but I see while I got
some comments on "take 1" and "take 2" on _single_ "new commitdiff"
RFC patch, I got comments only about half-baked '&iquot;' idea.
--=20
Jakub Narebski
