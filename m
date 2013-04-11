From: =?ISO-8859-1?Q?Jo=E3o_Joyce?= <joao.joyce@netcabo.pt>
Subject: git send-pack: protocol error: bad band #50
Date: Thu, 11 Apr 2013 07:49:44 +0100
Message-ID: <51665D08.3030307@netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 09:00:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQBUm-0008Mm-SU
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 09:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab3DKHAZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Apr 2013 03:00:25 -0400
Received: from mx.netcabo.pt ([212.113.174.24]:65136 "EHLO mx.netcabo.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016Ab3DKHAY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 03:00:24 -0400
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2013 03:00:24 EDT
X-Cloudmark-SP-Filtered: true
X-Cloudmark-SP-Result: v=1.1 cv=1LO/iPE5NBXhyVdUxN98Xz52Jo9BJjb+qr8ZetvN7rk= c=1 sm=2
 a=-TtDL2fbfKMA:10 a=b3vqPem2Q34A:10 a=8nJEP1OIZ-IA:10 a=uytceFsMAAAA:8
 a=7cBjgA-ODzMAPWXEEmgA:9 a=wPNLvfGTeEIA:10 a=H777XK5ZPtYA:10
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvgCAK5ZZlFSmhjH/2dsb2JhbAANQ8R+BASBGINMAQVAPRYYAwIBAgFYBgIBAYd9AatViTIUiiCPM4MrA6sa
Received: from bl5-24-199.dsl.telepac.pt (HELO [192.168.1.67]) ([82.154.24.199])
  by neti05smtpa.hdi.tvcabo with ESMTP/TLS/DHE-RSA-CAMELLIA256-SHA; 11 Apr 2013 07:50:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220829>

Hello,

I am not sure this is the right place to ask this. If it isn't I would=20
be grateful if you could help me find the best place to do it.

I am trying to push some files to a server with git push. I have=20
configured the server to push the files:
     git remote set-url test ssh://user@location.com:2200/fullpath/

but I am getting the following error:
     git send-pack: protocol error: bad band #50
     fatal: The remote end hung up unexpectedly

It seems that something is failing on the remote side but I can't find=20
any reference to this protocol error.

Does anyone know how to solve this error? Or which logs should I search=
=20
to better understand the problem?

Thank you very much,
Jo=E3o Joyce
