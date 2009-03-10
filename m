From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] contrib/difftool: use a separate config namespace for
	difftool commands
Date: Tue, 10 Mar 2009 00:01:24 -0700
Message-ID: <20090310070122.GB4523@gmail.com>
References: <1236589956-13486-1-git-send-email-davvid@gmail.com> <76718490903090852se7fc756m818f5d8ba49278b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 08:02:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgvyj-0002ND-Jq
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 08:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbZCJHAt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 03:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbZCJHAt
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 03:00:49 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:56701 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbZCJHAs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 03:00:48 -0400
Received: by wa-out-1112.google.com with SMTP id v33so1201241wah.21
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 00:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=x0A6gdNPE4vcUVNOFfhhN2MvsNo9WshfvGBEpsLhZ8I=;
        b=fZdVgVv0VhXzK++9RomYyAlOWimUz2IFHvWainbCiEqGRlgg/buONLojzO/ONm/c62
         iXLgY5pKALDNF89LqfEMsebqcLuzSAOk+60LELjxuUK5mOTW88p58372iRxnAy7kzLa9
         vBy34Ed3M2qcS8wTkssCuzn431k47g8ymW9XU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=w9najvODvfXcDG7WqvcVCzMWVMVgUSRKPTNgxJa2DpiTOt49l+RRmXiCgB7MKnXLPK
         boGKF6iMgWAVhaQEbZMrxwezuGm7fUk8UcFVBDDLRHm9FDW7TxXhgtOIdw8OqjY7Ngcn
         7eZjxX0FS4BVMtiYnqXLlJ6sRkYP5IHu0dsGg=
Received: by 10.114.205.14 with SMTP id c14mr4056809wag.226.1236668445956;
        Tue, 10 Mar 2009 00:00:45 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n6sm3587508wag.67.2009.03.10.00.00.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Mar 2009 00:00:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <76718490903090852se7fc756m818f5d8ba49278b5@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112784>

On  0, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Mon, Mar 9, 2009 at 5:12 AM, David Aguilar <davvid@gmail.com> wrot=
e:
> > =A0contrib/difftool/git-difftool =A0 =A0 =A0 =A0| =A0 =A06 +++---
>=20
> Aside, (for Junio I guess...), what's the reason this command is in
> contrib, and by what criteria might it graduate to being installed
> with the rest of the git commands?
>=20
> j.

My thoughts (also for Junio, I guess..):

If y'all feel that it can live with the rest of the git
commands then that would be great =3D)

I'm definitely willing to help maintain difftool.
It's a low-maintance script and making it easily available
means more testing which is good.  I should probably look
at the regression tests in place for mergetool and
see if I can start actually testing difftool using a
similar strategy.

--=20

	David
