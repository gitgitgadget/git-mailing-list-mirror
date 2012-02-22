From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: gitk: set uicolor SystemButtonFace error on X11 if .gitk created using Win32 tk
Date: Wed, 22 Feb 2012 14:13:23 -0800
Message-ID: <70952A932255A2489522275A628B97C31288FA0B@xmb-sjc-233.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 22 23:13:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0KRJ-0008MK-BH
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 23:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834Ab2BVWN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 17:13:29 -0500
Received: from mtv-iport-3.cisco.com ([173.36.130.14]:8549 "EHLO
	mtv-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575Ab2BVWN2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 17:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=matseitz@cisco.com; l=677; q=dns/txt;
  s=iport; t=1329948808; x=1331158408;
  h=mime-version:content-transfer-encoding:subject:date:
   message-id:from:to;
  bh=u6gLGSDtvirp+onBm+d6vaWBFQJqokssYUvdgDN88OM=;
  b=LL5a6J7IQaxQEK7Fvp3l798BtMXs6CEbs7RlyNsqoQseZEbwbmevN+Fa
   oP2pZmc1QOaQS2t9rgwefXxrFhVLXr57slOG0ZVPCyUK1ZlOhTlYtAnP5
   Aqqnl3D5v/7ed6RwgI48QDeNekX9w///GXkM04myeuBR0VyWugYbMqu8t
   s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EANVnRU+rRDoH/2dsb2JhbABEskyBB4F1AQQSAR0KUQEqBhgHVwEEGxqHaJgOgScBnneCV4osRxECAwECAoRMAYEEBw0CAwYCDQYZgjtjBIhPn3c
X-IronPort-AV: E=Sophos;i="4.73,466,1325462400"; 
   d="scan'208";a="31945778"
Received: from mtv-core-2.cisco.com ([171.68.58.7])
  by mtv-iport-3.cisco.com with ESMTP; 22 Feb 2012 22:13:28 +0000
Received: from xbh-sjc-231.amer.cisco.com (xbh-sjc-231.cisco.com [128.107.191.100])
	by mtv-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id q1MMDR4F001463
	for <git@vger.kernel.org>; Wed, 22 Feb 2012 22:13:27 GMT
Received: from xmb-sjc-233.amer.cisco.com ([128.107.191.88]) by xbh-sjc-231.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 22 Feb 2012 14:13:27 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-CR-Hashedpuzzle: AOr9 AQZY AQ2/ CIVz DSuC D9Ey ErP6 EtEV FxpS GWJn Gb3C G/cS HJsF H+Q9 IP5j JW0q;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{B83B824F-9FED-4073-AB0B-1E9682E4C6FB};bQBhAHQAcwBlAGkAdAB6AEAAYwBpAHMAYwBvAC4AYwBvAG0A;Wed, 22 Feb 2012 22:13:23 GMT;ZwBpAHQAawA6ACAAcwBlAHQAIAB1AGkAYwBvAGwAbwByACAAUwB5AHMAdABlAG0AQgB1AHQAdABvAG4ARgBhAGMAZQAgAGUAcgByAG8AcgAgAG8AbgAgAFgAMQAxACAAaQBmACAALgBnAGkAdABrACAAYwByAGUAYQB0AGUAZAAgAHUAcwBpAG4AZwAgAFcAaQBuADMAMgAgAHQAawA=
X-CR-Puzzleid: {B83B824F-9FED-4073-AB0B-1E9682E4C6FB}
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gitk: set uicolor SystemButtonFace error on X11 if .gitk created using Win32 tk
thread-index: AczxrzFkHFTIirhXSlyFv8fdHXgxDA==
X-OriginalArrivalTime: 22 Feb 2012 22:13:27.0676 (UTC) FILETIME=[33C103C0:01CCF1AF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191298>

Would you please change gitk to not hard-code Win32-specific color
values when creating .gitk on a Win32 windowing system?

Gitk stopped working for me on Cygwin when Cygwin changed from using a
Win32 native version of tk to using the standard X11 version.  The error
was because gitk had previously created a .gitk file using Win32
specific color values:

https://github.com/gitster/git/commit/1924d1bc0dc99cd3460d3551671908cc76
c09d3b

I was able to work around the problem by replacing the Win32 specific
colors in my .gitk file with the default colors gitk uses on other
windowing systems.
 
See also:

http://cygwin.com/ml/cygwin/2012-02/msg00391.html
