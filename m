From: Shawn Pearce <spearce@spearce.org>
Subject: Re: smudge/clean filters and SHA1 hashes
Date: Fri, 2 May 2014 14:07:02 -0700
Message-ID: <CAJo=hJurLa9rdHNHS01uW3FEd_yNPzdFE8X4xaOWCFCnzF7MUg@mail.gmail.com>
References: <CADsUFkQLtUDpoiSqj-UYeyz1a-WZPh9vN+RW4ti8ut=22QwL4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Fri May 02 23:07:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgKgA-0003By-5l
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 23:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbaEBVH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 17:07:26 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63007 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbaEBVHX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 17:07:23 -0400
Received: by mail-wg0-f44.google.com with SMTP id a1so2645572wgh.27
        for <git@vger.kernel.org>; Fri, 02 May 2014 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NbfYRiM4nm2ha+IS3iGqyJo0W8QMSEKl0bLZBHf3NVw=;
        b=YqIRFH+whGeJOt9Qi/Sg/VhN+kJtp5z0vOG28V5aWJ9pJVJpXe67YDNwsp55VRwDzS
         WRE+qa9T/F4J3/1IIikQ48L4u6n70uX6B7yxiEwbzjIDNY6n8R15LyiDiUU8bUGshXn3
         romWN/pghemkxlC2OrZ0dKwhhKXNIv56HlxV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=NbfYRiM4nm2ha+IS3iGqyJo0W8QMSEKl0bLZBHf3NVw=;
        b=gqjcsGrHrBX4Gq7g5WxR5969wPxn5dy226x1aI3fMgb/XTno2xbmEFN9tnp3kbiXGx
         d5q+83cwQ0U597ndL9YrDIEXoq35viad2cJfbulpAp0brjCqz7ZE4L3MQc/v0lkAP02N
         kdVK8Kx7cZgGu6WNcO3MkW/9uFh7I+M/idma9uhNdJWZvN/Dj406zCPDPO6UTq8dxcEA
         zyNTzsZCmGgtGtprMsE8SQQByW37x4PgLIHUncaKunjWLjA6wxJXeyFDNzHhJ67H7mWO
         I/HHkFSRU7ceK4VtPG4zLl1nBSxV9je8FlS7nYTrfyrrpmjlPakfrddCyoPrGXn7ru9n
         lGGg==
X-Gm-Message-State: ALoCoQmnu382ipLRm0i/wHQs63l91LeDwojuj5TZiptnQSFSF/AMTNyOCVei4+RfP4Vu7SnKpTB2
X-Received: by 10.180.100.129 with SMTP id ey1mr4676574wib.60.1399064842505;
 Fri, 02 May 2014 14:07:22 -0700 (PDT)
Received: by 10.227.91.202 with HTTP; Fri, 2 May 2014 14:07:02 -0700 (PDT)
In-Reply-To: <CADsUFkQLtUDpoiSqj-UYeyz1a-WZPh9vN+RW4ti8ut=22QwL4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247982>

On Fri, May 2, 2014 at 2:05 PM, Leo Razoumov <slonik.az@gmail.com> wrote:
> surprisingly, searching this list and by way of Google
> I cannot find an answer to a simple question:
>
> In presence of smudge/clean filters which SHA1 hash
> (clean content or smudged content) gets stored in the repository?

The clean version is used to obtain the SHA-1.
