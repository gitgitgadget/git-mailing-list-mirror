From: Junio C Hamano <jch@google.com>
Subject: Re: [PATCH] sequencer: remove additional blank line
Date: Thu, 19 Apr 2012 15:38:11 -0700
Message-ID: <xmqq8vhruz3g.fsf@junio.mtv.corp.google.com>
References: <1334783245-8733-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 00:38:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKzzV-0005Ph-SI
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 00:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786Ab2DSWiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 18:38:13 -0400
Received: from mail-yw0-f74.google.com ([209.85.213.74]:57070 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756542Ab2DSWiM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 18:38:12 -0400
Received: by yhgm50 with SMTP id m50so1039493yhg.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 15:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sJWH5qR1uiuxsdJGXKYhYVeWsyaN0ZGTOB+1g7X6tNI=;
        b=hgyyJx097aYvPZbLU1SK5aB26qTsH0CDjAkd/PiKhK9XNKH9msVMKdXjyPPL3g7AUc
         eh9LIoougfx1WsdBHvdp4PNw83rC05bDCZF3Cr5t7BoBgac3PQqluW5MmQDXVlpTSysk
         Erqq+EIfSLzsv4tTqEDRNn3ixS3RUTax4VBJqcss/5JFIKz5q9sUk+Bcd5K0xX3pu66Q
         se5yCHDndHZ/hF1tM67g+BXeKbp/DJKppcc+4iYSc/iqFBE1XJr8glMRGnCwSMDRvDOJ
         iHAakiO7uZ0UZ1b/hZ5k1fIijxXAbOEuQAfkCMl8E4+7JiszjK98XwS8W0boXfHqNjD0
         BXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=sJWH5qR1uiuxsdJGXKYhYVeWsyaN0ZGTOB+1g7X6tNI=;
        b=NmpJiuEaFtfZQFolQYvGNeTAUMriSYZtpzETO694HWUIFf+iU7EJR8A9ABs+N13p+e
         NSepfd9zP7I1rfH5p9vkrM286/ckR7SwYNbNb6ZmG8+hw28w/0EAXtLlKxw759e0On0a
         T+FEaNLazsD9sN42vvpcSb/9+cvqI/msQ8SsdhziVsHIu0aHO4bqU2+4Dcda3LXQW8f5
         9UsJGciFlHSUebvn8rZeO41nWClQpMVyhWwoi3QKROwIPjaFmFEB8Tqau8HaPzH1g+oJ
         wr40fbh8uk7E7vT7gd/v5uU3f98+RcyeoKtR6rWF0iIgMWwSpHILd7vgAJENYURFw8O0
         cTgQ==
Received: by 10.236.165.99 with SMTP id d63mr4731288yhl.7.1334875091757;
        Thu, 19 Apr 2012 15:38:11 -0700 (PDT)
Received: by 10.236.165.99 with SMTP id d63mr4731276yhl.7.1334875091698;
        Thu, 19 Apr 2012 15:38:11 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id y53si3443353yhe.4.2012.04.19.15.38.11
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 19 Apr 2012 15:38:11 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 94D671E004D;
	Thu, 19 Apr 2012 15:38:11 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 3E0B2E120A; Thu, 19 Apr 2012 15:38:11 -0700 (PDT)
In-Reply-To: <1334783245-8733-1-git-send-email-ralf.thielow@googlemail.com>
	(Ralf Thielow's message of "Wed, 18 Apr 2012 23:07:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmf2z3cQP/K148ZQ8y9VfLVRWN0mOgNePMxh5XiBnl4/s/lJuIfRyzU3in7dDe3sGRnIFGQ0fP7emE5pmUDZy/mv0vD6xuu0WUs4VmF/DLUmrvypkO3786hjfdJh+v/XqFZTE0lptPrv5tWSdM0pOBs9yhTonBEZ3XykAwGR7HwZPElee4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195971>

Ralf Thielow <ralf.thielow@googlemail.com> writes:

> Remove an additional blank line between the
> headline and the list of conflicted files after
> doing a recursive merge.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
> ---
> Normally, the list of conflicted files come directly after
> the headline like this
>
>     Conflicts:
>         folder/file
> 	...

Hrm.

A funny thing is that your "Normally" is a misconception caused by a
regression in 1c7b76be (Build in merge, Jul 7, 2008).  Before that
change, this message was "Conflicts:" followed by an empty line and it
was consistently so between "merge" and "cherry-pick", but the C rewrite
of "git merge" broke it.

I do not care deeply either way; unifying them again to use one less
line is probably fine.
