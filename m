From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: How to specify remote branch correctly
Date: Mon, 17 Dec 2012 16:52:52 +1100
Message-ID: <CAH5451=KX5eZH6AUoaQ7YcWcNcKhUp8Lk8Uvs3o=jWW=vaYiCg@mail.gmail.com>
References: <slrnkct0r3.dsp.narkewoody@zuhnb712.local.com> <CAH5451=7frqa-YHXubvO=dMK2CvVoWR-VFZ3XCmKouNiQz4gAg@mail.gmail.com>
 <slrnkcta0j.mlu.narkewoody@zuhnb712.local.com> <CAH5451kmTW+nO4V4pjSdaqhHAb=RX-tawLo=rJfuPnDRDWeSEA@mail.gmail.com>
 <1355722245-ner-6603@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Woody Wu <narkewoody@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 06:55:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkTfW-0008EM-BX
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 06:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881Ab2LQFxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 00:53:13 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:37469 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab2LQFxN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 00:53:13 -0500
Received: by mail-qc0-f180.google.com with SMTP id v28so3630702qcm.11
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 21:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=w0A35zjMWDPWFQgxJgXAKsxJ8PjRDpIWC8MPvLBI8GY=;
        b=1JjyidHPKjBqkdTxDtK1BcusCTB6ZRfrk6AIhdMdC6RHQHl6bBzYRDAwaC+f33eRIj
         8JyqJe6rFD95fFq5qGgwSZGABLfCL53S/Cqpt5A+x3/4WnLYXEKk37HChYJjrp/SzXqG
         UT93LPtl8MZSwIsZSkJj0s9CUUgDMo88HrBbrw1M3kUfyZkQOYupKpYOqOLC16bFcldr
         6rmFgRmyzAVdGR3KskhaMFP6mwr+GNxn06U8o90hsvFIni5vVSExKM1zq/S/DXYk1ZID
         b3GTtqeOKCLksX7Tf3ZmogjM2CiehOH5pMZweD75Px5X1YL4iOuehq8tZb4XxZZuzzrj
         2cig==
Received: by 10.49.3.234 with SMTP id f10mr6586362qef.52.1355723592466; Sun,
 16 Dec 2012 21:53:12 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Sun, 16 Dec 2012 21:52:52 -0800 (PST)
In-Reply-To: <1355722245-ner-6603@calvin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211634>

On 17 December 2012 16:30, Tomas Carnecky <tomas.carnecky@gmail.com> wrote:
> 'git checkout foo' has special meaning if a local branch with that name
> doesn't exist but there is a remote branch with that name. In that case it's
> equivalent to: git checkout -t -b foo origin/foo. Because that's what people
> usually want.

This is true, but I don't think it is documented. Does anyone know if
this is documented anywhere in particular? The git checkout man pages
seem to not mention it, and the git branch page doesn't seem to
mention it either, but perhaps I am just missing it?

In any case, might be useful to make this behaviour more clear.

Regards,

Andrew Ardill
