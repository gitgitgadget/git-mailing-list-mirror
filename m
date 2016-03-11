From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [PATCH v4] commit: add a commit.verbose config variable
Date: Fri, 11 Mar 2016 09:39:19 +0000
Message-ID: <CAFY1edbeKbswdmjZ-+ioQ1Ns4tQ1tOJPt_dO2G2r+xKL_LeZSQ@mail.gmail.com>
References: <0102015362963f6a-626ad27e-e705-4a75-93a6-55a5f75d0226-000000@eu-west-1.amazonses.com>
	<CAPig+cT+dmD2Nxw7z+x0Q2z_aJQFMwRwnb=dn1uH-_Nt9tnk4Q@mail.gmail.com>
	<CAFZEwPMznAUBhgJgZ7aRvtH1W8hDYLci6khbw9EsWS9WGhSh=Q@mail.gmail.com>
	<20160311054412.GA10841@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Roberto Tyley <robertotyley@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 10:39:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeJXb-00047W-Da
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 10:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbcCKJjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 04:39:22 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:33401 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbcCKJjU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 04:39:20 -0500
Received: by mail-io0-f193.google.com with SMTP id g203so10551870iof.0
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 01:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=D7uvMFGwVqM0eNXoAHo2MtX0PkLiS4hrYTm97qQy0yY=;
        b=jonDLVwno8Bi6WgoLbMggajXvkFDsBV2xKT+pV4uuuRZKCbZbYh3GzaSmQlO+vGI3y
         WRIVSKo+b+2Lk8m/HWYa9MUZ97wwOqyeEMcTLi3qBo6S4k4ij4Evw+zyYf5PJqA0YOx9
         BlmLbZdzHDZlj4W9Ayg0a9LgxfRRXgPQG1H686TlFdvxBM9Ca0rqRQ7JcjagVkTIM+7j
         7Xj9hlTqXfBOm6JU34fRMnYHntB2TMGQsw07evOKDmNN7LRAe+s8l7h91uIejeDZSAoU
         kN8iubu+c1iJyllhhwHdEByFY6ANJfvU/4D4ZOLePYXG1mXYyp7eyjZgBL35a/o/ipXX
         q1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=D7uvMFGwVqM0eNXoAHo2MtX0PkLiS4hrYTm97qQy0yY=;
        b=ekEuowvolXep6z3hUX4HIl0r9Ds5BBcn5C9QJ2L8XGqnIqNgTLmplNqRJ8M5dF329W
         l8TYgIDupypmq0q17V6pk7SpjBvY+5b6Gcnb78+HRuKJAw4hYJlHnY04Lk/IFx4Akw2H
         /3Qcg+TXDZQxtm0DPkblTQT8y8iWFyRdIeJsIO+99UyIsnXzELFzkx9wB/DL9rBC02nx
         1A5Hfrs6vuNhfzX0EuDh/TTF+/VRp4aJ+idPjDFz1R0PtL1NC/UvqV6I9uUM/EbQKtCw
         zFHXU77pcZqdy1s1yNuKgC0U0c8ifubXUPiawb2LJy8QwxbnOURdYozejMV3u8uJ2PZB
         8SRQ==
X-Gm-Message-State: AD7BkJLYLH0ppq1jB3QF0NEJBua9/pbANz1c5M1yqzmTrqNx8IyYhDlFvqrHJwFfiAWrB8jqQb7kxxq4yFpqUA==
X-Received: by 10.107.7.20 with SMTP id 20mr8604672ioh.181.1457689159283; Fri,
 11 Mar 2016 01:39:19 -0800 (PST)
Received: by 10.79.64.129 with HTTP; Fri, 11 Mar 2016 01:39:19 -0800 (PST)
In-Reply-To: <20160311054412.GA10841@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288677>

On 11 March 2016 at 05:44, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Mar 11, 2016 at 05:45:27AM +0530, Pranit Bauva wrote:
>> Actually I am sending the patches with submitGit herokuapp because my
>> institute proxy does not allow IMAP/POP3 connections.

Really glad to hear this is helping you Pranit - I hadn't even thought
of the blocked IMAP/POP3 connections problem, I'm not sure what other
method you could have easily used to get round this.

> That's unfortunate. Your separate "cover letter" often arrives hours
> later than the patch itself. Perhaps Roberto can comment on submitGit
> and per-patch commentary.

This sounds like an improvement I need to make to submitGit, I've
created an issue here:

https://github.com/rtyley/submitgit/issues/30
