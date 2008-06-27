From: "Michael P. Soulier" <msoulier@digitaltorque.ca>
Subject: git-gui fails to start
Date: Thu, 26 Jun 2008 20:23:07 -0400
Message-ID: <20080627002307.GE2620@tigger.digitaltorque.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 02:52:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC2C4-0006QH-5A
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 02:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbYF0Aud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 20:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbYF0Aud
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 20:50:33 -0400
Received: from mail.storm.ca ([209.87.239.66]:44861 "EHLO mail.storm.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590AbYF0Auc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 20:50:32 -0400
X-Greylist: delayed 1630 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jun 2008 20:50:32 EDT
Received: from kanga.digitaltorque.ca (hs-216-106-102-70.storm.ca [216.106.102.70])
	by mail.storm.ca (8.14.2+Sun/8.14.2) with ESMTP id m5R0NGp4003397
	for <git@vger.kernel.org>; Thu, 26 Jun 2008 20:23:21 -0400 (EDT)
Received: from tigger.digitaltorque.ca (tigger.digitaltorque.ca [192.168.1.3])
	by kanga.digitaltorque.ca (Postfix) with ESMTP id 599CD9
	for <git@vger.kernel.org>; Thu, 26 Jun 2008 20:26:54 -0400 (EDT)
Received: by tigger.digitaltorque.ca (Postfix, from userid 500)
	id 0F8FE23E66; Thu, 26 Jun 2008 20:23:08 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86509>


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm on a CentOS Linux box, tracking 4.6 with Git 1.5.5.4 built from source.=
=20

When I run gitk on a repository it works fine, but nothing happens when I r=
un
git-gui. No error messages, nothing.=20

If I set GITGUI_VERBOSE, I get this

auto_load tk_optionMenu
source    /usr/share/tk8.4/optMenu.tcl
auto_load tk::MenuDup
source    /usr/share/tk8.4/tearoff.tcl
auto_load ::status_bar::new
source    /home/msoulier/git/share/git-gui/lib/status_bar.tcl
auto_load class
source    /home/msoulier/git/share/git-gui/lib/class.tcl
auto_load load_all_remotes
source    /home/msoulier/git/share/git-gui/lib/remote.tcl
auto_load spellcheck::init
source    /home/msoulier/git/share/git-gui/lib/spellcheck.tcl

and then it just sits there.=20

I have Tcl/Tk 8.4.9.=20

How would I troubleshoot this?=20

Thanks,
Mike
--=20
Michael P. Soulier <msoulier@digitaltorque.ca>
"Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a lot of courage to move in the opposite
direction." --Albert Einstein

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFIZDLqKGqCc1vIvggRAqwzAJoC6Yq3U+8da1xHXu+MVqZK3hTz6wCeNmtD
e3kWDFjMIrXjFG2FAGfFOBo=
=mrpL
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
