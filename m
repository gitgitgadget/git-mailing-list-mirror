From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] add missing dependencies on headers
Date: Sun, 8 Aug 2010 16:19:10 -0500
Message-ID: <20100808211910.GA7210@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 23:20:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiDIU-0008Ro-Kr
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 23:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab0HHVUl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Aug 2010 17:20:41 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48532 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab0HHVUk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 17:20:40 -0400
Received: by ywh1 with SMTP id 1so3224921ywh.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 14:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=6UtFwgC/n0Rk32qSoTqreKhoKrYQjGQjqut2ykSi/y4=;
        b=mw4EYgr9A7oQ7PWOXT60p4cchxijPh4yGGaZRUdJ47t8XKvCgvSr78hLQ7RBjKgAH6
         PnF1B9YBRpQGXPZky/cmNz0qCGTjINO5QAFLNwXvR1f95RErRS9i0UX/sfwA+mjoa8zp
         3HUFNHVzKFZbQReZvtmXXttCXobtAhROpHPeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=sAwDhljFy9tBm4WHENm0/PnbCnBIfGiBjG7hnEImIZQYAuXThRXbiyNv30p24NwCR5
         XHaO84ecmrYZeNF0Te5mhQbi6kwlLdWZ1kZtDASrlXIpxu7Yb7kvU1Jf3B3gmlZZIVZO
         CIEZY0S3xp2E+tug4n2nCkZCJYqv4jeN9TCJ4=
Received: by 10.151.116.1 with SMTP id t1mr16587493ybm.329.1281302439528;
        Sun, 08 Aug 2010 14:20:39 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id q17sm3926456ybk.17.2010.08.08.14.20.38
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 14:20:39 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152930>

=46rom a local run of =E2=80=9Cmake CHECK_HEADER_DEPENDENCIES=3D1=E2=80=
=9D.

Jonathan Nieder (2):
  Makefile: add missing dependencies on url.h
  Makefile: add missing dependency on http.h

 Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)
