From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 3/7] unpack-trees: factor out dup_entry
Date: Tue, 4 Jun 2013 16:06:08 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1306041605260.1612@ds9.cixit.se>
References: <1369913664-49734-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <1369913664-49734-4-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jun 04 17:06:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjsoZ-0001Dj-2h
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 17:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325Ab3FDPGR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 11:06:17 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:47760 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755952Ab3FDPGO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 11:06:14 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r54F69ID028500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Jun 2013 17:06:09 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r54F68KL028497;
	Tue, 4 Jun 2013 17:06:09 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1369913664-49734-4-git-send-email-rene.scharfe@lsrfire.ath.cx>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Tue, 04 Jun 2013 17:06:09 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226368>

Ren=C3=A9 Scharfe:

> While we're add it,

  "add" =E2=86=92 "at"

--=20
\\// Peter - http://www.softwolves.pp.se/
