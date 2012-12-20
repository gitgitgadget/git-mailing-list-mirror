From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC] test: Old shells and physical paths
Date: Wed, 19 Dec 2012 21:01:28 -0800
Message-ID: <CAJDDKr78ugSo9hNerHO0Y46_bSzLJWznB3E3+6H98NjMtBwHsw@mail.gmail.com>
References: <CAEvUa7=sOPF9xwfGuBXv0CBZhT+79+8z3tm9ar_cz3q--kfqRQ@mail.gmail.com>
	<7vmwx97f0o.fsf@alter.siamese.dyndns.org>
	<CAEvUa7=_iyXxaaRs3WtxZOy5PNnncG-iMAUNkCMLJ19ZtReqaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 06:01:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlYGV-000370-AP
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 06:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908Ab2LTFBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 00:01:30 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63366 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab2LTFB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 00:01:29 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so3281200vcd.33
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 21:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=309zTFhyHmu7Vx9I7YJVldKPOrqcsufGGM4udy5azYo=;
        b=TGiwf9M7s22cDZ6003NK3yp4Xa3dhzaxn2C4XdMYR+f2EKkQp9cb6SW+gex/9TEV9t
         HiDnBnl4eKjiHe0u2ymEQ59X2eMpAmgQo0YhK8XHY89uUoVTsQ1C5bKfpYdSdaF7oDFG
         L3LfixTQPZEAPP4JTKJYDBLtRAmw4Ek+g4/zFb9YHimzHVb87uhtJ4Sjwdh7OG12qtJL
         D2ERAkGKUwAWXQdBhjs6yqxm2EcYKodw0qUMGt2WKq8MKSsHhXWoDRWXKz4+YsghMkky
         3jS+xEgyuhIWmCDmi724EP4/TJDA+UtWDMbPLJDos6UarPUPR5wvu6IpSi0jfjVeepGD
         VWqQ==
Received: by 10.220.239.14 with SMTP id ku14mr12280020vcb.57.1355979688783;
 Wed, 19 Dec 2012 21:01:28 -0800 (PST)
Received: by 10.58.182.10 with HTTP; Wed, 19 Dec 2012 21:01:28 -0800 (PST)
In-Reply-To: <CAEvUa7=_iyXxaaRs3WtxZOy5PNnncG-iMAUNkCMLJ19ZtReqaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211880>

On Wed, Dec 19, 2012 at 6:28 PM, David Michael <fedora.dm0@gmail.com> wrote:
> Hi,
>
> On Thu, Dec 20, 2012 at 12:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Is "here is a nickel, get a better shell" an option?
>
> It is, somewhat.  There is a pre-built port of GNU bash 2.03 for the
> platform, but I was trying to see how far things could go with the
> OS's supported shell before having to bring in unsupported
> dependencies.  Unfortunately, I do not believe the OS fully conforms
> to POSIX.1-2001 yet, so that means no "-P" or "-L" without going
> rogue.
>
> I'll carry test fixes for this platform locally.

Do you know if the differences are relegated to "cd",
or do other common commands such as awk, grep, sed, mktemp, expr,
etc. have similar issues?

I wonder if it'd be helpful to have a low-numbered test that checks
the basics needed by the scripted Porcelains and test suite.
It would give us an easy way to answer these questions, and could
be a good way to document (in code) the capabilities we expect.
-- 
David
