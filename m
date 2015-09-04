From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Compare two diffs on the command line?
Date: Fri, 4 Sep 2015 11:10:11 -0700
Message-ID: <CAPc5daVvXNWdAwiNKnQT45p03msTBEyBUq7y+ggRq0e95=_bAQ@mail.gmail.com>
References: <55E9DC44.90303@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Phil Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 20:10:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXvRc-0004CZ-QS
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 20:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759653AbbIDSKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 14:10:32 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37490 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759208AbbIDSKc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 14:10:32 -0400
Received: by igbni9 with SMTP id ni9so19704544igb.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3nA1WBz2ZVwH/ZWpxXjTPCj4d2UGMRBCnt2cYLXhuQM=;
        b=BWFGa2/aSJAUFFwLEj7XwMWvCV5kJxC20vSaMwXQP6LHSIyk+lWEacDsv55QI0couP
         djSznhqlmRIlNhgIc1Q/N0BTIuNjuWEl+Ht4ZWixvYAmfzHWFTGOL06XLF15c6CJ/43R
         Xdbn9nDt9lTeui5AMfmUxdr+17mUeFQMRX+R28jx33Sf7GDTSCfHEz+baTb0EFvdgfIO
         tiXIkB+hwGqgYjhgx71g5oKo4ZYC2cD7zs14N5D7pHgFARdfHN9qjOwm+AsBjphuI/Zl
         lDDCBCtauUlqjuo7SqmuCr6WTvjXii9XSazeQktMTWSiRTD8gCN3yZU30/FLGR17LOKn
         kLZQ==
X-Received: by 10.50.33.68 with SMTP id p4mr6044408igi.60.1441390231542; Fri,
 04 Sep 2015 11:10:31 -0700 (PDT)
Received: by 10.36.79.69 with HTTP; Fri, 4 Sep 2015 11:10:11 -0700 (PDT)
In-Reply-To: <55E9DC44.90303@ubuntu.com>
X-Google-Sender-Auth: bZqc0SfFyZTAUvGYo5gtt9lI2j4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277326>

On Fri, Sep 4, 2015 at 11:00 AM, Phil Susi <psusi@ubuntu.com> wrote:
> If you have a commit that exists on two branches, in gitk you can mark one,
> then select the other and choose to compare the two.  This results in a diff
> of the two diffs, rather than a diff between the two trees, which include
> many other changes that have nothing to do with either commit.

I think you are looking for the interdiff(1) tool.
