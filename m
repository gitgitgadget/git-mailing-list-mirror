From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [wishlist] support git flow-like view
Date: Wed, 21 Nov 2012 12:54:09 +1100
Message-ID: <CAH5451nsOE+VkrC7YaSEWYcUd5q2vMze5QPoVGWY8Q+T=nSvww@mail.gmail.com>
References: <201211202043.00293.perezmeyer@gmail.com> <CAH5451nrcEo3Uxm0x6b39Hq1k-J4=OZPi-Cao7osaiS-w_Z1+Q@mail.gmail.com>
 <201211202113.44459.perezmeyer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Lisandro_Dami=C3=A1n_Nicanor_P=C3=A9rez_Meyer?= 
	<perezmeyer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 02:54:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TazWc-0006zG-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 02:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab2KUByb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2012 20:54:31 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55354 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912Ab2KUBya convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2012 20:54:30 -0500
Received: by mail-wi0-f178.google.com with SMTP id hm6so1434982wib.1
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 17:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aLadOPd0Og5lq46UAKaCcs41GIiYEpXXYOkpLasarU4=;
        b=D4J1V0s0xwczSpZjpNAUE80Am6ASXMYCDxqQohW7HYFGBu79UKaroh+eXcWDP1tyaR
         aHqcV0V5+O/MKQerzCbnkhPkGDaHD5K6pu7u3bucq3JAr7VS3+ufNNCQNtL8BKwDWUF7
         YTl+NJYlxTsKPJ4OYgQS+U6H65V3FBrgfFk91uBjpZc0a0bNq2lkv72yg78gj0kVV5Lu
         F53E+w22zLicws4Lz0PWmmJ2eMqG+HsGCXgvF05fjGcrRXZST+nxLmsGwptQH7y/UlDg
         PMSNVFSx1wES8HKgphPsdBGev5M5cYIRlLlOpfXefueegcMK0mhg/53+ZCqEi1g/3O3P
         Yy2Q==
Received: by 10.216.93.80 with SMTP id k58mr88806wef.98.1353462869369; Tue, 20
 Nov 2012 17:54:29 -0800 (PST)
Received: by 10.217.79.5 with HTTP; Tue, 20 Nov 2012 17:54:09 -0800 (PST)
In-Reply-To: <201211202113.44459.perezmeyer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210129>

On 21 November 2012 11:13, Lisandro Dami=C3=A1n Nicanor P=C3=A9rez Meye=
r
<perezmeyer@gmail.com> wrote:
> ...
> Well, two ideas come to my mind:
>
> - detect when using git flow (.git/config contains [gitflow "some_bra=
nch"]
> entries).

I guess this part is just so the next part can be done automatically?

> - Show "swim-lane"-like graphs, including branches that may not be pr=
esent,
> but where there (release branches often are created and merged back, =
for
> example)

I think this could be useful in general, however it might struggle
with already merged branches. I may be mistaken here, however I think
in general there is no way to specify which commits belonged to a
certain branch after they have been merged, as branch information is
not kept in the commit object. There may be some exceptions that make
it feasible at times, but a general solution would be to show any
merged branches as part of the same swim-lane, as per current
behaviour, but to have separate branch heads in different swim-lanes.
This would be a nice feature, and is similar to the behaviour in, for
example, Atlassian's Fisheye repository viewer and the GitHub network
view.

Regards,

Andrew Ardill
