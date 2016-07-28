Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EB1E1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 17:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbcG1RDo (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 13:03:44 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33177 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932666AbcG1RDn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 13:03:43 -0400
Received: by mail-io0-f180.google.com with SMTP id 38so105483043iol.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 10:03:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pa2mnNl8zjvmYlO5Y+s2nxprwwR2eDly7ApdtabSeOI=;
        b=pq4KkTGEmhHobFOiAeBUWV4n8vYjBWgnsBQ6CvoqFFTxwATLFHGztFyAd0wTf4L96i
         AQHinZSWCXbaK3wPa9/yeg+hDm4q6qE0SdJkCu/poqLgDuKO1ACiFmM5SR2uFlaBeOFe
         V1a9MjOgVgvRt5R9t6ztyU8cEp+lNopVf5/DlKMDl9dy7KoqWYqIADKFgpncw8xBjFp/
         R/HDFxLIhAyJs8rMc+W2zZEfWGlQqZbkgx7KmLeP1kUmdYO/Hd/MyuZMRRHXc9ou7esV
         8BAqNIvPU+ttrTCvWByc/WUAvpYBJIuZtFnxLrUpKuK+j50swv5MctinS+C8F+H60Wqp
         8kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pa2mnNl8zjvmYlO5Y+s2nxprwwR2eDly7ApdtabSeOI=;
        b=AtkmItk+8MpaJOeQiAWi1MlqDcHZqNOf6aMYzj48SfqkQf+jB0rl8kSvzRbLBLtwNO
         9Ou1kkHwdg7p4Asxd15Iv2kFDhERcuSIXnHMpmQ25qeTH0rUh4DGa+/PrYgxepU4Sduq
         7zDLZsssbEhIaOlMnAh7wfSXwWjWDOLwMmOHuhIj+2v0WYfdHUrjlt+JuV8txKFDWSi4
         yEXEZs2RJVC1lRHLS3dloE3O6NRL9RXY+Q555L1zHLIPjb+XIdxrkP+vAMS8mVFnwNRm
         WZnQm6PpgaTAR8s5wYmamnFGNDWL9gUuouyLtzpCYTf9wGgz4/L3/94F5HUesENkvJQq
         XuMg==
X-Gm-Message-State: AEkoousEWD2ZzivWdHWn/+bNIY06i05M4/Ash6IjftgnTLlcCueTin4LrXS9Uw40mxAMBcgM7JonI9Hor6B++Q==
X-Received: by 10.107.159.147 with SMTP id i141mr38047169ioe.29.1469725422430;
 Thu, 28 Jul 2016 10:03:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Thu, 28 Jul 2016 10:03:12 -0700 (PDT)
In-Reply-To: <CACsJy8AW3Z+C81F6w7WiZXXvcLRv9PB4=Wjbze6eE_MPgikU8A@mail.gmail.com>
References: <20160728160226.24018-1-r.ruede@gmail.com> <CACsJy8AW3Z+C81F6w7WiZXXvcLRv9PB4=Wjbze6eE_MPgikU8A@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 28 Jul 2016 19:03:12 +0200
Message-ID: <CACsJy8D0bTE_EvW-wixYDf0f2RFBY3VzLdYnUa-G-9QNydu77Q@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/7] Add possibility to clone specific subdirectories
To:	Robin Ruede <r.ruede@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Corrections..

On Thu, Jul 28, 2016 at 6:59 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> Ah.. this is what I call narrow checkout [1] (but gmane is down at the moment)

s/checkout/clone/

> [2] https://github.com/pclouds/git/commits/lanh/narrow-checkout

s,lanh/,,
-- 
Duy
