From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: Re: specify charset for commits
Date: Fri, 22 Dec 2006 23:02:04 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061222220204.GA2407@cepheus>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de> <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de> <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de> <20061222150948.GA6005@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Dec 22 23:02:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxsSy-0005kT-Hs
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 23:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbWLVWCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Dec 2006 17:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752978AbWLVWCJ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 17:02:09 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:34804 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753015AbWLVWCI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Dec 2006 17:02:08 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1GxsSs-0004jq-R5; Fri, 22 Dec 2006 23:02:06 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id kBMM24m1024991;
	Fri, 22 Dec 2006 23:02:04 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id kBMM23YH024990;
	Fri, 22 Dec 2006 23:02:03 +0100 (MET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	git@vger.kernel.org
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20061222150948.GA6005@cepheus>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35231>

Hello,

Uwe Kleine-K=F6nig wrote:
> 	def is_utf8_str(s):
> 	  cnt_furtherbytes =3D 0
> 	  for c in s:
> 	    if cnt_furtherbytes > 0:
> 	      if ord(c) & 0xc0 =3D=3D 0x80:
> 	        cnt_furtherbytes -=3D 1
> 	      else:
> 	        return False
> 	    else:
> 	      if ord(c) < 0x80:
> 	        continue
> 	      elif ord(c) < 0xc0:
> 	        return False
> 	      elif ord(c) < 0xe0:
> 	        cnt_furtherbytes =3D 1
> 	      elif ord(c) < 0xf0:
> 	        cnt_furtherbytes =3D 2
> 	      elif ord(c) < 0xf8:
> 	        cnt_furtherbytes =3D 3
> 	      elif ord(c) < 0xfc:
> 	        cnt_furtherbytes =3D 4
> 	      elif ord(c) < 0xfe:
> 	        cnt_furtherbytes =3D 5
> 	      else:
> 	        return False
> 	  return True
While I washed the dishes I noticed that the last "return True" should
be "return cnt_furtherbytes =3D=3D 0".  Just before someone else correc=
ts me
=2E.. :-)

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dparsec%5E2*Joule%2FNewton+in+tablespoo=
n
