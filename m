From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Possible bug: git-svn leaves broken tree in case of error
Date: Wed, 31 Oct 2007 11:23:39 +0100
Message-ID: <20071031102339.GA26565@diana.vm.bytemark.co.uk>
References: <1193729426.30755.32.camel@asl.dorms.spbu.ru> <20071031075524.GB7798@muzzle> <20071031084257.GA2911@mayonaise>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anton Korobeynikov <asl@math.spbu.ru>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 11:24:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InAkF-0005mB-8F
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 11:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758881AbXJaKYE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 06:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758880AbXJaKYD
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 06:24:03 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3922 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbXJaKYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 06:24:01 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1InAjb-00072b-00; Wed, 31 Oct 2007 10:23:39 +0000
Content-Disposition: inline
In-Reply-To: <20071031084257.GA2911@mayonaise>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 2007-10-31 01:42:57 -0700, Eric Wong wrote:

> Warning instead of die-ing here is not a good option, because it can
> lead to inconsistent author data inside populating history. I
> believe it's better to error out immediately so the user can fix
> their authors file.

Yes, that seems to be the only sensible opition.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
