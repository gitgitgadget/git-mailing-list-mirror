X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC/PATCH] Change "refs/" references to symbolic constants
Date: Sun, 17 Dec 2006 09:00:18 +0000
Message-ID: <200612170900.19856.andyparkins@gmail.com>
References: <200612141644.06167.andyparkins@gmail.com> <7vslffcy80.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 09:03:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Z7mKHCaqQtFT4pACnVQcLHDHpYGMuaV846HJpPscpZkOonWHtCDLAq8Rtuuve3VhNbEKOM+MZzqTMBPqRHVAfPK+rXO8Ebamd7xgyfE/MB9pjqPY9+zGcgSupcO6yqNFlzbznU8/Fqzzlo2zBWE6qJLuRYrztb2BEGizUC9cf2w=
User-Agent: KMail/1.9.5
In-Reply-To: <7vslffcy80.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34679>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvrvS-0006kw-My for gcvg-git@gmane.org; Sun, 17 Dec
 2006 10:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752270AbWLQJDG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 04:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbWLQJDG
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 04:03:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:40954 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752269AbWLQJDE (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec
 2006 04:03:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1226978uga for
 <git@vger.kernel.org>; Sun, 17 Dec 2006 01:03:03 -0800 (PST)
Received: by 10.66.232.10 with SMTP id e10mr2998178ugh.1166346182792; Sun, 17
 Dec 2006 01:03:02 -0800 (PST)
Received: from ?192.168.1.48? ( [84.201.153.164]) by mx.google.com with ESMTP
 id 32sm7158958ugf.2006.12.17.01.03.01; Sun, 17 Dec 2006 01:03:02 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Saturday 2006, December 16 21:44, Junio C Hamano wrote:

> This is not rejected nor forgotten but has not been applied yet,
> and may not be immediately.

Oh good.

> I would love to have this; it would reduce mistakes (spelling
> "refs/head/" would silently compile fine and result in a broken
> command, while spelling PATH_REFS_HEAD would be caught by the
> compiler).

I'd not even considered that; I liked it because of a natural disinclination 
towards repeated use semanitcally identical literals.

> A sad thing is this needs to be done when things are relatively
> quiescent.

While true - is there ever such a time?  :-)

On the other hand, this is (hopefully) a zero-impact change, and should leave 
the object the same...  I might even test it by comparing objects.

> So I would apply this before v1.5.0 (or a replacement, if you
> have updates), but it might have to wait a bit until I I can say
> "ok, no big patches to C part is pending right now and it is a
> good time to do this clean-up".

If I know it's wanted I will happily maintain it indefinitely.  It's part of 
my rebase on master set anyway, so it's no pain to do so.  I'll keep an eye 
out for quiet times, or if you prod me when you want it I'll make you a 
rebased version instantly.

While we're on this subject, does the same apply to my hashsize literals patch 
which swapped 20 for HASH_WIDTH?

Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
