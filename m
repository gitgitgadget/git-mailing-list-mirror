From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Is there a way to mark a branch as published?
Date: Fri, 01 Aug 2014 20:58:10 +0200
Message-ID: <1406919490.3253.3.camel@spirit>
References: <CAK3OfOjPQ1fcoA7O6EDcQ3iW_AdsjitK4WKSdLwpRRXm8xfrVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 20:58:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDI20-00011q-Tz
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 20:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbaHAS6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 14:58:17 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:48086 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbaHAS6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 14:58:16 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so4720400wev.26
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 11:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=UzZbNX+oE1wfxmZ2AvIvRDB79Z/GlRSOHQEh1ZxhwLU=;
        b=IN1Nj3VmhKVK6aAdNCfgct6cxRw+X1v8C1bTfjqYb9P7Fu11wEScwSXX+PCoDFULcg
         4VtXQRTuSXL+c8YdxCp0frSwYhNARxGolVmQ/q/Vg64itE0yq0LBJc0FD3NtkF2V1Tx2
         vxR9A/fC6ex9/CMPQuy31v3TLBc7LZYReAzqEJdEmpUjqCVG8PZTGo69XMWRm226EfnQ
         Bfp1fYUij2cJhsyvmBmgHnXxiONjbJ848Juk65Ou1jP4EkSziOALo3F4hUJ2uyaZayTZ
         CQnNvDbG0tX4R05ba7ICaKlo0y2Lv7UebABcQDhQ5bOCIRQrO85ytS+xrTbpCXU9t4N9
         rNZw==
X-Gm-Message-State: ALoCoQnkXGNzy4sAKSXhi0f0QugBddQfEWhqAiCSHW9lEU+bAH6q3LMDq2ReapkXlbXg3h1wuqUW
X-Received: by 10.180.99.4 with SMTP id em4mr9714606wib.8.1406919493552;
        Fri, 01 Aug 2014 11:58:13 -0700 (PDT)
Received: from [10.0.0.24] (80-121-71-233.adsl.highway.telekom.at. [80.121.71.233])
        by mx.google.com with ESMTPSA id bx2sm22736179wjb.47.2014.08.01.11.58.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 11:58:12 -0700 (PDT)
In-Reply-To: <CAK3OfOjPQ1fcoA7O6EDcQ3iW_AdsjitK4WKSdLwpRRXm8xfrVA@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254648>

On di, 2014-07-29 at 17:40 -0500, Nico Williams wrote:
> (or all of a repo's branches)
> 
> Teamware recorded whether it had any "children" and warned about
> rebasing published contents.  Perhaps git could do the same.

Git doesn't record this directly, but you can see which known remote
branches contain the tip of a branch:

git branch -a --contains yourbranchnamehere | grep remotes/

That doesn't say anything about remotes you don't know about of course.
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
