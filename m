From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/2] git-p4.py: support Python 2.4
Date: Sat, 26 Jan 2013 11:02:02 -0800
Message-ID: <CA+sFfMdkr1rwG3dTfVc2Nxemm88wbadu=q5eJWUprd3m+GU=3w@mail.gmail.com>
References: <1359146641-27810-1-git-send-email-drafnel@gmail.com>
	<1359146641-27810-3-git-send-email-drafnel@gmail.com>
	<20130126124854.GB31052@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, esr@thyrsus.com, john@keeping.me.uk,
	Brandon Casey <bcasey@nvidia.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 20:02:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzB1H-0002jd-VH
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 20:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab3AZTCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 14:02:06 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56965 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab3AZTCE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 14:02:04 -0500
Received: by mail-wi0-f178.google.com with SMTP id hn3so443573wib.11
        for <git@vger.kernel.org>; Sat, 26 Jan 2013 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=uyP3WZIt4vgxDx8b/hJwaB4t5pgGeK4RryBNaALxhv8=;
        b=Ui49emaZ8iJb50kbp1Gmujc6Bz/plByu8pwqKtq0RmCTcCyC27DmOVos/x7c8nrUp2
         DebxN6ZVjxpj/2p3lLCrfHsLiJtDPqHCECFBe802VGP6YOokE3PuN5BqGs9KDUQvDcRW
         sSKsMREqbnCHQhqvHzQZygQOBQktRxuowBEvvC8MZl4Co6dXOwDIi+K14MR4r9c165Nf
         2XIKkz5k5373mPIzsWQFl3B+wOJzXNbzaImuhVZa29qTOaPgHWjNfTYW3ABmcds3cmBq
         DX7p8h6MlA1HsF5fUbS4IR31EB8Lzo3JUNvVygib2psXB5kkJduqE8t/bg/hWLq4a4NP
         XaKQ==
X-Received: by 10.180.88.40 with SMTP id bd8mr2942163wib.33.1359226922616;
 Sat, 26 Jan 2013 11:02:02 -0800 (PST)
Received: by 10.194.143.18 with HTTP; Sat, 26 Jan 2013 11:02:02 -0800 (PST)
In-Reply-To: <20130126124854.GB31052@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214632>

On Sat, Jan 26, 2013 at 4:48 AM, Pete Wyckoff <pw@padd.com> wrote:
> drafnel@gmail.com wrote on Fri, 25 Jan 2013 12:44 -0800:

>> +     sys.stdout.write(s);

> One stray semicolon.

Whoops.  Thanks.

> In terms of maintenance, I'll not run tests with 2.4 or 2.5
> myself, but maybe you would be willing to check an RC candidate
> each release?

Not a problem.  I'm sure it will get run much more often then that.

-Brandon
