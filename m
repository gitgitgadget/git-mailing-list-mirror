From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 15/24] read-cache: read index-v5
Date: Sun, 18 Aug 2013 21:57:08 -0400
Message-ID: <CAPig+cSfrYpcGrSCQc-uTURtEk+g=2fO31TyChjrJUDUXKT20w@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
	<1376854933-31241-16-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Robin Rosenberg <robin.rosenberg@dewire.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 03:57:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBEiZ-0003IU-C8
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 03:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068Ab3HSB5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 21:57:11 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:41139 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab3HSB5K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 21:57:10 -0400
Received: by mail-lb0-f171.google.com with SMTP id t13so2576218lbd.2
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 18:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=UmljrWfqZFeupbJr14sFaFYk6h3AAbXUGe40JkwrZk0=;
        b=yqx1Vvq6YYdC7nSo4VPL+hZhNtY9hKzsPO4Kg0i/F+NMBFRCu5aYBCL/WV6PWdcYwi
         Nk6T+KC9CvLYf6Z8pItsDK1qmvE0XzQtir+uurazdGJ2XDHF8+kIJ5hz5A4v0xHCrc2s
         eLJbcVm6rmKD0ElFMwqZlQtBnXSeIaJ/AzITTAJXQuXW4YWwYoIwQrewI2sIDXVAFSjz
         Q3hZQfkUhGlqlT3BoSeF/JTEAZtIx1B/Jx5FU1IQJKz1crxJwOjjFV8UPgPyjYVUCwZn
         zao+Po+f7+iaD26/BnjlOx2Gx6VtMso4uc9SxyaEzhEGWvJy0ypULzTCL4TopTjzID9L
         /H+Q==
X-Received: by 10.152.29.201 with SMTP id m9mr10015856lah.6.1376877428799;
 Sun, 18 Aug 2013 18:57:08 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 18 Aug 2013 18:57:08 -0700 (PDT)
In-Reply-To: <1376854933-31241-16-git-send-email-t.gummerer@gmail.com>
X-Google-Sender-Auth: KlHXjELvxFcWkGi9XtUWA-zE2vA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232527>

On Sun, Aug 18, 2013 at 3:42 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Make git read the index file version 5 without complaining.
>
> This version of the reader doesn't read neither the cache-tree
> nor the resolve undo data, but doesn't choke on an index that
> includes such data.

The double-negatives are difficult to digest. Grammatical fixup:

-->8--
This version of the reader reads neither the cache-tree
nor the resolve undo data, however, it won't choke on an
index that includes such data.
-->8--

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
> Helped-by: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
