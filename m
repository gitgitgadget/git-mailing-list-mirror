From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: question about sparse checkout
Date: Fri, 9 Apr 2010 13:13:13 +0200
Message-ID: <j2hfcaeb9bf1004090413ud934f42ch633b04e4b282b3f@mail.gmail.com>
References: <i2t8ba6bed41004090318k265095e9i72c9c1e79b3bfcd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Matt Rice <ratmice@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 13:13:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0C9c-0003nn-UY
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 13:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145Ab0DILNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 07:13:35 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:44033 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641Ab0DILNe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 07:13:34 -0400
Received: by ewy20 with SMTP id 20so1285519ewy.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 04:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:content-type;
        bh=znP2hlQSnMwMPY6QiB9cC9OYhAfaSMrTzM1X1oWtkkA=;
        b=D+IsWasJiBVnxBjePQV8kWBUFVh1IP3C0OZFu4GUbqO6OEbDIX95L3ZWBfsdcy/m68
         VvWa8VYmR+d3JYI/ffM7sz21kJcKcR/5x8NX1M/BZr3fMXUlcPkEz6qh1xkjpQZQXQr3
         x7OG154nuYo44uazO//3U1txT7yl5LB01eG8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=freye7hgsnhCGIUnfNPvg0zjujV22CK+PRL8x0dT6Ey2yg2RvqLmyHUByOPNs8tiyo
         h31IibwDZfDgsAjJ/ep5koJZeztNuZ9u3logOqGbK3msRJJplDdGg35wXObdQomTovOB
         +m2i4YKdQh72cdAVNoMP1O/7WQuNbeDFcn42Y=
Received: by 10.213.105.130 with HTTP; Fri, 9 Apr 2010 04:13:13 -0700 (PDT)
In-Reply-To: <i2t8ba6bed41004090318k265095e9i72c9c1e79b3bfcd7@mail.gmail.com>
Received: by 10.213.57.140 with SMTP id c12mr819310ebh.3.1270811613125; Fri, 
	09 Apr 2010 04:13:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144422>

On Fri, Apr 9, 2010 at 12:18 PM, Matt Rice <ratmice@gmail.com> wrote:
> hi,
>
> is there some way that cloning a sparse checkout can also clone the
> sparsity of the checkout?

No. The sparsity is a property of worktree, it can't be cloned.

> currently, when cloning, I have to set up the sparsity on each cloned
> repository, after fetching
> by providing something like a shell script for each 'view' of the repository
> just wondering if there was a way to make this a transferrable property.

I have a similar problem (transferring remote.* by cloning). Maybe we
could extend git protocol a little bit to allow these customizations?
-- 
Duy
