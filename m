From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] trace.c: mark file-local function static
Date: Mon, 20 Dec 2010 07:00:33 -0500
Message-ID: <1292846433.19322.1.camel@drew-northup.unet.maine.edu>
References: <AANLkTinxJdASW6mQVU50grA2mUz6gt+gUND30VRK=BCN@mail.gmail.com>
	 <AANLkTimBtpOx_GBzC=g4V6jW2aiF7Hg8uALWt2NQFFZG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Vasyl'" <vvavrychuk@gmail.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 20 13:01:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUeQK-00049y-7j
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 13:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386Ab0LTMAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 07:00:54 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:41776 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757257Ab0LTMAx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 07:00:53 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id oBKC0cN6030028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 20 Dec 2010 07:00:38 -0500
In-Reply-To: <AANLkTimBtpOx_GBzC=g4V6jW2aiF7Hg8uALWt2NQFFZG@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=3 Fuz1=3
	Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oBKC0cN6030028
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1293451243.91741@ElrrltiRn35JZhCG8iv2CA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163993>


On Thu, 2010-12-16 at 21:43 -0200, Thiago Farina wrote:
> On Thu, Dec 16, 2010 at 8:38 PM, Vasyl' <vvavrychuk@gmail.com> wrote:
> > Signed-off-by: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
> > ---
> >  trace.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/trace.c b/trace.c
> > index 1e560cb..62586fa 100644
> > --- a/trace.c
> > +++ b/trace.c
> > @@ -25,7 +25,7 @@
> >  #include "cache.h"
> >  #include "quote.h"
> >
> > -void do_nothing(size_t unused)
> > +static void do_nothing(size_t unused)
> >  {
> >  }
> >
> If it means something, this looks sane to me.
> 
> Acked-by: Thiago Farina <tfransosi@gmail.com>

It may be sane, but why should we trust that it is without a commit
message?

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
