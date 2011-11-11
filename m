From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git:  CVS to Git import
Date: Fri, 11 Nov 2011 15:43:47 -0800 (PST)
Message-ID: <m3obwimdi1.fsf@localhost.localdomain>
References: <1321053453892-6987037.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jvsrvcs <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 12 00:43:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RP0lH-0007qg-S4
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 00:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab1KKXnu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Nov 2011 18:43:50 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54237 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888Ab1KKXnt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2011 18:43:49 -0500
Received: by bke11 with SMTP id 11so3742107bke.19
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=5RNbq9DfQowHDh0SHLmzRYjWAZjXVn+RtlnQPnf+5eA=;
        b=xPABV2D19jfKI/ulIQPyWjgBSjxseC19/ztkJryzqBtUOm02vFJhojsh/OgyZWMgUU
         ABh+JNfR+UgIqn3lt5BTUwOFleqlB1SO4KfC4XjLLyM/frEJUbS+S4zfy/QeyOWQi9JZ
         qXNhP/ZqPByv4hxD+djYPcqVnTEKrnOAked8Y=
Received: by 10.205.139.73 with SMTP id iv9mr4825689bkc.30.1321055028322;
        Fri, 11 Nov 2011 15:43:48 -0800 (PST)
Received: from localhost.localdomain (abwk57.neoplus.adsl.tpnet.pl. [83.8.234.57])
        by mx.google.com with ESMTPS id m12sm4056215bkg.14.2011.11.11.15.43.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Nov 2011 15:43:47 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pABNhjtT018511;
	Sat, 12 Nov 2011 00:43:51 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pABNhYV0018507;
	Sat, 12 Nov 2011 00:43:34 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1321053453892-6987037.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185293>

Jvsrvcs <jvsrvcs@gmail.com> writes:

> Git:  CVS to Git import
>=20
> We are moving from CVS to Git and want to know if anyone has had any
> experience there doing this and could share do's  / dont's, best prac=
tices
> when doing the initial import.
>=20
> Also are there any known problems/bugs with the cvs to git import wit=
h
> regards to CVS history?

I think that Eric S Raymond "DVCS Migration Guide"

   http://www.catb.org/esr/dvcs-migration-guide.html

and reposurgeon tool (to clean up conversion artifacts)

   http://www.catb.org/esr/reposurgeon/

might help.

--=20
Jakub Nar=EAbski
