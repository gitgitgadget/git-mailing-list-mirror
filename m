From: =?ISO-8859-1?Q?Jonas_Flod=E9n?= <jonas.floden@gmail.com>
Subject: Re: Unexpected behaviour with git stash save --keep-index?
Date: Tue, 02 Sep 2008 08:20:13 +0200
Message-ID: <g9ilut$n58$1@ger.gmane.org>
References: <B1185033-36D7-4504-92A3-6F75B6CE90DF@gmail.com> <20080902012804.GB6739@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 08:36:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaPUp-00035E-VX
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 08:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbYIBGfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2008 02:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbYIBGfG
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 02:35:06 -0400
Received: from main.gmane.org ([80.91.229.2]:59698 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279AbYIBGfF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 02:35:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KaPTi-0007sK-AF
	for git@vger.kernel.org; Tue, 02 Sep 2008 06:35:02 +0000
Received: from c-d2c9e253.93-16-64736c12.cust.bredbandsbolaget.se ([83.226.201.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 06:35:02 +0000
Received: from jonas.floden by c-d2c9e253.93-16-64736c12.cust.bredbandsbolaget.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 06:35:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-d2c9e253.93-16-64736c12.cust.bredbandsbolaget.se
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <20080902012804.GB6739@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94652>

SZEDER G=E1bor wrote:
 > 'git stash save --keep-index' means "save all local modifications an=
d
 >  remove all modifications from the working tree that are not in the
 > index".  This differs substantially from "save only those
 > modifications that are not in the index, and then remove them from
 > the working tree".
 >

Thanks for the explanation. It seemed strange first but now I know
why it does that.

 >> Also maybe someone could someone recommend a way to split an
 >> unclean working dir into several patches/commits?
 > The workflow described at the end of stash's man page (under 'Testin=
g
 >  partial commits') works well for me.
 >

Thanks. What about the case when I already have a number of existing
patches/commits and want to split the working dir into them.

Regards,
Jonas
