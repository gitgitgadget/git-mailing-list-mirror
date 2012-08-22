From: Maaartin-1 <grajcar1@seznam.cz>
Subject: git-log combining different detail levels
Date: Wed, 22 Aug 2012 21:25:06 +0200
Message-ID: <50353212.7060109@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Gm8-00088Y-Bs
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 21:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634Ab2HVTjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 15:39:31 -0400
Received: from smtp1.seznam.cz ([77.75.72.43]:57442 "EHLO smtp1.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992Ab2HVTja (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 15:39:30 -0400
X-Greylist: delayed 856 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2012 15:39:29 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=beta; d=seznam.cz;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding:X-Smtpd:X-Seznam-User:X-Session:X-Country:X-Session-Info;
	b=n0MWpwXKZWczMjMZM6fcD5IsAv8VHDYJgXgkOo9Kcxg01Vy1qWLwZjE46Z0l6xfmb
	ty2pn13JFN6DrTCceMYcx02tYDkTSvKofet8KqKYNgGKZxuHETnB4CdvHwOByIE3pzp
	JCtJUmc9Mv5Qe9rJ9K0dW5/sE+l2YYow1Pd+8Yc=
Received: from [10.0.3.200] (188-120-197-152.luckynet.cz [188.120.197.152])
	by email-relay2.go.seznam.cz (Seznam SMTPD UNKNOWN@exported) with ESMTP;
	Wed, 22 Aug 2012 21:25:07 +0200 (CEST)  
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
X-Smtpd: UNKNOWN@exported
X-Seznam-User: grajcar1@seznam.cz
X-Session: 10
X-Country: CZ
X-Session-Info: (sid='3d1900000009', ip='188.120.197.152', helo='[10.0.3.200]', login='grajcar1@seznam.cz', from='grajcar1@seznam.cz', country='CZ', duration='00:00:01.107')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204086>

Quite often I need to see some changes in more detail and others only briefly, so I get some idea about the context. For example I'd like something like merging the outputs of

git log -p -S Bandersnatch
and
git log --name-status --oneline

together, so I know better what happened.

A simpler (and maybe more important) example is merging

git log -p some/dir
and
git log --name-status

so I could see all the changes, and the chosen ones with all details.

Is this somehow possible?

Regards, Maaartin.
