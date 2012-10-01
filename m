From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] submodule: use abbreviated sha1 in 'status' output
Date: Mon, 1 Oct 2012 12:12:30 +0530
Message-ID: <CALkWK0mqkWvveA6NX36R0L5tQE_wnRwyFu0LncLY6ORXRK-KYA@mail.gmail.com>
References: <1348926195-4788-1-git-send-email-artagnon@gmail.com>
 <1348926195-4788-2-git-send-email-artagnon@gmail.com> <50670655.3030600@web.de>
 <CALkWK0kzZvPv9jFBF=ibMzcNt-jxq4RFjy7pL173+Y4_S0jhWA@mail.gmail.com> <50670E39.8080101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 08:43:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIZiX-0004yR-Cs
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 08:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698Ab2JAGmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 02:42:52 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42512 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab2JAGmv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 02:42:51 -0400
Received: by qchd3 with SMTP id d3so3415930qch.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 23:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Pg2d3B6oCF8pReBO8RnwJ06zIVOwsN0/QVPIbdgGQKM=;
        b=TYdbir7CKFul+T/ohIb/xcPE65OPk4fNCYeYZyra+dwgT+gh6T8AWr1A1lAyiaPo/9
         MuoBLJwuUIZoWpH01JD9TRtF9G9Z1VhoHXa7oH8lP3H22Qy2BbE03j30bcNezfRJHpsZ
         M7WmhDUP8gKDK0znBfSWwtONIJ5K8fNpRORlRURLDz4l3sSEL4CTYz0sRBe7VhSbwSfO
         LcXlWRuxcKnyZEp1lF5TWualrUS1JbTFPTZC+HLrOUhuyd7/yCDnG0jvOZgLnuxWFVQD
         mZEcUtsx8Y105Ld+XVBxKZn90v6L29rbvLScJ0IZxmn/Ti7lVHDiL9yFIZbHCRLQRRj2
         mngw==
Received: by 10.224.78.141 with SMTP id l13mr34613644qak.25.1349073770954;
 Sun, 30 Sep 2012 23:42:50 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Sun, 30 Sep 2012 23:42:30 -0700 (PDT)
In-Reply-To: <50670E39.8080101@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206717>

Jens Lehmann wrote:
> I suspect you got the idea for this patch from Marc's recent comment:
> [...]

Yes, I did.

> That is just a single user so far indicating your patch /could/ be an
> improvement. I think we need quite some more votes on that before we
> should do a change like this.

I thought it's a porcelain command like 'git status'- we don't need
votes to change the output format of 'git status', do we?

Ram
