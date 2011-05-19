From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: git over https and http 1.1
Date: Thu, 19 May 2011 18:39:34 +0400
Organization: '
Message-ID: <20110519143934.GB5355@external.screwed.box>
References: <BLU0-SMTP195570CAA61AF8232B0295BC78F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Nir Friedman <nirfri@hotmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 16:40:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN4ON-0006Po-Aj
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 16:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754Ab1ESOjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 10:39:53 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:63246 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850Ab1ESOjw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 10:39:52 -0400
Received: from localhost (spftor3.privacyfoundation.ch [62.220.135.129])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 73ABF5C5D;
	Thu, 19 May 2011 18:15:54 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP195570CAA61AF8232B0295BC78F0@phx.gbl>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L(~u
 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173960>

You'll never silence the voice of the voiceless, Nir!
2011/05/18 15:30:18 +0300 Nir Friedman <nirfri@hotmail.com> => To git@vger.kernel.org :
NF> I am using git with https as the transport protocol.
NF> Response times were around 30 seconds before apache started processing the
NF> backend command.
NF> I added the flags   [BrowserMatch "git"      downgrade-1.0
NF> force-response-1.0] to the apache conf file, and response times were fast.
NF> This seems to mean that the libcurl library is not dealing correctly with
NF> HTTP 1/1 over SSL. Is this the best fix?

It's very unlikely for curl to work bad with https.
Isn't it a DNS-related delay?

NF> If so, maybe appropriate documentation should be added to the git setup
NF> docs.

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
--
http://vereshagin.org
