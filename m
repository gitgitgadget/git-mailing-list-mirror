From: Christian Couder <christian.couder@gmail.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Wed, 17 Feb 2016 17:04:09 +0100
Message-ID: <CAP8UFD2OY_QMqvEew5+V+P4653REm_P0R4_JiwwBfo0O6727Xw@mail.gmail.com>
References: <vpqoabox66p.fsf@anie.imag.fr>
	<CAP8UFD0UxB6Z1UU=4Bkz0Yt2KE+AkrttQeTx2oY9v9O78f9qow@mail.gmail.com>
	<vpqd1s2e74l.fsf@anie.imag.fr>
	<20160212130446.GB10858@sigill.intra.peff.net>
	<vpqd1s04zzs.fsf@anie.imag.fr>
	<CAGZ79kbUG73eo5YvedbVB0bmZduMeCWNpbCRK4Adr9XDebsbQQ@mail.gmail.com>
	<alpine.DEB.2.20.1602171353260.6516@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 17 17:04:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW4aO-0003tK-Jz
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 17:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424175AbcBQQEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 11:04:13 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34846 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424172AbcBQQEL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 11:04:11 -0500
Received: by mail-lb0-f172.google.com with SMTP id bc4so12205208lbc.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 08:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4n9mCeC50xVcUB5CyHEQPe/gMRVPjbDQYo+xoDwVXOU=;
        b=0ebLq2ZttSztoruJX5zF0E+LOlez4nY7HR+8KS/s7ASBG4njtJoCp6Q7dPcLZOs6OP
         2/RnsFknGWVIIuY0yBMuXPYLIpcpR2F1Y9iTLhMc5VhdPsnCUNROWyGEbyBCT0ZS7Tov
         TBSX66qegQfjnhGCBrdtSi6pQXDWr8tQq1FbKgHdAQ/s4w3DXm3TSUL9jNKbRA7XNOYz
         5UB3Vh8KehP2o6eBwvGgDgcuZUF8ioMkXTCpWRVrpPLrZnySGWagfjyrwRHxs3TPWkuh
         +keotW9L3JW8pZn7YsJvBhxdVZ+NVAz3yaobuEl5RE/glSGmiSTKkBjpLzpTjcWGPBou
         cbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4n9mCeC50xVcUB5CyHEQPe/gMRVPjbDQYo+xoDwVXOU=;
        b=N5tWtB3RRuq8+JOIiSIuRmEVtFCDcBkCHYaeleHdYl94j6a1EIdWWLsAB7uYUNxLmk
         ypXcYCITn1V9/3ka/RLH4ncuchdtnYjvJukqVY5sRvp15U2Waf70+8+i3s+0agHlDv22
         dC4P2l84a8Gd0lLzcsdT52ODxtwHXajsDV2KEfhM/t7odbNo+zHxfMusMOUV3mUKV3gh
         0aikNcOl8Bh9QrBSoECoaVsL2r6DvkxLAzooi6cL+GSPmTifkLbNGuaK2p3GeUS9R+si
         iL8mntl/s2WH9lvaG2vTyRreDZ/gJxTRblVYMAX7K39EUU0dVELcNSTyWFa6T3gSxim+
         oHeQ==
X-Gm-Message-State: AG10YOT/zbdlQCMsihL4t22xwws+3/a0CLsCBnCFIMpKzJI8eICMVXq1NfgptqkenLoMxhC+UCoROilR6M/RGA==
X-Received: by 10.112.211.168 with SMTP id nd8mr1144937lbc.116.1455725050012;
 Wed, 17 Feb 2016 08:04:10 -0800 (PST)
Received: by 10.25.152.199 with HTTP; Wed, 17 Feb 2016 08:04:09 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1602171353260.6516@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286508>

Hi Johannes,

On Wed, Feb 17, 2016 at 2:09 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
>> Then there is also git-bisect.sh with nearly 700 lines, which is also
>> not as easy.
>
> Nothing is easy, but bisect has a much better chance to be finally
> converted into a builtin: there is already a bisect--helper builtin, and
> all we need to do is to move more parts over, piece by piece. It does not
> even have to be a complete rewrite.

I don't know which has a better chance to be finally converted, but
it's true that for bisect, the bisect--helper builtin could help, and
it can be done piece by piece.


> I count 22 functions with bisect_start and bisect_replay being the obvious
> elephants. Personally, I would recommend starting with bisect_next_check
> (which would imply get_terms and bisect_voc, of course). It could even be
> a mini project for a prospective student.

Not sure it is small enough for a mini project, but sure it is a good
choice to start with.

Thanks,
Christian.
