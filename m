From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] config: add core.trustmtime
Date: Wed, 2 Dec 2015 20:28:13 +0100
Message-ID: <CACsJy8CT=TV8iqMsj7mU2hGn=EJ77fXqqGGdE+P7G-axC+G4YA@mail.gmail.com>
References: <1448433323-21037-1-git-send-email-chriscool@tuxfamily.org> <CACBZZX4YSvfA=BRayk8CC8ipk_nDdvJfznxjyb-upwP9PKRBSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 20:28:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4D57-0003AY-V0
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 20:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbbLBT2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2015 14:28:45 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35667 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbbLBT2o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2015 14:28:44 -0500
Received: by lfdl133 with SMTP id l133so63920648lfd.2
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 11:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=msb85shfnSXZz2vyX2W2+qCsXBTW+xLivHG62s5ETo4=;
        b=X5bAKQXfDsZQqT3gVfJBRs7SP6sTD+Ok2z5DqanaiuyinFqL1WIA3ZBCJPaE0f/HRR
         6nWkjokJpWu/Fw9/zuxEfgzHNm6mubTAj8E/QKtBvePen7ryakr1yZJt58lZKxdHXx/u
         ifMXdW7udLr3xbgva/Npve67RiG4wmAUS0vGoXaQL6GmgZBItSIh8xKE0IEumVEi3ZCz
         e9emSEMu/DxGBtdxY+2w89YX0jDCfeS9KlUGAiedZByGClzST7s4bODr5TxlK1ULav9U
         WMM+af7/TOrl9mflZBIY8iSmLHhR+BVcj3AfLB0MgjYkLCQZ4ey9Sd2wxvlYWlPaFrAw
         Qr5Q==
X-Received: by 10.25.170.149 with SMTP id t143mr3991894lfe.162.1449084523157;
 Wed, 02 Dec 2015 11:28:43 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Wed, 2 Dec 2015 11:28:13 -0800 (PST)
In-Reply-To: <CACBZZX4YSvfA=BRayk8CC8ipk_nDdvJfznxjyb-upwP9PKRBSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281911>

On Wed, Nov 25, 2015 at 10:00 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
<avarab@gmail.com> wrote:
> Aside from the slight hassle of enabling this and keeping it enabled
> this feature is great. It's sped up "git status" across the board by
> about 40%. Slightly less than that on faster spinning disks, slightly
> more than that on slower ones.

Before I forget again, you should also enable split-index. That
feature was added because index update time cut so much into the
saving from untracked cache (unless you have small indexes, unlikely).
And untracked cache can update the index often. Then maybe you can
also think about improving the usability for it to ;-)
--=20
Duy
