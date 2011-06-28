From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: refactoring in GIT
Date: Tue, 28 Jun 2011 19:09:26 +0200
Message-ID: <20110628170926.GB910@paksenarrion.iveqy.com>
References: <loom.20110628T151105-908@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: eugene <eugene@oggtrading.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 19:31:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbc8T-00065t-EN
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 19:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759486Ab1F1RAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jun 2011 13:00:42 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35834 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759510Ab1F1Q7H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 12:59:07 -0400
Received: by bwd5 with SMTP id 5so345686bwd.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nAHXO5+oPan3wWdafy2/m8kPTuudV7mMkSlZK7Km7mA=;
        b=G+jmSSlvmGPmvs6aOSXNK+G5k3vR5JpMT3M9C0+/HwMBpv/3XssbZFyKO/nmX4aSBl
         G0PpZlzXwgJ9N1FW/lsQn9x/mY1so2BO4+pdM+dO8yK2MGPO1/KdmQe51wZbcOKWJXyz
         qNkAjxCk5V8BOcDTPtJ+hodKeewtQpo25qayc=
Received: by 10.204.8.89 with SMTP id g25mr124412bkg.10.1309280100144;
        Tue, 28 Jun 2011 09:55:00 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id o3sm372806bka.0.2011.06.28.09.54.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 09:54:59 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Qbbmw-0000Fh-7O; Tue, 28 Jun 2011 19:09:26 +0200
Content-Disposition: inline
In-Reply-To: <loom.20110628T151105-908@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176409>

On Tue, Jun 28, 2011 at 01:19:23PM +0000, eugene wrote:
> Hi,
>  I'm new to GIT and have two questions about code refactoring.=20
>=20
> #1. I want to refactor class A into few classes B,C,D. How should I c=
heck them=20
> in and mark class A inactive so that development on A stops? Note, I =
do need A=20
> stay in repository for backward compt. with prior code releases.
>=20
> #2. [related question] What if another developer already had A in his=
 local=20
> repository, made changes and wants to commit after me. I just made A =
obsolete.=20
> Does he have drop his changes and take B,C,D from me and/or merge?
>=20
> Sorry if this question was already answered, pls point me.
>=20
> Thanks,
> Eugene
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

The only way I can imagine that you do that is by using submodules
together with a repository permission management tool lite gitolite. Or
Maybe just using gitolite with different branches. If I recall correctl=
y
gitolite has per branch rw permissions.

However, I doubt that this issue should be solved technically.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
