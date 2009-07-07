From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Re: Proper tracking of copies in git log and others
Date: Tue, 07 Jul 2009 08:53:44 +0200
Message-ID: <h2ure0$j73$1@ger.gmane.org>
References: <4A4F8258.5070701@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 08:54:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO4ZE-00089o-W2
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 08:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbZGGGyH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2009 02:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbZGGGyE
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 02:54:04 -0400
Received: from main.gmane.org ([80.91.229.2]:44532 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753608AbZGGGyE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 02:54:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MO4Z2-00024L-3D
	for git@vger.kernel.org; Tue, 07 Jul 2009 06:54:04 +0000
Received: from dsl-245-91-189.telkomadsl.co.za ([41.245.91.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 06:54:04 +0000
Received: from graemeg by dsl-245-91-189.telkomadsl.co.za with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 06:54:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-245-91-189.telkomadsl.co.za
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <4A4F8258.5070701@trn.iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122824>

Lasse K=C3=A4rkk=C3=A4inen wrote:
> Getting full history of a file, including that beyond copies, is rath=
er=20
> important and apparently not currently supported by git tools.

You seem to be right. I'm quite new to Git so don't know all the=20
commands, but this is what I came up with..


$ git log --raw 2009/exercise2/description.txt
commit edfd954572e844b05a7489bcaa149afb679bc1f6
Author: Graeme Geldenhuys <graeme@mastermaths.co.za>
Date:   Tue Jul 7 08:44:20 2009 +0200

     Course 2009 recycled entirely from 2008

:000000 100644 0000000... e965047... A  2009/exercise2/description.txt


We then take note of the  ^^^^^^^  value and generate the following
command.


$ git log -C --raw | grep e965047
:000000 100644 0000000... e965047... A	2009/exercise2/description.txt
:000000 100644 0000000... e965047... A	2008/exercise2/description.txt
:000000 100644 0000000... e965047... A	2007/exercise1/description.txt


Now now shows you the history of the file as it was copied from one
directory to another.


Regards,
   - Graeme -

--=20
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
