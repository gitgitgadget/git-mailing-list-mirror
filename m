From: Alejandro Riveira =?UTF-8?B?RmVybsOhbmRleg==?= 
	<ariveira@gmail.com>
Subject: Re: git doc build failure on OS X 10.5.6 (Leopard) during xmlto  
 phase
Date: Thu, 12 Mar 2009 15:02:36 +0100
Message-ID: <20090312150236.5684b816@varda>
References: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com>
	<76718490903110812t5e1723ebi28a84da680422d8a@mail.gmail.com>
	<76718490903110839m17041c7bxd7912eb09496c81a@mail.gmail.com>
	<76718490903110849x2ef48a89j3f17706390991eda@mail.gmail.com>
	<49B7E670.7060606@drmicha.warpmail.net>
	<gp95vf$gp1$1@ger.gmane.org>
	<49B8EF3E.2070208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>,
	Tom Holaday <tlholaday@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 15:08:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhlW7-0002tv-O7
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 15:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224AbZCLOCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 10:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbZCLOCn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 10:02:43 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:13888 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbZCLOCm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 10:02:42 -0400
Received: by ey-out-2122.google.com with SMTP id 25so112106eya.37
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=suU3UGC++8qbkNA2C0xUBfDfDGJJj9pKXfd1a8oqdis=;
        b=g9+OCpCqhxgywIZBNH/afip8THqQ2gKOifvCVD6WNAsjlfrKP/j2ee0snFBG+m1GlV
         xtcIcHkJvbxmSHU8F9VIaCrt/D2R8fMJUN4HT6Jade77rIEVDZsJZEzLq1kNmlhO7dBN
         duARhfGrNT3DVmi9Ie7uXH/Qp9+lwEc9PIE1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=bVc7WXId5Cw/eV5h90gIg7DyvHo0hh7RQhIok7+c9l6fwS8vxEjMoFisU2qpGEMP9Q
         PmCquF0PLsNAPuY6wt1Gu4Fb2ng3vT3gLn3t9SQXLXZRj+X0rktZ2DQce0ulcn0goLIl
         Z2PoxGjCWiee6WNU99x278Ee78uIJQ5n3YhWE=
Received: by 10.216.0.81 with SMTP id 59mr6504wea.77.1236866559261;
        Thu, 12 Mar 2009 07:02:39 -0700 (PDT)
Received: from varda (167.Red-83-38-73.dynamicIP.rima-tde.net [83.38.73.167])
        by mx.google.com with ESMTPS id 34sm1225926nfu.77.2009.03.12.07.02.37
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Mar 2009 07:02:38 -0700 (PDT)
In-Reply-To: <49B8EF3E.2070208@drmicha.warpmail.net>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113070>

El Thu, 12 Mar 2009 12:17:18 +0100
Michael J Gruber <git@drmicha.warpmail.net> escribi=C3=B3:

> Alejandro Riveira venit, vidit, dixit 11.03.2009 21:12:

> >>
> >  "Me too" from a Ubuntu 8.10 Box
>=20
> Following up on this:
> On Fedora 10, I have asciidoc 8.2.5 and docbook 1.7.4 xsl's. For prop=
er
> man and html doc, I have to set DOCBOOK_XSL_172=3DYes but leave ASCII=
DOC8
> unset! I always forget, though (just like the packagers).
>=20
> Setting DOCBOOK_XSL_172 shuts off a certain hack which would otherwis=
e
> introduce the notorious .ft in man output.
>=20
> Setting ASCIIDOC8 would keep _emphasis_ from being transformed into
> <emphasis>emphasis</emphasis>, which means it would end up as literal
> _emphasis_ in man as well as html.
>=20
> Michael
>=20
> BTW: Alejandro, please don't cull cc here.

 I'm sorry :[
 In my defense that was using gmane new service via Pan=20
=20
 Thanks for the explanation on how to workaround the issue
