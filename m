From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [StGit PATCH 1/2] Try "stg sink" without applied patches
Date: Mon, 30 Jun 2008 09:53:22 +0200
Message-ID: <bd6139dc0806300053m4325104dx145cd8840c630453@mail.gmail.com>
References: <20080629224440.9267.3591.stgit@yoghurt>
	 <20080629224541.9267.19258.stgit@yoghurt>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org,
	"Erik Sandberg" <mandolaerik@gmail.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 09:54:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDEDM-0004R9-RW
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 09:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbYF3HxY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 03:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbYF3HxX
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 03:53:23 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:60629 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbYF3HxW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2008 03:53:22 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1433932wfd.4
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 00:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0ch0/nQ4aqS0tblXAFmTC11bWEHgINAH3XLBVqHGVs8=;
        b=J9YkQZidsO+7yO+JGqo8wOtBX8M6wsz2ruq7s9pBIteJogQSgsMkQzDHP9l6VlW+Ua
         qXAE9Bz4ueKGJc+dBksVOANSdg+4eQ5AzYsgzPKxZgoJjnWGr5tfXKArKSN8FcUqreLC
         4jPyAZB6LuMjwiMhV0xywkKxX2ylNqCavvHwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Gu8J+yrMverZPHeSFWvNyxeWr3f2+TAOhaJcx2WP2+w/9D1sBZhHxgoWNUrqu+Aqb6
         epVGHKeAvGSHLYaw4sFNMoHOXomPoaaRUBzQkxq15LVkInt/nYNEbBHu7idFsTkntbj+
         W33kqr4+o/DPI0wXcLYOGyHCHmPQzXtc5fbI8=
Received: by 10.142.214.11 with SMTP id m11mr1743123wfg.95.1214812402059;
        Mon, 30 Jun 2008 00:53:22 -0700 (PDT)
Received: by 10.143.29.11 with HTTP; Mon, 30 Jun 2008 00:53:22 -0700 (PDT)
In-Reply-To: <20080629224541.9267.19258.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86890>

On Mon, Jun 30, 2008 at 12:45 AM, Karl Hasselstr=F6m <kha@treskal.com> =
wrote:
> (The implicit sink testcase actually passes, but that's just because
> the test suite can't distinguish between a program bug and an orderly
> abort.)

Yes it can, that's where "test_must_fail" comes in.

<snip>

> +test_expect_success 'sink without applied patches' '
> +    test_must_fail stg sink
> +'
> +

Like that.

--=20
Cheers,

Sverre Rabbelier
