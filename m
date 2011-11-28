From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Permissions per git repository
Date: Mon, 28 Nov 2011 09:40:11 -0800 (PST)
Message-ID: <m3ty5okuxu.fsf@localhost.localdomain>
References: <1322487502060-7038724.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: pcm2a <cameron@ree-yees.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 18:40:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV5Bm-0006vg-JC
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 18:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab1K1RkQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Nov 2011 12:40:16 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41390 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873Ab1K1RkQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2011 12:40:16 -0500
Received: by bke11 with SMTP id 11so8816357bke.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=qOA0em4AYKs8YHD1XoYP4DiIccHa7stjuzFkOoZ1XnQ=;
        b=utiFX3j9snd/HKBcdk7Irt4yxjbJjkHBAhpclAOwP8+AXsofySEaZjAms0j4ZSjfMc
         IoxgHDp8zndfxswadOgPj20iPzw++/39+O1y0W4cR1NFDCrLpRUxsDAbhIUFHiogftc8
         UBOWETOj5NwpIcDDHeaLTjQvxwt08GNpi6PMA=
Received: by 10.204.154.77 with SMTP id n13mr47279468bkw.83.1322502012731;
        Mon, 28 Nov 2011 09:40:12 -0800 (PST)
Received: from localhost.localdomain (abwn156.neoplus.adsl.tpnet.pl. [83.8.237.156])
        by mx.google.com with ESMTPS id cc2sm31053513bkb.8.2011.11.28.09.40.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Nov 2011 09:40:11 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pASHdxtD015426;
	Mon, 28 Nov 2011 18:40:10 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pASHdfM1015418;
	Mon, 28 Nov 2011 18:39:41 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1322487502060-7038724.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186023>

pcm2a <cameron@ree-yees.com> writes:

> I have a central git repository running on Windows Server 2008 using =
Apache
> 2.2 + Smart HTTP + SSPI (for authentication).  I can easily limit use=
rs to
> all of the repositories with the 'require' command in apache. This is=
 for
> all repositories and not just certain ones.
>=20
> How can I limit user(s) or group(s) to one repository and a different
> user(s) or group(s) to another repository using git or apache configu=
ration?

If I remember correctly gitolite (a tool to manage access to git
repositories) has support for controlling access via smart HTTP.

--=20
Jakub Nar=EAbski
