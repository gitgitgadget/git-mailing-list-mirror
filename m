From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] i18n: mark all progress lines for translation
Date: Sat, 22 Feb 2014 22:45:55 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1402222244450.1524@ds9.cixit.se>
References: <1392987018-16598-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 22 22:46:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHKOe-0006LH-4W
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 22:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbaBVVqB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Feb 2014 16:46:01 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:43849 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751550AbaBVVqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 16:46:01 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s1MLjtRD001644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 22 Feb 2014 22:45:55 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s1MLjtoN001641;
	Sat, 22 Feb 2014 22:45:55 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1392987018-16598-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Sat, 22 Feb 2014 22:45:55 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242532>

Nguy?n Th=C3=A1i Ng?c Duy:

> I can't think of any case that progress lines are for machine. It=20
> started because of the only local untranslated line in "git clone".=20
> But I think we should do all at once.

Indeed, a good move. Anything that is to be displayed to the end user=20
should be subject to localization; if it is part of a protocol, then=20
it needs to be translated on the receiving end.

--=20
\\// Peter - http://www.softwolves.pp.se/
