From: Christian Couder <christian.couder@gmail.com>
Subject: Re: How to recovery a corrupted git repo
Date: Mon, 21 Feb 2011 10:27:48 +0100
Message-ID: <AANLkTimt1oR7nrhXmHugGooOAc3KTiDE6kQ3vGTznS9+@mail.gmail.com>
References: <AANLkTi=W3RckA=e-YwDJzELaEOAa+7P74V-G0G=bQhex@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git mailing list <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 10:28:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrS3p-0003vc-2s
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 10:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab1BUJ1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 04:27:51 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36946 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949Ab1BUJ1u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 04:27:50 -0500
Received: by wwa36 with SMTP id 36so5850857wwa.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 01:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=C0d7ge9VKtt1KpmT5L2D3jul2Hmv+YoZxunQN54g6Og=;
        b=N1cpiisuHHrAEFTL53ciPmxqpuQfC3ril9XXEBDMFii8yuuhGcNiWEl4pT1rnFPIHW
         x523qXVSERnqSMbn8Oet5tnvuB42ppF1h9wwtP1mtrp9MsxebvI2ceg3Puym5CoL6xy6
         20C/yAVGaznEzELgIhR/+hwMBxZu1W3MIHhQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vdsN0nfAtEWOGU3MCvrVcBCbgA+i98bYT+u5SLdsq6vDp+ns3tdOqq9tuEUcDtOIF0
         YyuI9MvySycAzpKApsDvKQB155yclSJYMZXGzCNAnk2ocAJP4IIhT5W5J4c9EVjB0neU
         Rh+UYuAe+xXxmxf4kZUPH1qgmjPMxAWS8m0QA=
Received: by 10.216.25.202 with SMTP id z52mr1877266wez.14.1298280468815; Mon,
 21 Feb 2011 01:27:48 -0800 (PST)
Received: by 10.216.241.78 with HTTP; Mon, 21 Feb 2011 01:27:48 -0800 (PST)
In-Reply-To: <AANLkTi=W3RckA=e-YwDJzELaEOAa+7P74V-G0G=bQhex@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167449>

On Mon, Feb 21, 2011 at 8:50 AM, Ping Yin <pkufranky@gmail.com> wrote:
> I have a corrupted git repo, with "git fsck", it shows
>
> missing blob b71eb55f2dbc97dafd4a769fc61f346e69a5e0af
> missing blob 282035f3ae964e1e288f352c370be8edd11d3078
> missing tree 3c20f556eecc476e3542cc522d46a62a4461fec6
> missing blob f321b578edeb452358497e832815d6cae6b36886
> missing commit 6d23f5084c975be637f7d748db82116bf84d3872
>
> And i also have a good backup repo. How can i recover the corrupted
> repo with the backup repo?

Please, have a look this FAQ entry:

https://git.wiki.kernel.org/index.php/GitFaq#How_to_fix_a_broken_repository.3F

And tell us what you did according to it.

Thanks,
Christian.
