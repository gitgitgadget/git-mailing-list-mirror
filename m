From: Jeff King <peff@peff.net>
Subject: Re: [PATCH (3rd try)] Add git-stash script
Date: Sat, 30 Jun 2007 02:12:37 -0400
Message-ID: <20070630061237.GA14344@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0706300304480.4438@racer.site> <200706300539.l5U5dHLh003989@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 08:12:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4WCO-0002wW-88
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 08:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbXF3GMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 30 Jun 2007 02:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbXF3GMj
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 02:12:39 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3351 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbXF3GMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 02:12:39 -0400
Received: (qmail 13182 invoked from network); 30 Jun 2007 06:12:59 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 30 Jun 2007 06:12:59 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Jun 2007 02:12:37 -0400
Content-Disposition: inline
In-Reply-To: <200706300539.l5U5dHLh003989@mi1.bluebottle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51194>

On Sat, Jun 30, 2007 at 02:37:09PM +0900, =E3=81=97=E3=82=89=E3=81=84=E3=
=81=97=E3=81=AA=E3=81=AA=E3=81=93 wrote:

> +ref_stash=3Drefs/stash
[...]
> +save_stash () {
> +	if no_changes
> +	then
> +		echo >&2 'No local changes to save'
> +		exit 0
> +	fi
> +	test -f "$GIT_DIR/logs/refs/stash" ||
> +		clear_stash || die "Cannot initialize stash"

Nit: this should be .../logs/$ref_stash

-Peff
