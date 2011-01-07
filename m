From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: bug in gitk: history moves right when scrolling up and down
	with mouse wheel
Date: Fri, 7 Jan 2011 21:22:39 +0100
Message-ID: <20110107202239.GN25121@pengutronix.de>
References: <20110107105523.GA6701@pengutronix.de> <4D275F02.1030100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 21:22:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbIpi-0006vg-AK
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 21:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106Ab1AGUWk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 15:22:40 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46342 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab1AGUWk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 15:22:40 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1PbIpb-00060W-7h; Fri, 07 Jan 2011 21:22:39 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1PbIpb-0001Nt-3d; Fri, 07 Jan 2011 21:22:39 +0100
Content-Disposition: inline
In-Reply-To: <4D275F02.1030100@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164755>

On Fri, Jan 07, 2011 at 12:44:18PM -0600, Neal Kreitzinger wrote:
> On 1/7/2011 4:55 AM, Uwe Kleine-K=F6nig wrote:
>> Hello,
>>
>> I don't know yet how to reliably trigger that, but it feels scary.
>>
>> If that help, it happens with the view
>>
>> 	{karo {} ^linus/master {git for-each-ref --format=3D'%(refname)' re=
fs/remotes/customers/karo refs/heads/karo}}
>>
>> If I knew how to record a video of my screen, I'd do this.  Maybe
>> someone knows?  Maybe this report is already enough?
>>
>> Happens with Debian's git 1:1.7.2.3-2.2.
>>
>
> Actually, I've wanted the ability to scroll left and right in the =20
> history pane for quite a while.  Resorting to shrinking the fontsize =
and =20
> the other columns only goes so far when trying to see a list of =20
> equivalent refs.  If the ability to scroll left and right can be kept=
 =20
> that would be cool.
you can press the middle mouse button and move it left/right to scroll
sideways. (This is standard for tcl/tk apps.) But this is not my proble=
m.

I turn the scroll wheel and the window scrolls up and down (which is
expected and good). But at the same time parts of the *content* of the
window starts moving right and so make the (virtual) window broader.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
