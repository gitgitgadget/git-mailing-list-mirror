From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGit] [PATCH] Modify Highlight Color at File Context View.
Date: Sat, 27 Sep 2008 13:47:34 +0100
Message-ID: <e5bfff550809270547n15a210e3y386278db00966945@mail.gmail.com>
References: <gbak2u$v9b$1@ger.gmane.org>
	 <7FD1F85C96D70C4A89DA1DF7667EAE96079EDF@zch01exm23.fsl.freescale.net>
	 <e5bfff550809250451q578b8e10r75c043d307a63f28@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE96079FBB@zch01exm23.fsl.freescale.net>
	 <e5bfff550809250934l47c48440m332764491ff5391@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE9607A00A@zch01exm23.fsl.freescale.net>
	 <e5bfff550809252215v72bb4633s17b5c1a8c39f55ff@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE9607A0D9@zch01exm23.fsl.freescale.net>
	 <e5bfff550809260337o1523995ele3333c0de9295393@mail.gmail.com>
	 <7FD1F85C96D70C4A89DA1DF7667EAE9607A217@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Li Frank-B20596" <Frank.Li@freescale.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 14:48:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjZE5-0006PS-Uw
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 14:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbYI0Mrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 08:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbYI0Mrg
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 08:47:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:44264 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbYI0Mrg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 08:47:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so910585fgg.17
        for <git@vger.kernel.org>; Sat, 27 Sep 2008 05:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yqW7X1l9/R1/1J0d1FRt0bTDPs9I/Zf4rW0OQCxWu6Q=;
        b=ZpO3Pcl1YJnk7ZlfhsUaHLElYsb9hYKM9OSNqTnyB8xE6PHP5JKb3pmaBYvBLOLbPH
         jMApDGYDwvfUdU7o1MgT/y33bVNuKCGilTlGop7Aauwu0Ic612bFiVh9XOpb7VP2xdPp
         N+PTlJuCys+vgIdj09YVV72E2M9/ZyV068BDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IFn5OG6wSPTqN1G3kufsLFuOKvSw0e25Va2SkV+uYm8hD1Kl9RFVBJl2YIH8B6ziXe
         btapB/oq9vAjZVQlFsYf7WjJulzCjTvT7v9KAbDCdSbXg09o6B+hah2pSTQDw4XP/z7m
         ItLeGZ5M6tXb1drT5kv6sT9VPhOAQra7yK+4c=
Received: by 10.180.220.5 with SMTP id s5mr1313678bkg.5.1222519654329;
        Sat, 27 Sep 2008 05:47:34 -0700 (PDT)
Received: by 10.180.220.15 with HTTP; Sat, 27 Sep 2008 05:47:34 -0700 (PDT)
In-Reply-To: <7FD1F85C96D70C4A89DA1DF7667EAE9607A217@zch01exm23.fsl.freescale.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96912>

On Sat, Sep 27, 2008 at 4:44 AM, Li Frank-B20596 <Frank.Li@freescale.com> wrote:
> From 3507b3f0b13287c5a25a31b238527b5920555c5c Mon Sep 17 00:00:00 2001
> From: Frank Li <Frank.li@freescale.com>
> Date: Sat, 27 Sep 2008 11:41:03 +0800
> Subject: [PATCH] Modify Highlight Color at File Context View.
> Author and line number can be easily found when choose special commit.
>
> Signed-off-by: Frank Li <Frank.li@freescale.com>
> ---

Patch applied.

Thanks
Marco
