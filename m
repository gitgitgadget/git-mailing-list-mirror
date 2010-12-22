From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: "git pull" doesn't respect --work-tree parameter
Date: Wed, 22 Dec 2010 18:20:23 +0700
Message-ID: <AANLkTik9s0cLc_P=NWvpO=DhytOkLNASEM7sjzoscHo3@mail.gmail.com>
References: <AANLkTi=UtZuPQcTNnwS_fXgzRn4MHAUGS8zyTMqX9E2J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Alexey Zakhlestin <indeyets@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 12:21:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVMke-0003Py-5k
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 12:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670Ab0LVLUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 06:20:55 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51321 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab0LVLUz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 06:20:55 -0500
Received: by wyb28 with SMTP id 28so4910167wyb.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 03:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=c+ZvyySZzf4yK3sn4DPLaU1SNGToz89dgVcUpvIwRBs=;
        b=U6NUAWw5MzXd0sg+JYPHcEWixgjXDDJN0WffCQ/gB6zXnTNq8hftR8xl2N2FwOcQMD
         Q4RFaJBbbWO3JZFz2VjUUEQn+GB4xZmuwj78f/haLmFyuRbV6vpumkNevKMrtLPojdLl
         jRXMQHETX4J25kJehsezMazg70YLjnoRe9aKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=u9nT5zk8iyRmuPkSjv/XAPAEowTR3yjVdVNT0XNQYKrD6D1IrKgMfqK/oMC4KsiUCB
         ScVGlriFYNjoNa0aXBJnezF85v8cKp+/SCRA6VIXaP0WU3Ykgw4f0Dtwq2wDDcWBRADI
         8ic9XzC4bfgvDoi5FWmb2FSaCUgUXPxi5TO3g=
Received: by 10.216.177.9 with SMTP id c9mr7660158wem.34.1293016853755; Wed,
 22 Dec 2010 03:20:53 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Wed, 22 Dec 2010 03:20:23 -0800 (PST)
In-Reply-To: <AANLkTi=UtZuPQcTNnwS_fXgzRn4MHAUGS8zyTMqX9E2J@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164077>

On Tue, Dec 21, 2010 at 11:04 PM, Alexey Zakhlestin <indeyets@gmail.com> wrote:
> I am trying to use the following command:
>
> git '--git-dir=/path/to/repository/.git' '--work-tree=/path/to/repository' pull
>
> and get this error:
> "git-pull cannot be used without a working tree"

It works fine for me. What's the result of

git '--git-dir=/path/to/repository/.git'
'--work-tree=/path/to/repository' --git-dir
git '--git-dir=/path/to/repository/.git'
'--work-tree=/path/to/repository' --is-inside-work-tree
git '--git-dir=/path/to/repository/.git'
'--work-tree=/path/to/repository' --show-toplevel

?

Also what version of git are you using?
-- 
Duy
