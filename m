From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3 2/8] mingw: work around irregular failures of
 unlink on windows
Date: Tue, 14 Dec 2010 23:31:45 +0100
Message-ID: <20101214223145.GG4084@sandbox>
References: <20101214220604.GA4084@sandbox>
 <20101214221134.GC4084@sandbox>
 <AANLkTiksyVETuR8ftTojf=T2AhKGFtUAmqyj5u-00kW0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 23:31:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSdPY-0008Ow-JJ
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 23:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758976Ab0LNWbv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 17:31:51 -0500
Received: from darksea.de ([83.133.111.250]:56800 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758968Ab0LNWbu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 17:31:50 -0500
Received: (qmail 21707 invoked from network); 14 Dec 2010 23:31:48 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Dec 2010 23:31:48 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTiksyVETuR8ftTojf=T2AhKGFtUAmqyj5u-00kW0@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163700>

On Tue, Dec 14, 2010 at 11:14:13PM +0100, Erik Faye-Lund wrote:
> On Tue, Dec 14, 2010 at 11:11 PM, Heiko Voigt <hvoigt@hvoigt.net> wro=
te:
> > +static inline int is_file_in_use_error(DWORD errcode)
> > +{
> > + =A0 =A0 =A0 switch(GetLastError()) {
>=20
> Why pass the error code in, just to ignore it? Shouldn't this switch
> on "errcode" instead?

Definitely. Thanks for spotting that.

Cheers Heiko
