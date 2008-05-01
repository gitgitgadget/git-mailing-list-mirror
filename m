From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] git-gui: Update German translation
Date: Thu, 1 May 2008 15:43:57 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200805011543.57858.stimming@tuhh.de>
References: <200805011154.00427.stimming@tuhh.de> <20080501120441.GC7868@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu May 01 15:45:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrZ5m-00064X-EM
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 15:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411AbYEANoK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2008 09:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756868AbYEANoK
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 09:44:10 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:49363 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241AbYEANoJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2008 09:44:09 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m41Di2A6006928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 1 May 2008 15:44:03 +0200
Received: from [192.168.2.102] (p549025F5.dip0.t-ipconnect.de [84.144.37.245])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m41Di1SM026977
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 May 2008 15:44:02 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <20080501120441.GC7868@leksak.fem-net>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80909>

Am Donnerstag, 1. Mai 2008 14:04 schrieb Stephan Beyer:
> Hi,
>
> I did not find any typos in your changes. ;-)

That's good :-)

> Only a short note:
> >  #: lib/spellcheck.tcl:57
> >  msgid "Unsupported spell checker"
> > -msgstr ""
> > +msgstr "Rechtschreibpr??fungsprogramm nicht unterst??tzt"
>
> I'd like
> 	"Rechtschreibpr=C3=BCfer"
> more than a long word like
> 	"Rechtschreibpr=C3=BCfungsprogramm".
> But depends on taste, perhaps. ;)

The long word is admittantly ugly. However, the word used should make i=
t clear=20
that the entity which does the spell checking is a separate piece of so=
ftware=20
which is (most probably) also located in a separate package of your=20
distribution. Because if any of the errors occur, it results most proba=
bly=20
from installation problems with that separate software package. The str=
ings=20
in question are all related to errors - they don't show up in the non-e=
rror=20
case anyway. Hence, for these strings I'd stick to longer words that ar=
e=20
unambiguous enough. Maybe "Programm zur Rechtschreibpr=C3=BCfung" or "P=
aket zur=20
Rechtschreibpr=C3=BCfung"?

Regards,

Christian
