From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Fri, 13 Jun 2014 11:01:18 +0300
Message-ID: <20140613080118.GB2117@redhat.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
 <5399FEC2.3020309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 13 10:00:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvMPx-0006IP-7j
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 10:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbaFMIAx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 04:00:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13223 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879AbaFMIAw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 04:00:52 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5D80owS027648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2014 04:00:51 -0400
Received: from redhat.com (ovpn-116-16.ams2.redhat.com [10.36.116.16])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s5D80m8P019962;
	Fri, 13 Jun 2014 04:00:49 -0400
Content-Disposition: inline
In-Reply-To: <5399FEC2.3020309@web.de>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251532>

On Thu, Jun 12, 2014 at 09:25:54PM +0200, Ren=E9 Scharfe wrote:
> Am 12.06.2014 18:12, schrieb Michael S. Tsirkin:
> >@@ -136,7 +136,7 @@ fall_back_3way () {
> >      eval "$cmd" &&
> >      GIT_INDEX_FILE=3D"$dotest/patch-merge-tmp-index" \
> >      git write-tree >"$dotest/patch-merge-base+" ||
> >-    cannot_fallback "$(gettext "Repository lacks necessary blobs to=
 fall back on 3-way merge.")"
> >+    cannot_fallback "$(gettext "Repository lsignoffs necessary blob=
s to fall back on 3-way merge.")"
>=20
> lsignoffs?

Heh good catch, I'll fix this up.
Thanks!
