From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Announcing Gitspread - Spread Git commits to several servers with a single push
Date: Mon, 25 Apr 2011 03:35:02 -0700 (PDT)
Message-ID: <m3k4eiwrfe.fsf@localhost.localdomain>
References: <BANLkTikuCfnSuY2r+YzWu1PegP3baniOjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?iso-8859-15?q?=D8yvind_A._Holm?=" <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 12:35:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEJ8T-00050H-H8
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 12:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758293Ab1DYKfK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2011 06:35:10 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56730 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758284Ab1DYKfF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2011 06:35:05 -0400
Received: by bwz15 with SMTP id 15so1528117bwz.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 03:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=WXvZsyGvCjZHHPHVoVhuOimlR+krhdPzQUdYb+qlEWQ=;
        b=wRgcZ4q6FJE49/mMdv0NfataKHpe46uf5rCOIJkJy68vzrCsbLn0VcfbazsENjNBLR
         gy56JKmIcETY+zGVhOGtYTtgYkhYkCBLn0s7c0ww4VUCKhunoLIZ0f4LiO5hk7o2gmnO
         0IrWzSKemU/Z7Td0s2ksOlNMLMWZ7jeacFq8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=fIQIhnF0+LrMm6HD4jnzUlSf/j7YdGT3pFikXUgNhDGzkdukAyUZNzjyYv2Gjq/VIT
         sqpDs5nwViG4FonDNBq2ati/g7ta2eFRThiIZZmDamiPh5tJnIOxUi7uHF9Mt16aK5Qq
         1ZgMU82f8GQDVT3F+KY8mvMGV2+7nj2+UCbSE=
Received: by 10.204.74.7 with SMTP id s7mr2947295bkj.57.1303727703602;
        Mon, 25 Apr 2011 03:35:03 -0700 (PDT)
Received: from localhost.localdomain (abwn49.neoplus.adsl.tpnet.pl [83.8.237.49])
        by mx.google.com with ESMTPS id l1sm3191879bkl.13.2011.04.25.03.35.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Apr 2011 03:35:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3PAYOCn019758;
	Mon, 25 Apr 2011 12:34:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3PAYDW8019731;
	Mon, 25 Apr 2011 12:34:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTikuCfnSuY2r+YzWu1PegP3baniOjA@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172021>

=C3=98yvind A. Holm <sunny@sunbase.org> writes:

> A project is often stored on several hosting services like Gitorious,
> GitHub, repo.or.cz or similar for backup purposes. Ideally, all these
> repositories should be updated at the same time when pushing. If you=E2=
=80=99re
> using a slow Internet connection, like a mobile connection from a
> laptop, this process tends to be rather slow because the commits have=
 to
> be pushed several times over a slow connection. Gitspread aims to sol=
ve
> this by pushing the commits once to a server with a fast connection, =
and
> pushing the commits from there to all the defined remotes.
[...]

Could you please add short info about this tool to

  https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

page on Git Wiki?

Thanks in advance
--=20
Jakub Narebski
Poland
ShadeHawk on #git
