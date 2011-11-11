From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: feature request: git annotate -w like git blame -w
Date: Fri, 11 Nov 2011 05:57:03 -0800 (PST)
Message-ID: <m3sjlun4o9.fsf@localhost.localdomain>
References: <4EBD1CF4.7040002@ipax.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Raoul Bhatia [IPAX]" <r.bhatia@ipax.at>
X-From: git-owner@vger.kernel.org Fri Nov 11 14:57:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROrbV-00052A-J3
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 14:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831Ab1KKN5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Nov 2011 08:57:08 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42668 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab1KKN5G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2011 08:57:06 -0500
Received: by fagn18 with SMTP id n18so1734341fag.19
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 05:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=Ge8HaMXyGp4p8iZdh7yya5D8fCK8eb3FqfVG/1pFtuo=;
        b=PndKSkeTqtXqklqNEzHjxI/JAgn3SIrLFF4s8Umu/1f49F5edsQ0EfejphVfz30XND
         eBlTFEBb5/rOTSXT0XeWclr8UEFhYOwre5Nfx0P3eQvvZT02PnXpiioeed05SQod88Op
         jwgbczX2zzND44Dh91WUp0ly5UHJsuvzo9GKs=
Received: by 10.204.146.65 with SMTP id g1mr8300288bkv.63.1321019824892;
        Fri, 11 Nov 2011 05:57:04 -0800 (PST)
Received: from localhost.localdomain (abvw113.neoplus.adsl.tpnet.pl. [83.8.220.113])
        by mx.google.com with ESMTPS id e8sm10912811bkd.7.2011.11.11.05.57.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Nov 2011 05:57:03 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pABDut3i011533;
	Fri, 11 Nov 2011 14:57:05 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pABDud49011523;
	Fri, 11 Nov 2011 14:56:39 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4EBD1CF4.7040002@ipax.at>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185268>

"Raoul Bhatia [IPAX]" <r.bhatia@ipax.at> writes:

> is it possible to add a "git annotate -w" option like git blame has?

Why not use "git blame -c -w"?  `-c' turns on annotate-compatibile
output.

=46rom git-annotate(1) manpage:

   The only difference between this command and git-blame(1) is that th=
ey  use
   slightly  different  output formats, and this command exists only fo=
r back-
   ward compatibility to support existing scripts, and provide a more f=
amiliar
   command name for people coming from other SCM systems.
=20
> ps. please reply to me in cc as i'm not subscribed to this list.

This is usual behavior on this list.

--=20
Jakub Nar=EAbski
