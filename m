From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH 2/2] Correct some language in fast-import documentation.
Date: Thu, 8 Feb 2007 09:28:50 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070208082850.GA4334@informatik.uni-freiburg.de>
References: <20070208075851.GB3950@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 09:29:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF4eX-0001CC-JS
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 09:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161488AbXBHI3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Feb 2007 03:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422859AbXBHI3K
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 03:29:10 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:49907 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161488AbXBHI3J (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Feb 2007 03:29:09 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HF4eS-0001r8-7S; Thu, 08 Feb 2007 09:29:08 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l188T5fq005298;
	Thu, 8 Feb 2007 09:29:05 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l188SpKD005297;
	Thu, 8 Feb 2007 09:28:51 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070208075851.GB3950@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39046>

Hello Shawn,

Shawn O. Pearce wrote:
> Minor documentation improvements, as suggested on the Git mailing
> list by Horst H. von Brand and Karl Hasselstr=C3=B6m.
you have an encoding problem here     ---------^

That "o umlaut" seems to be UTF-8 encoded, but the headers of you mail
claim iso-8859-1.

I had this kind of problem, too.  You have to assert that the
environment variable LANG (or LC_CTYPE) match your terminal and the mut=
t
config variable "charset" matches that, too.  (Not to set charset seems
to do the right thing.)

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+electron+mass%3D
