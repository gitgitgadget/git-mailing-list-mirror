From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Any tricks for speeding up cvsps?
Date: Fri, 08 Feb 2008 13:02:35 +0100
Message-ID: <47AC44DB.1000002@alum.mit.edu>
References: <47AC1FDC.9000502@glidos.net> <20080208094812.GA9666@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Gardiner <osronline@glidos.net>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 13:03:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNRxO-0001Lq-56
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 13:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbYBHMC7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Feb 2008 07:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbYBHMC7
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 07:02:59 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:53329 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbYBHMC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 07:02:58 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.142])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m18C2kR6017861
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 8 Feb 2008 13:02:46 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8pre) Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <20080208094812.GA9666@diana.vm.bytemark.co.uk>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73079>

Karl Hasselstr=F6m wrote:
> On 2008-02-08 09:24:44 +0000, Paul Gardiner wrote:
>=20
>> I'm trying to convert a huge cvs repository. I've left cvsps running
>> for days. First attempt, stderr filled my disc with warnings about
>> tags that couldn't be associated with any one commit, without
>> producing anything from stdout. I'm now redirecting stderr to
>> /dev/null, but it still just sits there producing nothing. Is
>> git-cvsimport infeasible for large repositories, or are there tricks
>> I might use?
>=20
> This topic comes up on the list every once in a while; try searching
> the list archives.
>=20
> I seem to recall that for heavy imports, the Subversion CVS importer
> is popular. I don't know if it can give you a git repository directly=
,
> or if you'll have to go via svn.

The trunk version of cvs2svn [1] can convert directly from CVS to git,
including branches and tags.  Recently I wrote up better documentation
[2] for using cvs2svn to convert to git.

Please direct suggestions, bug reports, or offers of help to the cvs2sv=
n
mailing lists [3] or irc channel [4].

Michael Haggerty

[1] http://cvs2svn.tigris.org
[2] http://cvs2svn.tigris.org/cvs2git.html
[3] http://cvs2svn.tigris.org/servlets/ProjectMailingListList
[4] irc.freenode.net, channel #cvs2svn
