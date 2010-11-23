From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Tue, 23 Nov 2010 21:17:59 +0000
Message-ID: <AANLkTin2W4TG9BX41fkGCMTkrDdFeqpotyFFYXqNOSv-@mail.gmail.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
	<AANLkTik2+e+9M73RdPT5xha0=QGxD1cVfmLih=bDtCTU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git ML <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 22:25:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL0MY-0007Zh-4c
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 22:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403Ab0KWVZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 16:25:11 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63167 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab0KWVZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 16:25:05 -0500
Received: by qwb7 with SMTP id 7so25178qwb.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 13:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=iGJvbtCYiCDwsaOUgpbkSh0pelk+AztkkpUONh6RjMc=;
        b=K5CSElPI/ybUkZT+r8ssNsifviHpxu06U68T/CCQFZ9aJJ0MuP6L2uQLguN4463Owv
         2ajfkrTdtuvNvT4BWVHIhsbAHh6O0B97qvRJhpcw6mHa2TvYAYo5Tn1d6GXxC8ip4PAD
         xrA2x7mGrI/IcvLI9E9JlQyYRXBFHdgK3hEnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dyaqMnC6jp8aBKUbn3Wg60goX4osbeZC/0tmiBU71wfN7Kba5kchenlDZwduEsPnWP
         JMfZk1b2SoePa5hkAesFUrybrNR2GvZoJWMJIO7sQrcy3b8L+h6GNtayC2kNQvg//KjA
         c/8gf0CZg98nlPk4rAWD1Z4rm89MZjKZl1Ey4=
Received: by 10.224.19.129 with SMTP id a1mr5991748qab.154.1290547080019; Tue,
 23 Nov 2010 13:18:00 -0800 (PST)
Received: by 10.220.186.198 with HTTP; Tue, 23 Nov 2010 13:17:59 -0800 (PST)
In-Reply-To: <AANLkTik2+e+9M73RdPT5xha0=QGxD1cVfmLih=bDtCTU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162029>

On Tue, Nov 23, 2010 at 9:13 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> A reboot clears your cache. Reboot and time the first and second run
> of git status.

Thanks, after all this benchmarking I'm well aware of cold and warm
caches. The 14-15s timing is unfortunately stable across multiple
runs, after the cache was warm (without it, we got times much longer
than that).

.D
