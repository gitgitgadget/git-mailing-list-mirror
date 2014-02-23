From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] clone: allow initial sparse checkouts
Date: Sun, 23 Feb 2014 07:32:07 +0000
Message-ID: <robbat2-20140223T072340-334493350Z@orbis-terrarum.net>
References: <1393122713-4308-1-git-send-email-robbat2@gentoo.org>
 <CACsJy8BKJ4HzXLcajC8cXviD4hboRPOYhWSen7H5Ta=_JuXNjw@mail.gmail.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 23 08:32:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHTY8-0002r1-Mm
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 08:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbaBWHcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 02:32:10 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:59368 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbaBWHcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 02:32:09 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id E7C2A33F726
	for <git@vger.kernel.org>; Sun, 23 Feb 2014 07:32:08 +0000 (UTC)
Received: (qmail 18914 invoked by uid 10000); 23 Feb 2014 07:32:07 -0000
Content-Disposition: inline
In-Reply-To: <CACsJy8BKJ4HzXLcajC8cXviD4hboRPOYhWSen7H5Ta=_JuXNjw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242536>

On Sun, Feb 23, 2014 at 09:52:16AM +0700,  Duy Nguyen wrote:
> On Sun, Feb 23, 2014 at 9:31 AM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> > Presently if you want to perform a sparse checkout, you must either do a
> > full clone and then recheckout, or do a git init, manually set up
> > sparse, and then fetch and checkout.
> I think you could do "clone -n" (no checkout), set up sparse, then checkout.
Yes, I think there are a few more ways, but still would be nice to 

> 
> > This patch implements easily accessible sparse checkouts during clone,
> > in the --sparse-checkout option.
> >
> > $ git clone REPO --sparse-checkout PATH
> Or take a file as input if there are lots of paths/rules.
How much demand for taking a file of rules, and opinions of syntax to do
that vs specify on the commandline?

--sparse-checkout-from FILE
vs.
--sparse-checkout '<PATH'
or something other prefix character.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
