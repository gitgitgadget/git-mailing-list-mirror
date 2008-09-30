From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] tests: grep portability fixes
Date: Tue, 30 Sep 2008 12:10:19 +0100
Message-ID: <e2b179460809300410q47592f63y7f7ec626007ad838@mail.gmail.com>
References: <20080930080355.GA19605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 30 13:11:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkd8h-0003D8-Ij
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 13:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbYI3LKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 07:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbYI3LKV
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 07:10:21 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:18563 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbYI3LKU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 07:10:20 -0400
Received: by qw-out-2122.google.com with SMTP id 3so391609qwe.37
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 04:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=32h9OpJgDDRNyz08l1p37IIcuVhlEl/zd8y4NxkDFDM=;
        b=e3NlwgpsHrEHzUfaa7eW5ALPghQVIbY8AvD1i0/XFEejnma7435akO98z90yMJ4+xM
         NS1etnwSzqZUNF11XaaCRyTGjfu0z/KQhoXKF0fuNmcAkKkGciSp8AZP0KkJ1xWTUCAj
         S2i02HU4huBN38qIX9XMLp9PZ917OfwPHQlcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=T5d3IXDguT2bXkQVZpgD+gEFAq4wEiMkuRVgqjJxB67RZx4pKOZkqDyEkDYUlUqBbD
         I9KvcqwiU9CSzOhncpBSPn90/Ta0GQ3MI1M7Mv56Vthpe+L8Znaz3mPmKQUoT+XNHZ8G
         qE6fhvoeBhK/OnGqrGizo7RgpP1mOf6+/YTb0=
Received: by 10.214.25.11 with SMTP id 11mr2978788qay.32.1222773019457;
        Tue, 30 Sep 2008 04:10:19 -0700 (PDT)
Received: by 10.214.215.10 with HTTP; Tue, 30 Sep 2008 04:10:19 -0700 (PDT)
In-Reply-To: <20080930080355.GA19605@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97101>

2008/9/30 Jeff King <peff@peff.net>:
> We try to avoid using the "-q" or "-e" options, as they are
> largely useless, as explained in aadbe44f.
>
> There is one exception for "-e" here, which is in t7701 used
> to produce an "or" of patterns. This can be rewritten as an
> egrep pattern.
>
> This patch also removes use of "grep -F" in favor of the
> more widely available "fgrep".

Works here too (AIX 5.3)

Tested-by: Mike Ralphson <mike@abacus.co.uk>
