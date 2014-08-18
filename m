From: "Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com>
Subject: RE: Understanding behavior of git blame -M
Date: Mon, 18 Aug 2014 11:41:43 +0000
Message-ID: <71BF70CE41AEE741896AF3A5450D86F11F28C80E@DEFTHW99EH3MSX.ww902.siemens.net>
References: <71BF70CE41AEE741896AF3A5450D86F11F28C762@DEFTHW99EH3MSX.ww902.siemens.net>
 <xmqq7g291y21.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 13:42:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJLKE-0002K8-MZ
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 13:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbaHRLlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 07:41:55 -0400
Received: from goliath.siemens.de ([192.35.17.28]:56583 "EHLO
	goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaHRLlz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Aug 2014 07:41:55 -0400
Received: from mail2.sbs.de (localhost [127.0.0.1])
	by goliath.siemens.de (8.14.3/8.14.3) with ESMTP id s7IBfju7017509;
	Mon, 18 Aug 2014 13:41:45 +0200
Received: from DEFTHW99ERJMSX.ww902.siemens.net (defthw99erjmsx.ww902.siemens.net [139.22.70.135])
	by mail2.sbs.de (8.14.3/8.14.3) with ESMTP id s7IBfjDU006653
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 18 Aug 2014 13:41:45 +0200
Received: from DENBGAT9ER5MSX.ww902.siemens.net (139.22.70.80) by
 DEFTHW99ERJMSX.ww902.siemens.net (139.22.70.135) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Mon, 18 Aug 2014 13:41:44 +0200
Received: from DEFTHW99EH3MSX.ww902.siemens.net ([169.254.1.177]) by
 DENBGAT9ER5MSX.ww902.siemens.net ([139.22.70.80]) with mapi id
 14.03.0195.001; Mon, 18 Aug 2014 13:41:44 +0200
Thread-Topic: Understanding behavior of git blame -M
Thread-Index: Ac+4jUNF6aAz44SIRIyypexOO2EquAAAPv+AAAdNScYAB+9L8ACDM/JA
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.22.70.16]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255385>

Seems like not detecting single line movements is per design and just the documentation is not precise about this. Could such an enhancement be considered as a feature request? We're using git (blame) as a low level tool for building further functionality on top of it. Maintaining a custom version of git is a big step that we would like to avoid.

Regards
Konstantin
