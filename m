From: "Srb, Michal" <michal.srb11@imperial.ac.uk>
Subject: RE: FW: Git log --graph doesn't output color when redirected
Date: Thu, 13 Dec 2012 15:34:29 +0000
Message-ID: <72BB37CB88C48F4B925365539F1EE46C1826168A@icexch-m3.ic.ac.uk>
References: <72BB37CB88C48F4B925365539F1EE46C182613A9@icexch-m3.ic.ac.uk>
 <72BB37CB88C48F4B925365539F1EE46C18261403@icexch-m3.ic.ac.uk>,<20121213131329.GA5042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 13 16:35:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjAoy-0001gi-37
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 16:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab2LMPfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 10:35:17 -0500
Received: from smtp2.cc.ic.ac.uk ([155.198.5.156]:58769 "EHLO
	smtp2.cc.ic.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab2LMPfQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2012 10:35:16 -0500
Received: from icexch-h1.ic.ac.uk ([2001:630:12:610::111])
	by smtp2.cc.ic.ac.uk with esmtp (Exim 4.77)
	(envelope-from <michal.srb11@imperial.ac.uk>)
	id 1TjAoc-0006HP-Ra; Thu, 13 Dec 2012 15:35:15 +0000
Received: from icexch-m3.ic.ac.uk ([fe80::bd02:fc07:49f4:cded]) by
 icexch-h1.ic.ac.uk ([fe80::89d7:b737:8af9:634f%10]) with mapi id
 14.02.0309.002; Thu, 13 Dec 2012 15:34:29 +0000
Thread-Topic: FW: Git log --graph doesn't output color when redirected
Thread-Index: Ac3Yjq+meElrbMKnQcaf7CGn5O9CJQAAFB29ACkpGYAABNEB3A==
In-Reply-To: <20121213131329.GA5042@sigill.intra.peff.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.29.152.206]
X-IC-MsgID: 1TjAoc-0006HP-Ra
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211455>

From: Jeff King [peff@peff.net]
Sent: Thursday, December 13, 2012 1:13 PM

>> Is there a setting somewhere in config to change this?

> Yes. If you use "--color" on the command line, that means
> "unconditionally use color". If you set color.ui (or any other
> color config option) to "always", then you will always get color (and
> you can disable it for a particular run with "--no-color"). Setting a color
> config option to "true" is the same as "auto", which gets you 
> the auto mode.
 
Setting color in gitconfig didn't work for me on msys, but --color 
works like magic, thanks!