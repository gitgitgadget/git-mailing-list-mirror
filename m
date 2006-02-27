From: Peter Hagervall <hager@cs.umu.se>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 15:31:47 +0100
Message-ID: <20060227143147.GA12196@brainysmurf.cs.umu.se>
References: <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org> <20060226103604.2d97696c.akpm@osdl.org> <Pine.LNX.4.64.0602261213340.22647@g5.osdl.org> <20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer> <Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de> <94fc236b0602270326s3079d737l102d5728d59f0c98@mail.gmail.com> <4402E56D.4010606@op5.se> <20060227133124.GA8794@informatik.uni-freiburg.de> <4403086F.5040704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 15:32:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDjPt-0000Tx-PP
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 15:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWB0Ob6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Feb 2006 09:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWB0Ob6
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 09:31:58 -0500
Received: from mail.cs.umu.se ([130.239.40.25]:39308 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S1751256AbWB0Ob5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 09:31:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 59B642BB3;
	Mon, 27 Feb 2006 15:31:56 +0100 (MET)
Received: from mail.cs.umu.se ([127.0.0.1])
 by localhost (mimmi.cs.umu.se [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 09592-02-12; Mon, 27 Feb 2006 15:31:48 +0100 (MET)
Received: from brainysmurf.cs.umu.se (brainysmurf.cs.umu.se [130.239.89.21])
	by mail.cs.umu.se (Postfix) with ESMTP id 6D5BB2BA2;
	Mon, 27 Feb 2006 15:31:48 +0100 (MET)
Received: by brainysmurf.cs.umu.se (Postfix, from userid 12006)
	id 18FC46A2; Mon, 27 Feb 2006 15:31:48 +0100 (CET)
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <4403086F.5040704@op5.se>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: amavisd-new at cs.umu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16847>

On Mon, Feb 27, 2006 at 03:10:55PM +0100, Andreas Ericsson wrote:
> So in essence, a multi-line statement is closed when a completely emp=
ty=20
> line is found, which means that making git internals recognize and st=
rip=20
> such lines will result in Python code never being manageable by git.
>=20

I believe completely empty lines are to be left untouched. The war is o=
n
trailing whitespace.

/ Peter

--=20
Peter Hagervall......................email: hager@cs.umu.se
Department of Computing Science........tel: +46(0)90 786 7018
University of Ume=E5, SE-901 87 Ume=E5.....fax: +46(0)90 786 6126
