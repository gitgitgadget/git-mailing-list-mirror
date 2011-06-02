From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH 1/1] git-am: provide configuration to enable signoff by
 default
Date: Fri, 3 Jun 2011 00:40:30 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D2D2916@dbde02.ent.ti.com>
References: <1306917751-27999-1-git-send-email-nsekhar@ti.com>
 <BANLkTinorC17+21SA44Eg26GHERSpLb0Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 21:11:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSDIQ-0007hc-Gr
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 21:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab1FBTLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 15:11:00 -0400
Received: from bear.ext.ti.com ([192.94.94.41]:41018 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361Ab1FBTLA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 15:11:00 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p52JAX2T014621
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Jun 2011 14:10:35 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p52JAWVK016924;
	Fri, 3 Jun 2011 00:40:32 +0530 (IST)
Received: from dbde02.ent.ti.com ([172.24.170.145]) by dbde70.ent.ti.com
 ([172.24.170.148]) with mapi; Fri, 3 Jun 2011 00:40:32 +0530
Thread-Topic: [PATCH 1/1] git-am: provide configuration to enable signoff by
 default
Thread-Index: AcwgdYNmI3XPO/4pR4WURd8Zx94WlQA4pIhw
In-Reply-To: <BANLkTinorC17+21SA44Eg26GHERSpLb0Rw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174971>

Hi Sverre,

On Wed, Jun 01, 2011 at 21:33:14, Sverre Rabbelier wrote:
> Heya,
> 
> On Wed, Jun 1, 2011 at 03:42, Sekhar Nori <nsekhar@ti.com> wrote:
> > Provide a git config option to enable --signoff a
> > default when using git-am. This should be handy
> > for maintainers who regularly apply patches from
> > mailing lists to send them upstream and want to
> > be on the sign-off path.
> 
> Wouldn't this need tests?

Yes, I did test this (by applying mailbox with and
without this option turned on). Didn't actually try
with --rebasing that Jeff asked for in another e-mail.

I should have included test information in the patch
description.

At this point I am not sure if this patch will be
considered for inclusion. If I get to submit another
version of it, I will surely add this info.

Thanks,
Sekhar
