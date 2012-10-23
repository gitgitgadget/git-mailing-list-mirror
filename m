From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv2] git-status: show short sequencer state
Date: Tue, 23 Oct 2012 16:02:53 -0400
Message-ID: <1351022574-27869-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Junio C Hamano <gitster@pobox.com>,
	konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 22:13:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQkqx-0002hD-2K
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 22:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992Ab2JWUM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 16:12:57 -0400
Received: from mtv-iport-4.cisco.com ([173.36.130.15]:26692 "EHLO
	mtv-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964985Ab2JWUMx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 16:12:53 -0400
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2012 16:12:52 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=143; q=dns/txt; s=iport;
  t=1351023173; x=1352232773;
  h=from:to:cc:subject:date:message-id;
  bh=GexFFtBPKvlDj6ZBNwpDvpm8Kb/J4k9ai0Xl4Jg/QPE=;
  b=epIe71m+d2f5cXGE4yX4tU1s1Ebv7J9xcckcK2IUj93L34v56O7TCksK
   wgELsRS7MV9cIxaokEvQ02Fev1wqP+M89tA24ZNA1uPgsmQomyBOC1p4u
   PB1Es/j0NIgul/oL2l8czzljSvdK/oMjgJjmPstf+Vz4uZ9v0kMSGVpcm
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvwEAKH2hlCrRDoG/2dsb2JhbABEwX2BCII3AWaBc4dhAZtej1yQM48bgyMDlXKOToFrgws
X-IronPort-AV: E=Sophos;i="4.80,637,1344211200"; 
   d="scan'208";a="62023951"
Received: from mtv-core-1.cisco.com ([171.68.58.6])
  by mtv-iport-4.cisco.com with ESMTP; 23 Oct 2012 20:03:16 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by mtv-core-1.cisco.com (8.14.5/8.14.5) with ESMTP id q9NK3FWG014242;
	Tue, 23 Oct 2012 20:03:15 GMT
X-Mailer: git-send-email 1.8.0.2.gc921d59.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208241>

Updated per Matthieu's comments, adding Sign-off and fixing my prefix to have a little "v2" on the end.

Sorry for the extra noise.

Phil
