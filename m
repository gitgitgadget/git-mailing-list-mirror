From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv2 0/3] git-status short sequencer state info
Date: Mon, 29 Oct 2012 19:31:50 -0400
Message-ID: <1351553513-20385-1-git-send-email-hordp@cisco.com>
References: <CABURp0qBRvZQvnBbOraQ7c7DRg8v0TjnY+MOGYaWnWwjCqi23Q@mail.gmail.com>
Cc: phil.hord@gmail.com, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 00:32:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSyom-0008Fi-TI
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 00:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761141Ab2J2XcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 19:32:15 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:50522 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757744Ab2J2XcP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 19:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=367; q=dns/txt; s=iport;
  t=1351553535; x=1352763135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=KQhiqPHFK6TmPQYKBqqBYGUOk0PjhmRQ55+iQlk3R+Y=;
  b=QSUmCel/FrIvF79TN3n0KM0ctxv4DKlzkmXAV4+lrQ9AVpT6bEwlD7vM
   F0Y3o4Uwz9xDVn6pQhJaCkIPCZfoTrjmHLCDHVyLEC6EUrtos0HUfXFGF
   w0bOhYqR9q9GHNiohvkdPntgYgMlOALLrReucgaqOB9rMaBj/PCbv5Zc/
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EABcRj1CtJXG//2dsb2JhbABEwwmBCIIfAQEEEgFmEFFXO4dknAagBY8ugyQDlXSOV4Frgws
X-IronPort-AV: E=Sophos;i="4.80,675,1344211200"; 
   d="scan'208";a="136659701"
Received: from rcdn-core2-4.cisco.com ([173.37.113.191])
  by rcdn-iport-7.cisco.com with ESMTP; 29 Oct 2012 23:32:14 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core2-4.cisco.com (8.14.5/8.14.5) with ESMTP id q9TNWEaR022087;
	Mon, 29 Oct 2012 23:32:14 GMT
X-Mailer: git-send-email 1.8.0.3.gde9c7d5.dirty
In-Reply-To: <CABURp0qBRvZQvnBbOraQ7c7DRg8v0TjnY+MOGYaWnWwjCqi23Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208656>

V2 of this patch breaks it into a series, cleans up some gaffes,
and adds more flexible display options.  I still need to add some
tests.  Until I do that, maybe this should be considered a WIP.

 [PATCHv2 1/3] Refactor print_state into get_state
 [PATCHv2 2/3] wt-status: More state retrieval abstraction
 [PATCHv2 3/3] git-status: show short sequencer state
