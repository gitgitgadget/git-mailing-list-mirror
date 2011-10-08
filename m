From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: unexpected behavior with `git log --skip filename`
Date: Sat, 8 Oct 2011 13:47:58 -0400
Message-ID: <CAG+J_DwDX4e+siHCUYEyfhOChf+GDWFtj-Hypxk0mtB4J_0kNg@mail.gmail.com>
References: <20111007171503.GB16607@mcnabbs.org>
	<CAG+J_DwnUOeDTiUW-UUJGLLg8jJ4EhXN21B7o_hOMnyowM9a8g@mail.gmail.com>
	<20111008023637.GA18136@mcnabbs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andrew McNabb <amcnabb@mcnabbs.org>
X-From: git-owner@vger.kernel.org Sat Oct 08 19:48:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCb0H-0008HA-Fz
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 19:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383Ab1JHRr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 13:47:59 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42325 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab1JHRr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 13:47:59 -0400
Received: by yxl31 with SMTP id 31so4446031yxl.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jskOGPh0YKxwexdSyR2BTYmhSs7qiJ6YV1P+cdHETQI=;
        b=iz2OI1qtqsCCI+lAXtxuwHA1ZYHJgHKmovIfH7IbEKesEHAWYqi8pZY7ncCwHc5cbP
         aptWPQ703ExedUVdzdQS6MDu+hIOIMO0tM4rIDDycB+U3tDpLim7XDDo1Y5J/qfte+oj
         0TVeKemFob0xM3JxOXQfaAB2/BW4JADdhVP30=
Received: by 10.147.154.12 with SMTP id g12mr2466873yao.36.1318096078474; Sat,
 08 Oct 2011 10:47:58 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Sat, 8 Oct 2011 10:47:58 -0700 (PDT)
In-Reply-To: <20111008023637.GA18136@mcnabbs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183164>

On Fri, Oct 7, 2011 at 10:36 PM, Andrew McNabb <amcnabb@mcnabbs.org> wrote:
> I went back to reproduce this, and I think I may have been using the
> --follow option earlier.

--follow is, er, special. It doesn't combine well with other rev-list
options. You'll have to search this list for details. Sorry I can't
provide more info. :-(

j.
