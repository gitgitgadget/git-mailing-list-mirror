From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Documentation for fetch, url, branches, tags keywords in git
 config?
Date: Tue, 29 Oct 2013 20:37:16 +0100
Message-ID: <20131029193716.GA9691@paksenarrion.iveqy.com>
References: <0C723FEB5B4E5642B25B451BA57E273041FD3F9C@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jim Garrison <jim.garrison@nwea.org>
X-From: git-owner@vger.kernel.org Tue Oct 29 20:39:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbF8i-00029w-85
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 20:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab3J2Tjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Oct 2013 15:39:40 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:58311 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab3J2Tjj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 15:39:39 -0400
Received: by mail-la0-f50.google.com with SMTP id ec20so282700lab.23
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QzMtDYRXRhC5YuBMXcBIVJzxrlXoPtNA21k96A6jmJc=;
        b=kt9Onz5VG9iyOU80XcMy1rHW/zHZVZKV24Rya2AVCAFtMEgKSizjYRz78hDFc6OLnU
         GxeCRVA3jlcDchChWh/+HXoYYoitKdNU0PzOk3WQRRJVJDqhbejlGQuVR0XlkA67Za7I
         vtOWj60XElcbSUyg/w8OLFDmn+KThTddzHN0o5d4EMTtP/BWeLKIR3yw9szNP1BTyP/U
         pBb7ZRSTY0b/452G/h/7/1yO7XXA7kuaygnkAbDjh50UUkeHtojP1Lm7fNI3hPvt7jGm
         a2IrLTCku2FWVkKcUasC35IRaR6gsHQ8knAuj28j/ggFZCdyCkVf9fIuUI/702o8Op2n
         UqcQ==
X-Received: by 10.112.52.225 with SMTP id w1mr991937lbo.31.1383075578152;
        Tue, 29 Oct 2013 12:39:38 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id yr8sm24377176lab.4.2013.10.29.12.39.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 29 Oct 2013 12:39:37 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1VbF6K-0002XG-MA; Tue, 29 Oct 2013 20:37:16 +0100
Content-Disposition: inline
In-Reply-To: <0C723FEB5B4E5642B25B451BA57E273041FD3F9C@S1P5DAG3C.EXCHPROD.USA.NET>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236943>

On Tue, Oct 29, 2013 at 07:23:20PM +0000, Jim Garrison wrote:
> A typical config
>=20
> [svn-remote "svn"]
>         noMetadata =3D 1
>         url =3D http://repository.url/svn
>         fetch =3D trunk/etl_app:refs/remotes/etl_app/trunk
>         branches =3D branches/etl_app/*:refs/remotes/branches/*
>         tags =3D tags/etl_app/*:refs/remotes/tags/*
>=20
>=20
> However, the manpage for git-config(1) does not include anything exli=
cit on "url", "fetch", "branches", 'tags", and the meaning of the synta=
x following the colon.=20
>=20
> Where can I find this info?

Is the info in here what you're looking for?
http://jk.gs/git-svn.html

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
