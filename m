From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Itches with the current rev spec
Date: Fri, 26 Apr 2013 18:03:04 +0530
Message-ID: <CALkWK0mDZapwUUMRQDqeip2myfHXiRThGmR4uuOjNPFOPKh65A@mail.gmail.com>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
 <20130426101946.433f2d12@chalon.bertin.fr> <517A3E47.6010606@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yann Dirson <dirson@bertin.fr>, git list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Apr 26 14:33:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVhqX-0004d7-FG
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 14:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291Ab3DZMdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 08:33:45 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:38690 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab3DZMdp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 08:33:45 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so4851872iea.18
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=n26vdEwwvHGinHJNuC5o3sWfxqnIqciXYdiB3LbMZTs=;
        b=GliZePeCUiXQZFuUjgUPcVlxQOM2goIPrM6yUqs7py+XF5BObFuvs3KcURr5ybsN3O
         O3dx8LmlAy+27Lz8MjH3Je9o0h5ptl24ugmtmwudUduLkvvFtyx9ZP2sU5HPfNy+2ccQ
         qp2QFOSX6bX+NPBo8obvpVQy5ppY6jyn8KI9y6G2w+I0GVv2QEFAw5KtxjehLkStTml9
         WEWJN76Y7de0dUvMBHcEnvlu8iFQA89uqiSJhuZqVsKFBI1bCm8lhLJwY7tPA19/mnSu
         DtXcsHRgsDDIENNzs9sAzYxs+VXa5lDShiPgEiqMARAgByJzjn16tUz5dyGcs2Kze/go
         ZVJQ==
X-Received: by 10.50.72.65 with SMTP id b1mr1707425igv.63.1366979624622; Fri,
 26 Apr 2013 05:33:44 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 05:33:04 -0700 (PDT)
In-Reply-To: <517A3E47.6010606@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222530>

Johannes Sixt wrote:
>    git rebase -i master..topic
>    git rebase -i master...topic

We absolutely don't want to go down the inconsistent diff UI route.  See [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/222248
