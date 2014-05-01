From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: Zsh submodule name completion borked
Date: Thu, 01 May 2014 17:35:46 -0500
Message-ID: <5362cc42ed06d_569a13852ecb@nysa.notmuch>
References: <CABURp0oS0qnyVhfV1rsaNXT-88QJvgpNn+meApNKRTGdULDXpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Phil Hord <phil.hord@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri May 02 00:46:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfzkP-00034k-LX
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 00:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbaEAWq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 18:46:29 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44544 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbaEAWq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 18:46:26 -0400
Received: by mail-ob0-f174.google.com with SMTP id gq1so4327148obb.19
        for <git@vger.kernel.org>; Thu, 01 May 2014 15:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=zPmpAcN5Jm3gUxZR43Wj0VsZTMcFXMzVW+PEzC+EOWM=;
        b=ZeZSrgKJhlYTWw1N1HTGLriKfftDNfl8tQgkfjY8NZlwM6JdxKyg7x/13sjZu5YPnX
         aeHvaz4O1q38rqT94yLaosgNojBeKgEQwcI2CpqFj0B73enLQvo38ljDb0UE6FHtmXKN
         2sJIVal42dv8Ny+urPg0Zxc3wJLwHRdDCtRJuv5aNwrv41MQOcZMch1/c0LAZgsjMziy
         j2Dlk/1zbE74XXjtK31RMx9cAUx2RFUJmeFnhbsvw1MHMKJecWj1z73TuhuNqlNY/stA
         zzmo7jwwJwFCDoq4otP1U+gPBxVvq5zCfrdWflWmH5P1wlH8Je+/7SGagNE1ttCkkQ1M
         adCg==
X-Received: by 10.182.112.231 with SMTP id it7mr12004652obb.8.1398984386049;
        Thu, 01 May 2014 15:46:26 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id sm4sm62165317obc.3.2014.05.01.15.46.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 15:46:25 -0700 (PDT)
In-Reply-To: <CABURp0oS0qnyVhfV1rsaNXT-88QJvgpNn+meApNKRTGdULDXpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247890>

Phil Hord wrote:
> When I use zsh tab-completion to complete the submodule name in 'git
> submodule init', I get more than I expected.
> 
> From the gerrit repository (which has plugins):
>   $ git submodule init plugins/<TAB>
>   plugins/commit-message-length-validator\ \(v1.0-rc1-9-g545000b\)
>   plugins/reviewnotes\ \(v1.0-rc1-8-ge984300\)
>   plugins/replication\ \(v1.1-rc0-13-g4c3f4c9\)
> 
> It works ok in bash.  I tried to bisect the trouble, but it still
> fails in 1.8.3, so I'm beginning to think it's me.  Does this happen
> to anyone else?  Is it something in my local configuration causing
> this?

Define 'works' in bash. From what I can see from the bash completion,
it's not doing anything special, so the completion you see are simply
files.

-- 
Felipe Contreras
