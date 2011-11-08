From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Checkout first version of each file?
Date: Tue, 8 Nov 2011 15:02:43 +0100
Message-ID: <20111108140243.GA4866@kolya>
References: <CABLeVKF5P_sWwNX+OR_FX4+SPCN+SovZ2QuMmGGvJ-EskK7=YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 15:02:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNmG2-00067R-IN
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 15:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711Ab1KHOCa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 09:02:30 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65257 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813Ab1KHOC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 09:02:29 -0500
Received: by faan17 with SMTP id n17so531187faa.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 06:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=znMaEmjr+YM/m0AclGIPruyGqC9aLyn7EGCx86mwZXg=;
        b=jCNJzkNcVa3i3RjmYvIdpZvOrjua7NM9BtDLALLALqg9ZCh3I2YyUDobW4k4orLG/k
         /XYsrtJbyLBWQ35SDP1nrf8uta4z4GLaxp/MxIq4gi3a+HKlZZAYneiBBbcAI9cUh4iM
         ld1xRBffNHwc26P7CwV0vmorSjBaMEcao+fV8=
Received: by 10.223.91.82 with SMTP id l18mr53296152fam.30.1320760948215;
        Tue, 08 Nov 2011 06:02:28 -0800 (PST)
Received: from kolya (h-185-240.a189.priv.bahnhof.se. [85.24.185.240])
        by mx.google.com with ESMTPS id w11sm2271822fad.7.2011.11.08.06.02.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Nov 2011 06:02:26 -0800 (PST)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1RNmGB-0001ML-Qk; Tue, 08 Nov 2011 15:02:43 +0100
Content-Disposition: inline
In-Reply-To: <CABLeVKF5P_sWwNX+OR_FX4+SPCN+SovZ2QuMmGGvJ-EskK7=YQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185086>

On Tue, Nov 08, 2011 at 10:58:05AM -0300, Dario Rodriguez wrote:
> Hello,
>=20
> My "issue" comes with my usage of git at work. I work with lots of
> applications, each of them part of each system. There are lots of
> processes and lots of subsystems, so I never clone the entire repo
> into GIT, since it could be painful and slow. Even if I do so,
> everyone else is using ClearCase, and their changes cannot be include=
d
> into my git repo until they "chickin". Sometimes, I must update
> sources from FTP because the changes are not up to date in
> ClearCase...
>=20
> So, I clone every file that I will need to work into GIT, so i can
> work with these files having a better control (With ClearCase it's a
> foolish "checkout>>lots of changes>>checkin" flow). But sometimes I
> don't know how many files I am going to change until I start coding
> the requisites.
>=20
> In this cases, there is a situation that I don't know how to handle.
> If I need to rollback every change made to every file I cannot just
> checkout the initial commit, cause I've added files after that, and I
> need their initial versions too.
>=20
> So, how can I checkout the first version of each file? (I know that
> GIT tracks contents and not files, but the fact is that I need to kee=
p
> track on files, it's the real thing I work with)
>=20
> pd: Sorry about my Argentinian-English (if it sounds so)
>=20
> Thanks,
> Dario
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Is all files present in your latest commit? Or can there be deleted
files that you also need to recover?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

E-post: iveqy@iveqy.com
Tel. nr.: 0733 60 82 74
