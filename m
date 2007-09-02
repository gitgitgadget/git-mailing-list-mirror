From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: problem with git cvsimport
Date: Sun, 02 Sep 2007 08:37:06 +0200
Message-ID: <46DA5A12.2090506@alum.mit.edu>
References: <A74F186F-7C25-48D5-9354-C74576439AF1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean.francois.veillette@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 08:37:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRj5E-0007ZO-IS
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 08:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbXIBGhQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 02:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbXIBGhQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 02:37:16 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:53038 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbXIBGhO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 02:37:14 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.131] (kaiserty.in-dsl.de [217.197.85.174])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l826b8gh000895
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 2 Sep 2007 08:37:08 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.13) Gecko/20070824 Thunderbird/1.5.0.13 Mnenhy/0.7.5.666
In-Reply-To: <A74F186F-7C25-48D5-9354-C74576439AF1@gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57297>

Jean-Fran=E7ois Veillette wrote:
> I can't get git-cvsimport to convert a cvs project to git (full log
> bellow).
> I always get :
>     fatal: Not a valid object name refs/heads/HEAD
>     read-tree failed: 32768
>=20
> I'm a relatively new to git. I would like to convert my project and
> track external projects with git.
> But cvsimport seem to fail.  Any pointer to help me resolve the issue=
 is
> welcome !

I suggest you try the experimental support in cvs2svn for converting to
git.  cvs2svn is very good about understanding strange CVS histories.
See the following thread for more information:

    http://marc.info/?l=3Dgit&m=3D118592701426175&w=3D4

Michael
