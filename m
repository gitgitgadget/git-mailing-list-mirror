From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] checkout: updates to tracking report
Date: Thu, 21 Feb 2008 00:27:09 -0500
Message-ID: <76718490802202127y664cb986u64ab55bbc02fb72e@mail.gmail.com>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
	 <20080209030046.GA10470@coredump.intra.peff.net>
	 <7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
	 <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com>
	 <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
	 <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org>
	 <46a038f90802190903g1a19e38i30198b368a800a89@mail.gmail.com>
	 <7vy79f2pqk.fsf_-_@gitster.siamese.dyndns.org>
	 <20080221014513.GA7185@coredump.intra.peff.net>
	 <7vk5kzynya.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 06:28:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS3yV-0005CJ-VK
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 06:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbYBUF1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 00:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbYBUF1K
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 00:27:10 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:56065 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbYBUF1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 00:27:09 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4334644wah.23
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 21:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YvZmJm0FNekAVGSL5LvmxGmAEkezCJoie/k9d/7FzzM=;
        b=LFqdSlcNjy+Z8q0FyQaU5+vYDt2VOwg5kBM99HGvwc2trlQLnXV9XepDGh4MxL5AP/DCo63TmZOOXfQa5m7TMFt6786tqGxW/vsUpZexCzoMK3o3DtUqVzBbgxnqHxPDh/OlUYD4Glyqh9xjAnSXXKrx1B3W6SdncrOkyTK9EcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xy9xTx1OOiD5dffWiUWRMNKGgMYpskE6WIHFUe/nmmvR6pIQTYZRsOzkQRBn38nYcMnKT9wo2ViJY0qHaFTkCU/h1s4MDeGJzVBc2b6jnNnCPqf2vHmF8PsQpc/9Tcvza4WRe+9rvRCfcR1sk572n6firYRzDMjgjgHnNZwusdw=
Received: by 10.115.50.5 with SMTP id c5mr4813130wak.109.1203571629065;
        Wed, 20 Feb 2008 21:27:09 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Wed, 20 Feb 2008 21:27:09 -0800 (PST)
In-Reply-To: <7vk5kzynya.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74597>

On Wed, Feb 20, 2008 at 10:42 PM, Junio C Hamano <gitster@pobox.com> wrote:

>   builtin-checkout.c |   10 +++++-----
>   1 files changed, 5 insertions(+), 5 deletions(-)

Actually, it would be nice to get this information w/o having to
checkout each branch. "git show-branch --tracking-status" maybe
to report it for all relevant branches?

j.
