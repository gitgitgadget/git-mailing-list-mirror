From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v7] Add new git-related helper to contrib
Date: Fri, 31 May 2013 02:49:30 -0500
Message-ID: <CAMP44s0peXDtFB31pEqF49xM8z5OtDKAWaOR65aZSkCndL2bhQ@mail.gmail.com>
References: <1369884777-7227-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=ZbOy6sXOvnTNAqz_UBsUymY1CR_WczT-O3Q+18HJjzQ@mail.gmail.com>
	<CAMP44s25vX1p1Np7yqc9_AqVBme+MCTY88hjhfWdL6KZkxgs7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 31 09:49:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiK5i-00053t-Ft
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 09:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853Ab3EaHtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 03:49:33 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:47321 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812Ab3EaHtc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 03:49:32 -0400
Received: by mail-la0-f52.google.com with SMTP id fo13so1091749lab.11
        for <git@vger.kernel.org>; Fri, 31 May 2013 00:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WebzrTPg/IF+xIY+JJRcCpXxI42tFETVYvmHEZqI3nc=;
        b=hgD8255XRxuv94voHU/HjIkeAdqT26ACM69E7jA6UFEcUVXfUe942CdJbFyBoG35/9
         ii+qdhKXSFybczCLdiSs3/gXnp5IFmn7P+U1jOQNYl2eb/k014N/MHTSeIZ96Ffmyc+Z
         9xiv4gn4iORGx6JSjcWtR/jtVg1Sxpr+OC1SgjVmf6bgiO2/DJK4DA/YhYqsb5g3hDpi
         lrgtI7ykbc/4Yp0ZlB69TYt8qriQdm8HRmvXcn4H50xx4ewWr6XTyngBsZREWtumMt0Y
         1AMkEei2U4S4/yZ6PAheLS9ZLb4Yp8KDhkhnajqoJdkln2YwciyLL5qCweDqU/qlwVlr
         P63Q==
X-Received: by 10.112.88.166 with SMTP id bh6mr5463292lbb.47.1369986570186;
 Fri, 31 May 2013 00:49:30 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Fri, 31 May 2013 00:49:30 -0700 (PDT)
In-Reply-To: <CAMP44s25vX1p1Np7yqc9_AqVBme+MCTY88hjhfWdL6KZkxgs7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226071>

On Thu, May 30, 2013 at 6:31 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, May 30, 2013 at 4:01 AM, Ramkumar Ramachandra

> Not a single one of these comments makes a difference at all, all of
> them can wait until after the patch is merged, many of them are a
> matter of preferences, and some of them have already been addressed as
> precisely that: disagreements in style.

I was going to make these stylistic changes to make you happy, but
then I realized the only that does really make sense is to change msg
= nil to msg = false, and it's not even worth to waste a thought on
changes like that.

So I'll move on to the next patches, hopefully Duy or Junio would have
some comments of actual significance, or maybe you would too, but for
the moment it seems pretty clear you are only stating opinions about
what Ruby code-style you like best.

Cheers.

-- 
Felipe Contreras
