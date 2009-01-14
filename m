From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] Noted that vi is the final choice of editor in git
	help commit
Date: Wed, 14 Jan 2009 10:55:12 +0100
Message-ID: <20090114095512.GA29927@chistera.yi.org>
References: <1231886016-31675-1-git-send-email-cfratrik@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Craig Fratrik <cfratrik@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 11:30:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN30w-0003qC-Tm
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 11:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbZANK27 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 05:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754207AbZANK27
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 05:28:59 -0500
Received: from tarrio.org ([70.85.129.80]:34066 "EHLO maestro.tarrio.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbZANK26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 05:28:58 -0500
X-Greylist: delayed 2023 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jan 2009 05:28:58 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by maestro.tarrio.org (Postfix) with ESMTP id F2C08DD604;
	Wed, 14 Jan 2009 10:55:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at maestro.tarrio.org
Received: from maestro.tarrio.org ([127.0.0.1])
	by localhost (maestro.tarrio.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CB1y2AJ6YLXu; Wed, 14 Jan 2009 10:55:13 +0100 (CET)
Received: from chistera.yi.org (localhost.localdomain [127.0.0.1])
	by maestro.tarrio.org (Postfix) with ESMTP id E253FDD603;
	Wed, 14 Jan 2009 10:55:12 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LN2Su-0007qo-8m; Wed, 14 Jan 2009 10:55:12 +0100
Content-Disposition: inline
In-Reply-To: <1231886016-31675-1-git-send-email-cfratrik@gmail.com>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105611>

* Craig Fratrik [Tue, 13 Jan 2009 14:33:36 -0800]:

>  The editor used to edit the commit log message will be chosen from t=
he
>  GIT_EDITOR environment variable, the core.editor configuration varia=
ble, the
> -VISUAL environment variable, or the EDITOR environment variable (in =
that
> -order).
> +VISUAL environment variable, the EDITOR environment variable, or fin=
ally 'vi'
> +(in that order).

May I suggest:

   The editor used to edit the commit log message will be chosen from t=
he
   GIT_EDITOR environment variable, the core.editor configuration varia=
ble, the
   VISUAL environment variable, or the EDITOR environment variable (in =
that
  -order).
  +order). If none of those are set, "vi" will be used.

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
A lie can go round the world before the truth has got its boots on.
                -- Terry Pratchett
