From: Nico Williams <nico@cryptonector.com>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 17:19:00 -0500
Message-ID: <CAK3OfOgJRD1bOjdgHao4U3xZZaVEhr=YdFGdWGR1800K5=wkGw@mail.gmail.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
	<CAK3OfOipw+Tg4PF5HAr8tb204vt17EVn46Lm9VMuHW1299yP8A@mail.gmail.com>
	<615C1C6F-4FE0-4A83-8DE6-837386D88A15@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Mike Stump <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:19:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDLAJ-0000li-FN
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 00:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbaHAWTD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 18:19:03 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:39265 "EHLO
	homiemail-a34.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754825AbaHAWTC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 18:19:02 -0400
Received: from homiemail-a34.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a34.g.dreamhost.com (Postfix) with ESMTP id C8CE81005D
	for <git@vger.kernel.org>; Fri,  1 Aug 2014 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type:content-transfer-encoding; s=
	cryptonector.com; bh=BLtisNyAd3fqBO1+fKhH45sIx7A=; b=Fsx61o7Qf6I
	DPrXPdaoVpj2bTtVEQM2z+vUoMw9hx1y6kCc6vM1AMNlvgawbl66qj1dFhVGlyqM
	VmTE5gHmXsNuLsVzI/M1vbA/WpnnfzhqaR65YyDxmzUAUjMMv8ulxwG+a+ijdoYp
	pyyupNWPzjtbgBFc8CbHL54ZiZlMczk0=
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com [74.125.82.170])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a34.g.dreamhost.com (Postfix) with ESMTPSA id 7E1D110059
	for <git@vger.kernel.org>; Fri,  1 Aug 2014 15:19:01 -0700 (PDT)
Received: by mail-we0-f170.google.com with SMTP id w62so5002994wes.15
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 15:19:00 -0700 (PDT)
X-Received: by 10.180.221.65 with SMTP id qc1mr11484706wic.28.1406931540332;
 Fri, 01 Aug 2014 15:19:00 -0700 (PDT)
Received: by 10.217.98.6 with HTTP; Fri, 1 Aug 2014 15:19:00 -0700 (PDT)
In-Reply-To: <615C1C6F-4FE0-4A83-8DE6-837386D88A15@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254673>

On Fri, Aug 1, 2014 at 5:13 PM, Mike Stump <mikestump@comcast.net> wrot=
e:
> On Aug 1, 2014, at 12:22 PM, Nico Williams <nico@cryptonector.com> wr=
ote:
>> If you always rebase
>
> I can=E2=80=99t use rebase unless you make rebase work with multiple =
users and pushing pulling.

That works now, and I do it all the time.  Have a single repo ("the
truth"), always rebase local commits on top of the latest upstream,
always do fast-forward pushes.  Done.
