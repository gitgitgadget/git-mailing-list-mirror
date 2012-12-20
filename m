From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [RFC] test: Old shells and physical paths
Date: Thu, 20 Dec 2012 02:28:36 +0000
Message-ID: <CAEvUa7=_iyXxaaRs3WtxZOy5PNnncG-iMAUNkCMLJ19ZtReqaw@mail.gmail.com>
References: <CAEvUa7=sOPF9xwfGuBXv0CBZhT+79+8z3tm9ar_cz3q--kfqRQ@mail.gmail.com>
	<7vmwx97f0o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 03:29:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlVsb-0005J3-19
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 03:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab2LTC2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 21:28:44 -0500
Received: from mail-vb0-f42.google.com ([209.85.212.42]:58657 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab2LTC2n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 21:28:43 -0500
Received: by mail-vb0-f42.google.com with SMTP id fa15so3223918vbb.29
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 18:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TVTzhY+bebCM3yfhgvBL+wVHGPvKGItOycl6DaOPhUU=;
        b=buGsntyAnMHddB/2gZwEFh4mOuuTV3YA5N5DWteJVxLnxPhjopeXY060QWP18PWS+/
         ym9Gzkabtpz/frgVOu0edz0BWDu9wGn+BPAV/U78V68QzfJkLK2X1i/ZXZvt61+BV0bx
         tPwlOnnF40gHN2T2kXdgugA+qIwQ1hHbxSphyQgL83RgPxMYXyXNfENiCsCTSkXumzvj
         nExNbwIt2k45FRqsI0DwXzeEf3/9SnYrruMiLN+tFvlgziiDhtwYjt0K/BYQM3bFwDDr
         G8wxlbDRGX6HBMJNbvKDcgGuqVvniOurjM/XsRD/Xnx5ZM7+OK5dItxmRYJJz1zXpqK9
         PO6w==
Received: by 10.52.98.36 with SMTP id ef4mr10455765vdb.104.1355970516618; Wed,
 19 Dec 2012 18:28:36 -0800 (PST)
Received: by 10.58.85.138 with HTTP; Wed, 19 Dec 2012 18:28:36 -0800 (PST)
In-Reply-To: <7vmwx97f0o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211870>

Hi,

On Thu, Dec 20, 2012 at 12:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Is "here is a nickel, get a better shell" an option?

It is, somewhat.  There is a pre-built port of GNU bash 2.03 for the
platform, but I was trying to see how far things could go with the
OS's supported shell before having to bring in unsupported
dependencies.  Unfortunately, I do not believe the OS fully conforms
to POSIX.1-2001 yet, so that means no "-P" or "-L" without going
rogue.

I'll carry test fixes for this platform locally.

Thanks.

David
