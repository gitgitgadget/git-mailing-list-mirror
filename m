From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH] Use exit 1 instead of die when req_Root fails.
Date: Wed, 17 Oct 2007 10:39:52 -0400
Message-ID: <118833cc0710170739i179e7389k1e44f70086ca88be@mail.gmail.com>
References: <20071017140547.GA21691@Hermes.cust.hotspot.t-mobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: "Brian Gernhardt" <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 16:40:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiA48-0001Dc-GH
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 16:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758069AbXJQOj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 10:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757430AbXJQOj5
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 10:39:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:28872 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757204AbXJQOj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 10:39:56 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1867113nfb
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=DfL7aZaHLiTxye88LO3G8ntWgUr7jRQXOJWgUp3YgMg=;
        b=UYmYaCZ3v2K4QDkF0jAgqaZe78JAChoWc+EEjWcp+0iNX/EQk3hYu+Cq0QFv12gzk1vYnICEVce1n27OivDlHy4v3WlCRTBy4KXpiemDGrZtuNxM2TQGT5Bf5lDg6OVI5GH0IvJYLSKBLcp31Fws8vuXDQ687r9SkqlXT24+2k0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t7ZXTclvwY+MRxn3T23crmEC0372WAd80A/7zXZCfrMCmCLcaYNUMaTIWdPdQ6HFiuvn+U6T3omJ9hInyPAfaloITCEHs/0triYq1gKi6NAIFZQRE5B8Bm7OixHo/1A5EVcJzQJg5GHFgdj5Fmq4sSkLVvlmgup+9yhBhcQosd8=
Received: by 10.142.253.21 with SMTP id a21mr2518244wfi.1192631993020;
        Wed, 17 Oct 2007 07:39:53 -0700 (PDT)
Received: by 10.142.211.20 with HTTP; Wed, 17 Oct 2007 07:39:52 -0700 (PDT)
In-Reply-To: <20071017140547.GA21691@Hermes.cust.hotspot.t-mobile.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61379>

>  made it into your repo.  It fixes test failures on my machine that have
>  been plauging me for months.

That sounds more like a reason to fix the test.  "die" is the perl
standard way of
reporting an error.  It will print the error message on stderr, not on
stdout like
your version does.

IMHO, of course.

Morten
