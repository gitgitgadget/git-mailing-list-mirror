From: "Jason Garber" <jgarber@ionzoft.com>
Subject: RE: [PATCH(TIC)] push: annoy all users by deprecating the default semantics
Date: Tue, 19 Feb 2008 10:21:33 -0600
Message-ID: <E7DE807861E8474E8AC3DC7AC2C75EE50542F7F6@34093-EVS2C1.exchange.rackspace.com>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com> <20080219043353.GA23239@sigill.intra.peff.net> <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com> <20080219150826.GA24499@sigill.intra.peff.net> <76718490802190718t5e70abb2x8f96fc7154576594@mail.gmail.com> <20080219152549.GC24499@sigill.intra.peff.net> <alpine.LSU.1.00.0802191610480.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: "Jay Soffian" <jaysoffian@gmail.com>, <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVK1-00014G-Qo
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbYBSQ1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbYBSQ1W
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:27:22 -0500
Received: from server107d.exghost.com ([69.20.5.102]:3637 "EHLO
	server107.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752825AbYBSQ1V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2008 11:27:21 -0500
X-Greylist: delayed 65530 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Feb 2008 11:27:21 EST
Received: by server107.appriver.com (CommuniGate Pro PIPE 5.2.0)
  with PIPE id 86700268; Tue, 19 Feb 2008 11:27:08 -0500
Received: from [72.32.49.6] (HELO FE2.exchange.rackspace.com)
  by server107.appriver.com (CommuniGate Pro SMTP 5.2.0)
  with ESMTP id 86692708; Tue, 19 Feb 2008 11:21:35 -0500
Received: from 34093-EVS2C1.exchange.rackspace.com ([192.168.1.18]) by FE2.exchange.rackspace.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 19 Feb 2008 10:21:41 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LSU.1.00.0802191610480.30505@racer.site>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH(TIC)] push: annoy all users by deprecating the default semantics
Thread-Index: AchzEtoqSXjA+KWITp2TD58eSQXO/gAAGSew
X-OriginalArrivalTime: 19 Feb 2008 16:21:41.0128 (UTC) FILETIME=[82836080:01C87313]
X-Policy: GLOBAL
X-Policy: GLOBAL
X-Policy: GLOBAL
X-Policy: GLOBAL
X-Primary: jgarber@ionzoft.com
X-Note: This Email was scanned by AppRiver SecureTide
X-ALLOW: jgarber@ionzoft.com ALLOWED
X-Note: Spam Tests Failed: 
X-Country-Path: PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 72.32.49.6
X-Note-Reverse-DNS: fe2.exchange.rackspace.com
X-Note-WHTLIST: jgarber@ionzoft.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 75 76 122 
X-Note: Mail Class: ALLOWEDSENDER
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74429>

+	if (!all && argc < 2)
+		warning("Pushing without branch names is deprecated.\n"
+			"Too many users just assumed what it should
do\n"
+			"according to them, got burned, and blamed
us,\n"
+			"the good git developers.\n\n"
+			"So everybody has to suffer now, and get used
to\n"
+			"new semantics.\n\n"
+			"Thank you for your time.\n");


Quite accurate... lol.
