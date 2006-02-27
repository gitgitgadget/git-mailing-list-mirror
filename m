From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] Handle branch names with slashes
Date: Mon, 27 Feb 2006 12:29:51 +0000
Message-ID: <1141043391.3438.66.camel@pc1117>
References: <20060214173509.GA8666@diana.vm.bytemark.co.uk>
	 <20060217014117.12525.21330.stgit@backpacker.hemma.treskal.com>
	 <43F53C76.6080902@vilain.net>
	 <20060217042108.GB28114@diana.vm.bytemark.co.uk>
	 <20060227121108.GA22398@diana.vm.bytemark.co.uk>
Reply-To: catalin.marinas@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 13:30:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDhWO-0001Qi-Vp
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 13:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWB0Ma0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Feb 2006 07:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWB0Ma0
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 07:30:26 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:23712 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751833AbWB0MaZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 07:30:25 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k1RCTquc010423;
	Mon, 27 Feb 2006 12:29:52 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Mon, 27 Feb 2006 12:29:52 +0000
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060227121108.GA22398@diana.vm.bytemark.co.uk>
X-Mailer: Evolution 2.0.4 
X-OriginalArrivalTime: 27 Feb 2006 12:29:52.0069 (UTC) FILETIME=[81D1E750:01C63B99]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16838>

On Mon, 2006-02-27 at 13:11 +0100, Karl Hasselstr=F6m wrote:
> There was a bug here after all: I just tried "stg pick
> multi@kha/patches" (to pick a patch named "multi" from the branch
> "kha/patches"), and StGIT tried to pick the patch from branch "kha".

I haven't applied your patch yet (too busy to properly review it).

> Looking closer, I realized that the complete patch specification
> syntax is "patchname@branchname/bottom", not
> "patchname/bottom@branchname" as I had assumed. This is obviously har=
d
> to reconcile with branch names containing /.

I don't have any strong opinion on either. Maybe we should use the
latter if it makes things easier for supporting branch names with /'s.

--=20
Catalin
