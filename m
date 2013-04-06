From: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
Subject: typo in Documentation/git-rebase.txt
Date: Sat, 06 Apr 2013 15:10:11 +0200
Message-ID: <51601EB3.20301@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:43:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWVH-0001b9-MA
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422917Ab3DFNbU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Apr 2013 09:31:20 -0400
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:60641 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422912Ab3DFNbT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 09:31:19 -0400
X-Greylist: delayed 1261 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Apr 2013 09:31:19 EDT
Received: from smtp.aegee.org (aegeepc1.aegee.uni-karlsruhe.de [129.13.131.81])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1UOSsm-0007MG-On; Sat, 06 Apr 2013 15:10:12 +0200
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.8.1 smtp.aegee.org r36DAFgU010891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1365253817; i=dkim+MSA-ssl@aegee.org;
	bh=v7vVKl9i1wMlaRfHkLMEo/urUdNjqXL2EoA0qfSxOuQ=;
	h=Date:From:To:Subject;
	b=VTSjWTj83emubl50AH4AsR8D+xYwwiESSv+84efBxpR+4gIqODyD0rQWRt12lDa/u
	 2XYyOc3jt+o4ISfd1iudp8Uvp2iRJg4YfXGvbjRm+/b9E7r7oCvRooCoa0IAfVDFF5
	 nE4X2b2JgGEWeerdbK3AFziqG1Ft8sk7pHAKlX/y8sgW54BcT98lW4H10zmCgViRxz
	 hF8wO9GQ7sARaSPmLOAJnnZ6BcFuoTCU8cwe4TEmaHlGEO6aPtM4h22pVu46LtR6hX
	 0zKoXw2W0GwSlItyc4UQXu0ZDB+g/Eo6XNh9HQyb5GMmH+T0TD8p5uwyeq9P/bLwIp
	 nWUWAL703LQUaZHWZrjGXOHheGoipYmapPeEkQrkFL6zfPYWZfk9/1dt73teti30YV
	 nNW2VrDYvuwuPsi79NDk9ioGchx6OHw5SAmAiwC+cRKa/gGBin5+IKqO5OUHOlHkdX
	 p8fJKWKP5/GM74at4ZzjqSkcqvqI4VjyrdCFktp4gWmyLFiG65kOEq3ICMRHb9F+ut
	 8zBMo7iFcY0MG0qdgv2qKyhD5/+ncpRtMumNbg95WndViIrK/XYPo10X6Zm8WBvanE
	 Q5XkYBrvpQDLkamkRi8kCJUfuAcdMu+UHWvEAgcZ/QouKrieG1mviDjcoi/fZOiOnW
	 5N2m4yAiyubql3NQ 
Received: from [192.168.0.6] (port-212-202-110-243.static.qsc.de [212.202.110.243])
	(authenticated bits=0)
	by smtp.aegee.org (8.14.6/8.14.5) with ESMTP id r36DAFgU010891
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 6 Apr 2013 13:10:17 GMT
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-Virus-Scanned: clamav-milter 0.97.7 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220226>

Hello,

please change in Documentation/git-rebase.txt, as of=20
v1.8.2-470-g21ccebe, for --ignore-whitespace and --whitespace, line 326

from
         These flag are passed to the 'git apply' program
to (add an 's')
         These flags are passed to the 'git apply' program

and in the same file, under --autosqash, --no-autosquash, last paragrap=
h

	If the '--autosquash' option is enabled by default using the
	configuration variable `rebase.autosquash`, this option can be
	used to override and disable this setting.

please delete "by default".  With "by default" comes the question, what=
=20
is the default value, if rebase.autosquash is not set.  I suggest as=20
replacement text
	If the '--autosquash' option is enabled using the configuration
         variable 'rebase.autosquash', '--no-autosqash' can be used to
         override and disable this setting.

Even "and disable" is redundant and can be skipped.

=D0=A1=D1=8A=D1=81 =D0=B7=D0=B4=D1=80=D0=B0=D0=B2=D0=B5
   =D0=94=D0=B8=D0=BB=D1=8F=D0=BD
