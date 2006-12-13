X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Collection of stgit issues and wishes
Date: Wed, 13 Dec 2006 22:14:32 +0000
Message-ID: <b0943d9e0612131414h25a75bf8h14b5a1731ea47afb@mail.gmail.com>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net>
	 <200612101801.58247.jnareb@gmail.com>
	 <b0943d9e0612101426l763d46cahe15683410cb4398d@mail.gmail.com>
	 <200612110002.05847.jnareb@gmail.com>
	 <20061211184105.GC17132@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 22:14:42 +0000 (UTC)
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dxKosfbyEiONbNklVXij3ALhOneKRkhe/85v4ge/9hDK4SBF2yr83cLPwCkhBiYztfhdctzvWlYyjZCTGIHVZle/DuP5jFSKGkC7hPP/zXh8Fhr5oFMUm7hTquW+PTTu5IBcvGQeLL1s4fJ3HosU6/YXRJVbd6Isf5VROm71Ysw=
In-Reply-To: <20061211184105.GC17132@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34238>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GucN3-0007HO-KJ for gcvg-git@gmane.org; Wed, 13 Dec
 2006 23:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751222AbWLMWOe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 17:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWLMWOe
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 17:14:34 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:32887 "EHLO
 nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751222AbWLMWOd (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 17:14:33 -0500
Received: by nz-out-0506.google.com with SMTP id s1so162556nze for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 14:14:33 -0800 (PST)
Received: by 10.65.241.20 with SMTP id t20mr165759qbr.1166048072918; Wed, 13
 Dec 2006 14:14:32 -0800 (PST)
Received: by 10.65.126.2 with HTTP; Wed, 13 Dec 2006 14:14:32 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
Sender: git-owner@vger.kernel.org

On 11/12/06, Yann Dirson <ydirson@altern.org> wrote:
> Operations just shuffling the stack (eg. "float -s", or "push XXX;
> push --undo") would probably require putting the series file itself
> under version-control.

It depends on the numver of undos allowed. With only one, you could
have a series.old file or similar.

I'll try to add a wiki page with todo/wishlist ideas and prioritise
those included before 1.0. Post 1.0, I'll try to look at changing the
repository layout a bit to reduce the amount of metadata and also
facilitate the support for transactions etc.

-- 
