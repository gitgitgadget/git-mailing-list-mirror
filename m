From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Question about .git/objects/info/alternates
Date: Mon, 22 Mar 2010 21:42:23 -0500
Message-ID: <20100323024223.GA12257@progeny.tock>
References: <a038bef51003221026i379ee16ej6e0e6defcf0048dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 03:42:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntu4f-0007Mx-6P
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 03:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012Ab0CWCm2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 22:42:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40267 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab0CWCm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 22:42:27 -0400
Received: by gwaa18 with SMTP id a18so1281840gwa.19
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 19:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=gKe2KGFvx2ytzIo5niEpzU6SGkduDDYqJ5gtZMg5qMU=;
        b=YPvoR2UpnY6CSkfkGcWV7VtX4TlZJ6XttG47Y04ej3YTCoxjSBHLVcoSG2cZFlUeoy
         6GdboLfgxjKLDd3UvH7iy/yByo2mud2/2cyttMlayBx6Pzpv8UaGfWIKV+LMdmFxos6D
         MlH6qFJXqCfm/sNOI2Mrv1eBlmepQjy6qOSM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=axoHz6K+1tGtW0DMMx/81qG8RFsXy5jSh4CXzuobnEN7eW5pxPGv3zsH+YA1mNwv7B
         jZ8nCpKfdS3ECMGtCJUfhwX72Zb4sGhNDUl8gO+upbybdt4aWXj9jKd/0LU9EuqZ90xr
         IywltJtoUpxAuYQbJcGERVztJ8BRZi1M/t1Gc=
Received: by 10.100.24.15 with SMTP id 15mr7632563anx.27.1269312146536;
        Mon, 22 Mar 2010 19:42:26 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm5482760iwn.10.2010.03.22.19.42.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 19:42:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a038bef51003221026i379ee16ej6e0e6defcf0048dd@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142985>

Chris Packham wrote:

> I would like to have base somehow find the objects it doesn't have in
> its object store and either download them or just copy them from the
> object store of projecta.
[...]
> From reading [2] I think 'rm
> .git/objects/info/alternates && git repack -a' might do the trick but
> I'm not sure.

Almost.  Try =E2=80=98git repack -a && rm .git/objects/info/alternates=E2=
=80=99 instead. :)

(Please back up the repository or try with something less important
first, since I am not sure.)

Hope that helps,
Jonathan

> [2] http://stackoverflow.com/questions/2248228/how-to-detach-alternat=
es-after-git-clone-reference
