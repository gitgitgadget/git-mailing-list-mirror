From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: http://tech.slashdot.org/comments.pl?sid=1885890&cid=34358134
Date: Sat, 27 Nov 2010 19:36:20 +0100
Message-ID: <AANLkTim0FeCE94R1zacOxGiEP8vZRSoDqNuNRUotnd9B@mail.gmail.com>
References: <AANLkTinTsn4PP8VxJX=pUOYKtoybCxqB0+-p9kNRGMj8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 19:36:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMPdL-0002xx-Ph
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 19:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab0K0SgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 13:36:23 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34588 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013Ab0K0SgW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 13:36:22 -0500
Received: by fxm15 with SMTP id 15so1444227fxm.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 10:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=bzdoClJIuEu8CvqhRl7WKbbJaKDDP3nF9gpR+OWb73I=;
        b=A+oodGgjamFov8rtANZe/2YVpNl0QtnE7r/Iwif5jlL8A+l2KyXoD+C6BdhDKjKP5+
         eXywyU8y/XML/BHJ7+sAirC+ILEwa5XF5zt+Wos5xpzBtP6F2RKAnGn6rF35Jkt17QC7
         7K8n1MC+Xzv2OzWDg80GSjUtebI1FaFgf3stg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=S4qxpeFoy0YbkSZ07Bhse50C37tOffKkTeZMjBnPh64ROP453vg2XrtLdSLpS3b264
         Ld8Qn+jo4mJTijucpA35OsT0lwZoxRoDnFEnoUA76efb0l9XGWB5hVykqBGG/nlRD2o2
         RFK+IQjhTZq1unghew55DUfKDtW+4hZMDKzFs=
Received: by 10.223.118.132 with SMTP id v4mr3450762faq.87.1290882980682; Sat,
 27 Nov 2010 10:36:20 -0800 (PST)
Received: by 10.223.86.134 with HTTP; Sat, 27 Nov 2010 10:36:20 -0800 (PST)
In-Reply-To: <AANLkTinTsn4PP8VxJX=pUOYKtoybCxqB0+-p9kNRGMj8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162322>

On Sat, Nov 27, 2010 at 18:33, Luke Kenneth Casson Leighton
<luke.leighton@gmail.com> wrote:

> I believe it is important that git-over-p2p be given a higher
> priority than it is at present.

We give "priority" to the stuff people submit patches for. There isn't
a git-over-p2p because nobody is working on it, would you like to work
on it?

I'm also not convinced that this is actually needed. It's trivial to
set up a p2p-like network by just emulating a darknet by manually
adding remotes & fetching/pushing.

That's not viable for the stuff that usually gets distributed on p2p
networks, but it sure is viable when you have people working on the
same codebase. Which would be the use case for a git-over-p2p client,
right?
