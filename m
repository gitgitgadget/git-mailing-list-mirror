From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently
  processed
Date: Mon, 17 Jun 2013 14:54:41 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1306171452340.7683@perkele.intern.softwolves.pp.se>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr> <alpine.DEB.2.00.1306171357440.7683@perkele.intern.softwolves.pp.se> <c878cf98bff28ea8b72fb6d33fd9ca85@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	git@vger.kernel.org, gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?ISO-8859-15?Q?Mathieu_Li=E9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 17 15:54:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoZtR-0001Yd-7z
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 15:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590Ab3FQNyp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 09:54:45 -0400
Received: from mx.getmail.no ([84.210.184.6]:50020 "EHLO galore.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847Ab3FQNyo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jun 2013 09:54:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by galore.getmail.no (Postfix) with ESMTP id 9851A5B813;
	Mon, 17 Jun 2013 15:54:50 +0200 (CEST)
X-Spam-Flag: NO
X-Spam-Score: -2.85
X-Spam-Level: 
X-Spam-Status: No, score=-2.85 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, T_BIG_HEADERS_2K=0.01,
	T_FAKE_REPLY_SURE_A=0.01, T_FAKE_REPLY_SURE_B=0.01,
	T_KHOP_THREADED=-0.01, T_LONG_HEADER_LINE_160=0.01,
	T_LONG_HEADER_LINE_80=0.01, T_UNKNOWN_ORIGIN=0.01] autolearn=ham
Received: from galore.getmail.no ([127.0.0.1])
	by localhost (galore.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id iaQH8shNds4G; Mon, 17 Jun 2013 15:54:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by galore.getmail.no (Postfix) with ESMTP id DC8CA5B824;
	Mon, 17 Jun 2013 15:54:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from galore.getmail.no ([127.0.0.1])
	by localhost (galore.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bYIe6r_Tx2Qk; Mon, 17 Jun 2013 15:54:49 +0200 (CEST)
Received: from perkele (cm-84.215.89.29.getinternet.no [84.215.89.29])
	by galore.getmail.no (Postfix) with ESMTP id A53BB5B821;
	Mon, 17 Jun 2013 15:54:49 +0200 (CEST)
Received: by perkele (Postfix, from userid 501)
	id 725F32FCF3; Mon, 17 Jun 2013 15:54:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by perkele (Postfix) with ESMTP id 6EC192FCF2;
	Mon, 17 Jun 2013 14:54:41 +0100 (CET)
In-Reply-To: <c878cf98bff28ea8b72fb6d33fd9ca85@ensibm.imag.fr>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228071>

Mathieu Li=C3=A9nard--Mayor:

> Actually, at first I dealt with it this way:
>
> status_printf_ln(s, color,
>                 _("Splitting %s while rebasing branch '%s' on '%s'.")=
,
> 		 stopped_sha ? stopped_sha : _("a commit"),
> 		 ....);
>
> Would this be more suitable for translators ?

Not really, the text surrounding "a commit" might need to be inflected=20
differently depending on whether it is a SHA-1 or the "a commit"=20
string. Word order might also be different.

--=20
\\// Peter - http://www.softwolves.pp.se/
