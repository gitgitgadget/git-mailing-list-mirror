From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Sat, 17 May 2008 22:14:45 +0200
Message-ID: <bd6139dc0805171314i29daf0det47d9ad8f9e7d76a7@mail.gmail.com>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
	 <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>
	 <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>
	 <alpine.DEB.1.00.0805161125320.30431@racer>
	 <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org>
	 <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com>
	 <alpine.DEB.1.00.0805171102480.30431@racer>
	 <e06498070805170744l7ad213aeqb779b0c0381e1de4@mail.gmail.com>
	 <bd6139dc0805170912w14b7894fxfebe15c14e4c44ef@mail.gmail.com>
	 <alpine.DEB.1.00.0805171939540.30431@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Walter" <stevenrwalter@gmail.com>,
	"=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>,
	"Kevin Ballard" <kevin@sb.org>,
	"Mike Ralphson" <mike.ralphson@gmail.com>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 17 22:15:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxSoc-0000th-Cq
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 22:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711AbYEQUOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 16:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755308AbYEQUOr
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 16:14:47 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:42577 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbYEQUOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 16:14:46 -0400
Received: by wf-out-1314.google.com with SMTP id 27so699738wfd.4
        for <git@vger.kernel.org>; Sat, 17 May 2008 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ShVAmmsPUgVvr7jjheIZ2JmZOXVcRgyZlnKa3wZt12w=;
        b=fpZRI0feIoxZeP1AdX7RJhzAiAxGEkgtxhJJwZDTzIY0xn7i2JBRE+FYEFACfITUgebtxioNnR8aj6CfU8ouL1PPkVhq7X9q2pgGubD6/zDAs+B+2UERvxlmWCmbL9/KVcvQnmHPU4z1V0BYashgn+sb58yIItbF8KzDmdx5UvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HVEmnl2JG0M87K+MJvnFsw7MBh0nAwtDpi4xQFGGAp7TfBSsRfMh+lC5WnF+NPsriZDcVpmj1yibMKQh9Kc24fMt+i8UiwgGBvKUM99xcq7S0Vt18TaXT9aqXvIHFY0rY5VGuYhvTO+I5CN4bRNCYkmevdHk9WNNVZj/eYn36RQ=
Received: by 10.142.126.17 with SMTP id y17mr2136575wfc.170.1211055285568;
        Sat, 17 May 2008 13:14:45 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Sat, 17 May 2008 13:14:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805171939540.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82359>

On Sat, May 17, 2008 at 8:44 PM, Johannes Schindelin > But I strongly
disagree with the notion that it is okay to fsck with
> old-timers (who would be harmed by breaking backwards-incompatibility,
> and nobody else), especially given that it is mostly old-timers who turned
> Git into the Good Product(tm) it is.

But those old-timers can be updated can't they? Also, shouldn't we
have tests to see if they 'break' because of changes?

-- 
Cheers,

Sverre Rabbelier
