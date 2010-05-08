From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI script
Date: Sun, 9 May 2010 00:41:06 +0200
Message-ID: <201005090041.11864.jnareb@gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	Peter Vereshagin <peter@vereshagin.org>,
	John Goerzen <jgoerzen@complete.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 09 00:41:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAsia-0007Fs-Vt
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 00:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab0EHWlW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 18:41:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34581 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420Ab0EHWlV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 18:41:21 -0400
Received: by fxm10 with SMTP id 10so1523052fxm.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xPJrHo5nGA3qPhWOVJkirspTeMIU8JHpKhOD+Z0JGVo=;
        b=eg7NSL+mKxjHmn3/h11EemHYEWcykcgrQudNKPQ9BlnRjAz50T+r5HhvP2zGZeIoeG
         7Gxex+kIV8SeNKLUFYF/oZj0iMKHh2/leicyn03dpe9fLEeBmSEmR7t/2n9Rm5GjT+FW
         RzAKQK0QppRTANmO/GJNarJlfI1okr1REPp5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wVSqwVBmskvy9GD3iLyIYsoLOfGYIyC7twylCYyLWuxXEY/NRqFphAb1XtZp99BOSs
         nACAV3K1bGLnpdPaZqifrQ20P0UOUO/wztrx579Fa2GVk3CA0bdO53mJxOxk5JadwT+k
         QRs9NgoGY1d72+laBiOWkgt7nU18tjVxoTc34=
Received: by 10.103.81.22 with SMTP id i22mr1030307mul.128.1273358479282;
        Sat, 08 May 2010 15:41:19 -0700 (PDT)
Received: from [192.168.1.13] (abvu105.neoplus.adsl.tpnet.pl [83.8.218.105])
        by mx.google.com with ESMTPS id u26sm14036469mug.25.2010.05.08.15.41.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 15:41:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1273236845-6523-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146683>

On Fri, 7 May 2010, Jakub Narebski wrote:

> The alternate solution would be to add gitweb.fcgi wrapper, like e.g.=
:
> in the following patch by Eric Wong
>=20
> =A0 "[PATCH 1/2] gitweb: add a simple wrapper for FCGI support"
> =A0 http://thread.gmane.org/gmane.comp.version-control.git/35920/focu=
s=3D35921
>=20
> which was part of the "[0/2 PATCH] FastCGI and nginx support for gitw=
eb"
> series. =A0(Note that the patch does 'do $gitweb_cgi;' without checki=
ng for
> errors, see the bottom of `perldoc -f do` documentation on how it sho=
uld
> be done).

I think a better solution here would be to use CGI::Compile instead
of 'do $gitweb_cgi;'.

--=20
Jakub Narebski
Poland
