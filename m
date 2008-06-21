From: shire <shire@tekrat.com>
Subject: Re: [PATCH] Move deletion of configure generated files to distclean
Date: Sat, 21 Jun 2008 00:33:26 -0700
Message-ID: <AC4B20A5-396B-462D-9ACA-4E140B0876E2@tekrat.com>
References: <D4D1BF84-3D3F-4DEC-87C0-F926228E0BF5@tekrat.com> <20080621013547.GF7369@leksak.fem-net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: multipart/mixed; boundary=Apple-Mail-4--496794295
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jun 21 09:34:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9xc9-0004zK-HS
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 09:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbYFUHda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 03:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbYFUHd3
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 03:33:29 -0400
Received: from sizzo.org ([69.63.177.213]:51938 "EHLO sizzo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbYFUHd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 03:33:29 -0400
Received: from [10.0.1.200] (dsl092-189-079.sfo1.dsl.speakeasy.net [66.92.189.79])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sizzo.org (Postfix) with ESMTPSA id 8152A4F765C;
	Sat, 21 Jun 2008 00:33:28 -0700 (PDT)
In-Reply-To: <20080621013547.GF7369@leksak.fem-net>
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85694>


--Apple-Mail-4--496794295
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

On Jun 20, 2008, at 6:35 PM, Stephan Beyer wrote:

> Hi,
>
> whitespace and linebreaks are broken in your patch.
> (Just noticed because I needed a quick patch to test something and I
> took yours.)
>

Doh, thanks!  It appears there's no good simple way around the email  
body being munged in os x's mail.app, and I was mislead in my initial  
test email to myself.  I'll either fix mail.app in the future or send  
via some other mailer, I apologize for the obvious mistake despite  
all the guidelines in the patches file.  I've gone ahead and just  
attached the patch to this email that should apply cleanly with git-am.


--Apple-Mail-4--496794295
Content-Transfer-Encoding: quoted-printable
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=0001-Move-deletion-of-configure-generated-files-to-distcl.patch
Content-Disposition: attachment;
	filename=0001-Move-deletion-of-configure-generated-files-to-distcl.patch

=46rom=206c3ec53f54ca346f7fff38ee4ef748cac3c0f488=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Brian=20Shire=20=
<shire@99-204-10-66.area1.spcsdns.net>=0ADate:=20Fri,=2020=20Jun=202008=20=
17:53:51=20-0700=0ASubject:=20[PATCH]=20Move=20deletion=20of=20configure=20=
generated=20files=20to=20distclean=0A=0A---=0A=20Makefile=20|=20=20=20=20=
2=20+-=0A=201=20files=20changed,=201=20insertions(+),=201=20deletions(-)=0A=
=0Adiff=20--git=20a/Makefile=20b/Makefile=0Aindex=20b003e3e..f868b0b=20=
100644=0A---=20a/Makefile=0A+++=20b/Makefile=0A@@=20-1346,6=20+1346,7=20=
@@=20dist-doc:=0A=20###=20Cleaning=20rules=0A=20=0A=20distclean:=20clean=0A=
+=09$(RM)=20config.log=20config.mak.autogen=20config.mak.append=20=
config.status=20config.cache=0A=20=09$(RM)=20configure=0A=20=0A=20clean:=0A=
@@=20-1355,7=20+1356,6=20@@=20clean:=0A=20=09$(RM)=20$(TEST_PROGRAMS)=0A=20=
=09$(RM)=20*.spec=20*.pyc=20*.pyo=20*/*.pyc=20*/*.pyo=20common-cmds.h=20=
TAGS=20tags=20cscope*=0A=20=09$(RM)=20-r=20autom4te.cache=0A-=09$(RM)=20=
config.log=20config.mak.autogen=20config.mak.append=20config.status=20=
config.cache=0A=20=09$(RM)=20-r=20$(GIT_TARNAME)=20.doc-tmp-dir=0A=20=09=
$(RM)=20$(GIT_TARNAME).tar.gz=20git-core_$(GIT_VERSION)-*.tar.gz=0A=20=09=
$(RM)=20$(htmldocs).tar.gz=20$(manpages).tar.gz=0A--=20=0A1.5.6.dirty=0A=0A=

--Apple-Mail-4--496794295--
