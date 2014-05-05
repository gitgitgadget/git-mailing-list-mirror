From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] Revert "make error()'s constant return value more
 visible"
Date: Mon, 05 May 2014 01:14:43 -0500
Message-ID: <53672c53f2ed9_2e86acd30c6e@nysa.notmuch>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
 <1399183975-2346-2-git-send-email-felipe.contreras@gmail.com>
 <20140505054901.GA19331@sigill.intra.peff.net>
 <5367257a857ce_2db613a731043@nysa.notmuch>
 <20140505060202.GA27360@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:22:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhtH-0005Yp-B9
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbaEEGZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 02:25:26 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:65050 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbaEEGZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 02:25:25 -0400
Received: by mail-oa0-f53.google.com with SMTP id m1so5297528oag.26
        for <git@vger.kernel.org>; Sun, 04 May 2014 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=0IzCNTfrl9HjuRsyh/P/7/hm0cKZSbpD1lJCJC5Jf9k=;
        b=GsLI7mUuCXfjPqdYNnVMRHKeqM3GAklTfdS/z7H3Wq2hZVTuoRlPGUOzawzcUlg0iV
         XYECUSPtJopdStTbm7ZP0gLyoL9tHhP/GqfkgNdR6FuvaBvFsD7RYtdaNMs6yZ0y4yg4
         0onJsUJux8Dz3rADSGUpmAgkR/Vy8VqLBJEsV7HIcxfBwIoU+X+z3g5iLUV/T2cnoYYj
         GOXGQgMrwgYYUxyVnuFGZVpBziyX6RBHbep+OuzlEx6bZVhia38wBxx8Br9XF0utotv9
         zgrqdX/eR7TwF74PJ1p3xVoTUaFIsSD7wqyQjrApC8IvIKNtSFmoigElyiNWaX3cmOsq
         vvcg==
X-Received: by 10.60.134.137 with SMTP id pk9mr30909551oeb.40.1399271125008;
        Sun, 04 May 2014 23:25:25 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qp6sm17157485obb.14.2014.05.04.23.25.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 May 2014 23:25:24 -0700 (PDT)
In-Reply-To: <20140505060202.GA27360@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248133>

Jeff King wrote:
> On Mon, May 05, 2014 at 12:45:30AM -0500, Felipe Contreras wrote:
> 
> > Jeff King wrote:
> > > On Sun, May 04, 2014 at 01:12:53AM -0500, Felipe Contreras wrote:
> > > 
> > > > So it looks like gcc is smarter now, and in trying to fix a few warnings
> > > > we generated hundreds more.
> > > > 
> > > > This reverts commit e208f9cc7574f5980faba498d0aa30b4defeb34f.
> > > 
> > > And now we've gone the other way, and re-enabled the initial warnings.
> > > Can we come up with a solution that helps both cases?
> > 
> > What initial warnings? As I explained already I don't get any warnings
> > with this patch series in gcc 4.9.0.
> 
> The "few warnings" in your statement quoted above.
> 
> You could try reading the commit message of the commit you are
> reverting, which explains it, but the short answer is: try compiling
> with -O3.

Sigh. And I'm the one with the abrasive style of communication.

-- 
Felipe Contreras
