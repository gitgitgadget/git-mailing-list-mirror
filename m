From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 00/19] Make git-pull a builtin
Date: Fri, 19 Jun 2015 18:11:36 +0800
Message-ID: <CACRoPnSP4sxE7z4pTYe2TZVCHAie0Sad_tS3zW=znksjusXN1g@mail.gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
	<xmqqfv5oepvh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 12:12:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5tH1-0002Kd-As
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 12:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbbFSKLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 06:11:39 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38859 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbbFSKLh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 06:11:37 -0400
Received: by wibdq8 with SMTP id dq8so13953783wib.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 03:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZzuUO0F5gpNrk++/2zhO2108cOOH/I56GLwyUAPVscw=;
        b=Nqf+FIQitwdTYMlttkVUtF7tw4R4bCp1TZkvU1HRDUmKOg14r1uMGeGxo4XTtr6wHx
         dmq5TJDczOCGzxZdWpyC13U5HjJgrrohj8bCPuIKgf0VLXs0+havwdwbxJDom5wXzxL8
         cEf1VG/B+OCwVujVJo4FXOiX23kNOYTRS2CrPegw0UzGfu9NNNlATtc/0RWsdOr7eG3W
         bNhQrDhXPf5zu/1tfRsfKfRWUNz+JmdXjBmmBANYvsMMXpz6qrZ5p4eoY69h5J7KFoMA
         ftInSNx1homnqKf5tVSlxx+dVwapgbde4tiEVk/fsBf+7Yay/K3JbqT2MLWa5Mi0NXDx
         2y/g==
X-Received: by 10.194.62.205 with SMTP id a13mr23364297wjs.98.1434708696289;
 Fri, 19 Jun 2015 03:11:36 -0700 (PDT)
Received: by 10.194.85.113 with HTTP; Fri, 19 Jun 2015 03:11:36 -0700 (PDT)
In-Reply-To: <xmqqfv5oepvh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272120>

On Fri, Jun 19, 2015 at 4:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I didn't look carefully, but does that mean 04/19 has the "what if
> you start from a subdirectory and are still using the scripted one?"
> issue we discussed recently for "am"?

It does, but git-pull.sh does not care about the original working directory, no?

Regards,
Paul
