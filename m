From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v9 03/19] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 10 May 2016 13:19:28 -0400
Organization: Twitter
Message-ID: <1462900768.24478.55.camel@twopensource.com>
References: <20160510101315.32403-1-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	pclouds@gmail.com
To: SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue May 10 19:20:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0BKh-00083x-B1
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 19:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbcEJRUY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 13:20:24 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34629 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbcEJRTb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 13:19:31 -0400
Received: by mail-qk0-f172.google.com with SMTP id r184so10777447qkc.1
        for <git@vger.kernel.org>; Tue, 10 May 2016 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=bV3i+W2moog9N2x+tNlDof8NSSsGgzscZZyUwb2P2sw=;
        b=P0rHXxfI4IB/SXXZ6+4wBkzaLslHVcu0UsJ5maPnp/AGuUXGKjVKPvA1A5n9nLyXX2
         4ZZGlBcR46eWtXO2Tv/IrzIpq+9Rw/G+odwyF1Vdh8CcY3d0AUTVmOBl1993jpkuQ9OP
         +Feisy9dLQcsF8Z4sZRk0leV9Vz3RhEpApSgtyw37QXZKcgPFQBP3MyukuK05Ytfx7Rl
         /nxq6yuYvGl6fvzKz2EtifDZTLp2VtFE56JDI7ZvFXXO0JzKBvbU5UuNNHhdMMcc+UIF
         EgEV0Kszj9Nbd8EaST5rSxAeWemt4nu4oIQqFxSOaS3HX0bhQeQ+uQtBlrmiW89PxBAR
         d4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=bV3i+W2moog9N2x+tNlDof8NSSsGgzscZZyUwb2P2sw=;
        b=cduMrMVry9lLVFXj1sjKSP+FeJnKVI5cvmNQR+RRAdJtpw7OERWPFuIB76pkKuWclX
         MyVXBPazwX4u2ihUSFm8lQDs8+4pbyqGWPGv5rJ/RKawZ8cpnV5jszyifEjAUa928wz2
         zkO9tgswzGt6ppniUFKbt8AGN0gWPiPIEJnSCUG/9ugemceQDM00V669m4B0ugOXPhFp
         ZbZP84kXm0hOMP1DMNgBQaukI18LxbsnmX4IUUJQ5+ih3nddG3IdrmrLWZ7kVAB+yHgw
         2W01LE1ehLvqZv3EUJGULQY3LARqnx9htNtCgb4F3vHrxQ2wrXprVgJ4eHD4W2Jw7G6w
         dZcg==
X-Gm-Message-State: AOPr4FUh32qetEd6nOyRrYpFa5BMk9eVNo04xpZcAqAJmmnJQbwNvvIxsrjRUa4/ZabErA==
X-Received: by 10.55.16.71 with SMTP id a68mr20803139qkh.118.1462900770670;
        Tue, 10 May 2016 10:19:30 -0700 (PDT)
Received: from ubuntu (ool-4577e90f.dyn.optonline.net. [69.119.233.15])
        by smtp.gmail.com with ESMTPSA id e63sm1365796qga.17.2016.05.10.10.19.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 May 2016 10:19:29 -0700 (PDT)
In-Reply-To: <20160510101315.32403-1-szeder@ira.uka.de>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294157>

Will do, thanks.

On Tue, 2016-05-10 at 12:13 +0200, SZEDER G=C3=A1bor wrote:
> This patch adds a new plumbing command, which then will show up in
> completion after 'git <TAB>'.  Could you please squash in this
> oneliner to exclude index-helper from porcelain commands in the
> completion script?
>=20
>=20
> ---
>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index 34024754d929..9264ab919a6a 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -684,6 +684,7 @@ __git_list_porcelain_commands ()
>  		for-each-ref)     : plumbing;;
>  		hash-object)      : plumbing;;
>  		http-*)           : transport;;
> +		index-helper)     : plumbing;;
>  		index-pack)       : plumbing;;
>  		init-db)          : deprecated;;
>  		local-fetch)      : plumbing;;
