From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: How to re-use setups in multiple tests?
Date: Mon, 1 Oct 2007 15:40:40 +0200
Message-ID: <20071001134040.GA4311@diana.vm.bytemark.co.uk>
References: <550f9510710010327l3e729ff1tbbb9b6c674c1cb11@mail.gmail.com> <Pine.LNX.4.64.0710011243230.28395@racer.site> <550f9510710010516s305c843br53da294f65318862@mail.gmail.com> <Pine.LNX.4.64.0710011336530.28395@racer.site> <550f9510710010546q55209759k4770cd3e78121cfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Tom Clarke <tom@u2i.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 15:41:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcLWC-0007uN-VZ
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 15:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbXJANk5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Oct 2007 09:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbXJANk5
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 09:40:57 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1894 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbXJANk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 09:40:56 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IcLVo-00019f-00; Mon, 01 Oct 2007 14:40:40 +0100
Content-Disposition: inline
In-Reply-To: <550f9510710010546q55209759k4770cd3e78121cfc@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59615>

On 2007-10-01 14:46:46 +0200, Tom Clarke wrote:

> On 10/1/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > > I suppose I could find the old pre-rebase head and work with
> > > that, but that doesn't seem that clean to me.
> >
> > You can use "git reset --hard master@{1}", and it really escapes
> > me why this should not be clean, and why you want to jump through
> > hoops instead using a much more complicated technique.
>
> That'll be because my git knowledge isn't good enough to make it
> clean. Thanks for the suggestion :-)

Another even more foolproof way would be to have the setup create a
(lightweight) tag, and let each subtest reset to that tag.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
