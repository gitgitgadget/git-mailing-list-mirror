From: "Li Frank-B20596" <Frank.Li@freescale.com>
Subject: RE: [QGit] Some suggestion
Date: Thu, 25 Sep 2008 23:20:53 +0800
Message-ID: <7FD1F85C96D70C4A89DA1DF7667EAE96079FBB@zch01exm23.fsl.freescale.net>
References: <gbak2u$v9b$1@ger.gmane.org> <7FD1F85C96D70C4A89DA1DF7667EAE96079EDF@zch01exm23.fsl.freescale.net> <e5bfff550809250451q578b8e10r75c043d307a63f28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 17:24:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KisfX-0000wc-FI
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 17:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370AbYIYPVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 11:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754590AbYIYPVF
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 11:21:05 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:51786 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370AbYIYPVD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2008 11:21:03 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id m8PFL0Rd002277
	for <git@vger.kernel.org>; Thu, 25 Sep 2008 08:21:01 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net [10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m8PFKx0r001095
	for <git@vger.kernel.org>; Thu, 25 Sep 2008 10:21:00 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <e5bfff550809250451q578b8e10r75c043d307a63f28@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [QGit] Some suggestion
Thread-Index: AckfBSEkKljxd+ksTW6m/8UF1bKfQwAGt5Vg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96777>

Marco:
	
	Yes, it is really work although it is not nature way.
	This way don't work at file view. 

	Ctrl +/- change font size, but how to change source code view
font size. 
	
	12. Marcor Costalba  10 #include <QProcess>
	12. Marcor Costalba  10 #include <QRegExp>


Best regards
Frank Li 

-----Original Message-----
From: Marco Costalba [mailto:mcostalba@gmail.com] 
Sent: Thursday, September 25, 2008 7:52 PM
To: Li Frank-B20596
Cc: git@vger.kernel.org
Subject: Re: [QGit] Some suggestion

On Thu, Sep 25, 2008 at 7:24 AM, Li Frank-B20596
<Frank.Li@freescale.com> wrote:
> Can add below function at qgit?
> ===Difference other version===
>        1. user choose a commit,
>        2. right click
>                Check working dir
>                View patch
>                ....
>                [Diff with other commit]
>
>        3. change icon +
>        4. user choose other commit
>
>        QGit show list of changed files.
>        click one files, call extern diff tool show difference.
>
> === file view ===
>        Can use different color to high light current commit change.
>

You can _already_ do this.

 1. user choose a commit

 2. user choose other commit with CTRL + RIGHT CLICK


One of the problems of qgit is that the features are not immediately
visible. This is a conscious choice to avoid cluttering the GUI.

Currently the _best_ way to have a  complete idea of qgit is to read the
handbook (press F1 key): it takes only 5 minutes and you can find
interesting features otherwise very difficult to find by accident.

Marco
