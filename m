From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git rev-parse --since=1970-01-01 does not work reliably
Date: Thu, 3 Nov 2011 19:36:52 +0700
Message-ID: <CACsJy8C8540-LVrGS_byAvPig2Kq9k2upkbd2psbBJ+Skjs1KA@mail.gmail.com>
References: <20111031161708.GA29924@altlinux.org> <20111031231320.GA3857@do> <20111101124434.GB22229@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Thu Nov 03 13:37:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLwY4-0004Pv-UD
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 13:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933341Ab1KCMh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 08:37:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38053 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933250Ab1KCMhY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 08:37:24 -0400
Received: by bke11 with SMTP id 11so979061bke.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 05:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7suRa0w24A1bcMlvtwk9dxe+4mvLgC80m4Yf1terVXY=;
        b=Q3AXVyhAU0zZ39klP1R5WcHkE9A1N5pEFhyC1M+IUvGu1VQSFXBI9/S8hgxM6x5Trf
         TlMbsxZk6cqQouU9nRs9R9sD/3QlQWKGx5dYHuwQFYEm1FWmm27ybjP+3fKcQ4pHMn90
         VNqdZyVeDdalOPqlWR3d8mApVphCFQoXfpxJg=
Received: by 10.204.15.134 with SMTP id k6mr7970450bka.45.1320323843342; Thu,
 03 Nov 2011 05:37:23 -0700 (PDT)
Received: by 10.204.177.79 with HTTP; Thu, 3 Nov 2011 05:36:52 -0700 (PDT)
In-Reply-To: <20111101124434.GB22229@altlinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184718>

2011/11/1 Dmitry V. Levin <ldv@altlinux.org>:
> BTW, the timezone specifier (UTC) in "git rev-parse --since='1970-01-01 UTC'"
> seems to be completely ignored by date string parser.

It takes this "00:00 1970-01-01 UTC"
-- 
Duy
