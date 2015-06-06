From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [WIP/PATCH v5 0/10] create ref-filter from for-each-ref
Date: Sat, 6 Jun 2015 11:40:52 +0200
Message-ID: <CAP8UFD0nv8asRtViTgN6QPtupYF-r7KB=3+FMDtCzh7h+asjmA@mail.gmail.com>
References: <55729B78.1070207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 11:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1AbC-0001p5-Mb
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 11:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbbFFJkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 05:40:55 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33214 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbbFFJkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 05:40:53 -0400
Received: by wgez8 with SMTP id z8so71758313wge.0
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 02:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vbSeDHb9k5UZClHCDs1uBBHn2W0cqyiJpqY9s3oC+sY=;
        b=NcF7RMJAokvnIXiRfBiK9B+oKwnQvLtt9rpPM8sEhACcYlID2YqEdKXCq17M+CW5kT
         i+aSO09OF7BotHQmRfuoZWThdgjT7RqC5HTrDHHV7HwOdLFvL4DE4YzqGzElgtbYvRAn
         4eTfXOgCTnmciVt59uL6RFtwvXmXJ6gcofv8xiYdzUdmvxqAv11l2DhYCIHKOccnB3q1
         2xYcGhsRBtPTT4xYb7F9e2tggGE5ZdoLgmCTHvIRfcpCBL23pTqRrINID9f4D1ypEd3b
         8rsLhEQvX3mqBxAbhxgCHdXHo9KrLBuD1yTGfehnkgN3jDUVmQF1Aa+e3wDDhgEPoDAQ
         cqLQ==
X-Received: by 10.181.25.234 with SMTP id it10mr4412294wid.41.1433583652377;
 Sat, 06 Jun 2015 02:40:52 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sat, 6 Jun 2015 02:40:52 -0700 (PDT)
In-Reply-To: <55729B78.1070207@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270912>

On Sat, Jun 6, 2015 at 9:04 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Version for of this patch can be found here :
> http://www.mail-archive.com/git@vger.kernel.org/msg70280.html
>
> Changes in this version:
> *       Rename functions to better suit the code.
> *       implement filter_refs()
> *       use FLEX_ARRAY for refname
> *       other small changes

Now that the patch series starts to be in a good shape you might want
to use [PATCH ...] instead of [WIP/PATCH ...].

Thanks,
Christian.
