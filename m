From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Error using git-remote-hg
Date: Mon, 12 May 2014 14:37:45 -0500
Message-ID: <53712309a8d5e_2ea6e1f2f888@nysa.notmuch>
References: <ACDAFE7C-6615-4E44-AE6C-C12CD001EF4F@lltech.fr>
 <53711AA5.4040001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Charles Brossollet <chbrosso@lltech.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 21:48:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjwDO-0007U2-0N
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 21:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbaELTsm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2014 15:48:42 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:53349 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbaELTsl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 15:48:41 -0400
Received: by mail-ob0-f177.google.com with SMTP id gq1so8395351obb.8
        for <git@vger.kernel.org>; Mon, 12 May 2014 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=vJytFJRWApZTUBP0mAgJDYur8moc0hCqlqv9Ww+5tt0=;
        b=xzqgMU3ns6BKRUrs+3McaNlNDGpMgBO53kAdv+gF4uoBgHgEvmljvCOFjpPxmg3pVl
         GpJzNcoBncDVCfAKl8THbZLc8/iGvsqMQlW6A/NVdVO2F4Tde64NFWf8tD1cpIRlxk/L
         o4l0S4U3f4B+qWlvoFd3uYZ1gtsKs4VRXwjpFWVy5l5keJsDuHBaBvVTjcfZ+pRr3w0A
         /UVTzFMwVfstSrAwwu5vxqPmJ5U2l+zVPgTj0+9FWQLxAKoa0cAsmEW/3vziZVaIMn0l
         tTWVUBdovWxqbWFaNh9ocNi4K+U188bE8eSSnY39iCepFum8r2UFp0m9Q4+KvcfVPhCu
         f5PQ==
X-Received: by 10.182.104.101 with SMTP id gd5mr36592425obb.54.1399924121048;
        Mon, 12 May 2014 12:48:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f9sm21864815obm.2.2014.05.12.12.48.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2014 12:48:40 -0700 (PDT)
In-Reply-To: <53711AA5.4040001@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248726>

Torsten B=C3=B6gershausen wrote:
> > I'm using git 1.9.3 on Mac OS X 10.9.2, with hg 3.0 installed with =
brew.
> >=20
> > It used to work before, on this same repository, since then git and=
 hg were both upgraded.
> In short: The remote helper of Git 1.9.3 is not compatible with hg 3.=
0
> You can eiher downgrade hg, or rebuild Git and cherry-pick this commi=
t:

No need to rebuild Git.

You can also use the latest version:
https://github.com/felipec/git-remote-hg

--=20
=46elipe Contreras