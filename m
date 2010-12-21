From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] trace.c: mark file-local function static
Date: Tue, 21 Dec 2010 10:19:10 -0500
Message-ID: <1292944750.26698.16.camel@drew-northup.unet.maine.edu>
References: <AANLkTinxJdASW6mQVU50grA2mUz6gt+gUND30VRK=BCN@mail.gmail.com>
	 <AANLkTimBtpOx_GBzC=g4V6jW2aiF7Hg8uALWt2NQFFZG@mail.gmail.com>
	 <1292846433.19322.1.camel@drew-northup.unet.maine.edu>
	 <AANLkTimkxJHvTAvra+B-0bAQopd8s21ZrFCPG_ALbZZ9@mail.gmail.com>
	 <1292863989.19322.27.camel@drew-northup.unet.maine.edu>
	 <AANLkTinL6RytF=x7a8URoxGQoLHhx0ip7gRNMp+nRaNB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thiago Farina <tfransosi@gmail.com>,
	"Vasyl'" <vvavrychuk@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 16:19:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV407-0000iN-WF
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 16:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387Ab0LUPTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 10:19:38 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:40125 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab0LUPTi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 10:19:38 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id oBLFJD77015402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 21 Dec 2010 10:19:13 -0500
In-Reply-To: <AANLkTinL6RytF=x7a8URoxGQoLHhx0ip7gRNMp+nRaNB@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=4 Fuz1=4
	Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oBLFJD77015402
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1293549555.82964@Yg8nCJpdCBn04dUAIDWKXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164037>


On Tue, 2010-12-21 at 21:52 +0700, Nguyen Thai Ngoc Duy wrote:
> On Mon, Dec 20, 2010 at 11:53 PM, Drew Northup <drew.northup@maine.edu> wrote:

> Yeah I would expect somebody reverting this patch _if_ this function
> is useful outside trace.c again. On the other hand, this patch saves
> do_nothing from global namespace so somewhere, some time, somebody can
> use it.
> 
> This is pretty much a clean-up patch from my perspective. Do we really
> need two paragraph explanation for marking a function static?

No, but 1 sentence would be dandy.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
