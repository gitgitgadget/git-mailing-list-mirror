From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 38/44] builtin-am: support and auto-detect StGit patches
Date: Wed, 1 Jul 2015 15:25:10 +0800
Message-ID: <CACRoPnSoWvY1DM1gcnMdikXnU9nq2GDpibLZURJAd8V7O=c5pA@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-39-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbzb4E8D87nQi+dat6szOdnp56ta3bEwsUwieX=3SiJqw@mail.gmail.com>
	<CAPig+cRWno4RkemOFJj01rhx_0oFSJ-x2TMKTNxwhF1YSBxjzQ@mail.gmail.com>
	<xmqqtwtq8a8k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 09:25:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZACOl-0004om-1e
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 09:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbbGAHZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 03:25:31 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:36630 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbbGAHZM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 03:25:12 -0400
Received: by lagc2 with SMTP id c2so34743111lag.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1nO/qX8l4Znbs9tUDtebeDhCWwD7zuPb/ZugDiUskTo=;
        b=rWubpv6Mh7XYX13ul0C5efW8eCiWPgmtt89NQ521ZbFrZQncvijR5R2hU7DgGX0za5
         NC+qWPG7CtC0jTC5nxEivtMVH8YBchBORPL9s3mvk4uTp8s5x96uUKsvA8gw8IXzaQIG
         cu4+0B+p1CpdB9mOGZj4/PyVDtOKziSCgGBDw+x9GHDh3FTIsUaUoESge41z+cJtqVLh
         OsRbIb96O1JxpeL84MYg59dKI3LKciJ+pIrAsSLgmK3Znnhm6EpWtF7lFVfvMZSR1cEz
         LI9CYhTaXWxHh2ws8oArJeFAjT382m8xc8AwGLiO2xrddDT7nMSHLsUf7XEG8Z6M2/qA
         y3nA==
X-Received: by 10.152.6.105 with SMTP id z9mr23288075laz.98.1435735510233;
 Wed, 01 Jul 2015 00:25:10 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 1 Jul 2015 00:25:10 -0700 (PDT)
In-Reply-To: <xmqqtwtq8a8k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273134>

On Tue, Jun 30, 2015 at 5:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Not using any increment inside isspace(), like you showed, is the
> most readable.

Yup, I agree.

Thanks,
Paul
