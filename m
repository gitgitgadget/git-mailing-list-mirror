From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 01/12] git-grep: read config
Date: Wed, 23 Jul 2008 21:55:35 +0700
Message-ID: <20080723145535.GA29053@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 16:57:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfm4-0002E8-Jw
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbYGWOz4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbYGWOz4
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:55:56 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:42933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbYGWOzz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:55:55 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1202339tic.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=iVi0GW+0iskW51LVmN26usCKAnMcHL2S05uBt1h0AIc=;
        b=aDP+FJ2JmkL8A+i9QBn5JY+KHFEqs+6MRI3RLOAVkfEjBFjIDOBxz5kLgH2fERH/5I
         kU7CbSVYa3NLhp+nZYGCGcGuxeMSMi6d5nqfDfH3Lv0LyJ/xGjLnYEPk2RiJaPq38Qfy
         tXflA4LICeIdyq1De0SOpbzSzUNCrd9kBAXkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=Xl4o3wXhFrsYMxsHCDB73MakhIQExSaATMQ5tJqDgp6ddD9AqpnPwutAjtGrrvNH9e
         Lw79eO1es++q2qactHmbWCFj3xPqLzNRTO5SL0Z1IBD8Q7vQ4/eo2ygkNs9ltoLUDiWo
         lUBcbe6c4yMQZOq8m87toI5/4wU1O+mU5+Vg8=
Received: by 10.110.95.15 with SMTP id s15mr100817tib.40.1216824954976;
        Wed, 23 Jul 2008 07:55:54 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.5.7])
        by mx.google.com with ESMTPS id b4sm15416341tic.14.2008.07.23.07.55.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:55:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Jul 2008 21:55:35 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89669>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-grep.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 631129d..cc9ba6b 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -517,6 +517,8 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	const char **paths =3D NULL;
 	int i;
=20
+	git_config(git_default_config, NULL);
+
 	memset(&opt, 0, sizeof(opt));
 	opt.prefix_length =3D (prefix && *prefix) ? strlen(prefix) : 0;
 	opt.relative =3D 1;
--=20
1.5.5.GIT
