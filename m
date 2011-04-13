From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] whatchanged: always show the header
Date: Wed, 13 Apr 2011 21:38:32 +0200
Message-ID: <20110413193830.GA8560@bee.lab.cmartin.tk>
References: <20110413092620.GA3649@bee.lab.cmartin.tk>
 <1302696644-21809-1-git-send-email-cmn@elego.de>
 <7vlizem9bx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 21:38:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA5ti-0002m6-Jn
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 21:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758095Ab1DMTie convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 15:38:34 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:33431 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757979Ab1DMTie (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 15:38:34 -0400
Received: from bee.lab.cmartin.tk (brln-4dbc4b17.pool.mediaWays.net [77.188.75.23])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 6E3444612D;
	Wed, 13 Apr 2011 21:38:19 +0200 (CEST)
Received: (nullmailer pid 8694 invoked by uid 1000);
	Wed, 13 Apr 2011 19:38:32 -0000
Content-Disposition: inline
In-Reply-To: <7vlizem9bx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171479>

On Wed, Apr 13, 2011 at 08:58:58AM -0700, Junio C Hamano wrote:
> Carlos Mart=EDn Nieto <cmn@elego.de> writes:
>=20
> > Set the always_show_header option to fix this.
>=20
> I don't think that is correct.  The command should skip empty commits=
, no?

Yes, from the man page, they should be skipped unless "-m" is passed.

>=20
> I'll take a look at this later when I have time.  I plan to tag -rc2
> today.

Maybe unconditionally unsetting QUICK would give the desired
result. Tomorrow I should be done changing cmd_log_init to use the
parse options API so it's easier to catch "--quiet".

   cmn
=20
