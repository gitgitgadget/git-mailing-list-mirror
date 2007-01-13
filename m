From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Sat, 13 Jan 2007 13:23:52 +0100
Organization: Dewire
Message-ID: <200701131323.53121.robin.rosenberg.lists@dewire.com>
References: <871wm08kcu.fsf@morpheus.local> <7vr6tzogp4.fsf@assigned-by-dhcp.cox.net> <7vmz4nog5b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 13:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5hrw-0006NV-Cn
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 13:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbXAMMUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 13 Jan 2007 07:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbXAMMUG
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 07:20:06 -0500
Received: from [83.140.172.130] ([83.140.172.130]:19072 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1030524AbXAMMUE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jan 2007 07:20:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7B7C080265C;
	Sat, 13 Jan 2007 13:15:39 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24799-02; Sat, 13 Jan 2007 13:15:39 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 29002800199;
	Sat, 13 Jan 2007 13:15:37 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.4
In-Reply-To: <7vmz4nog5b.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36752>

l=F6rdag 13 januari 2007 02:43 skrev Junio C Hamano:
> Side note.  The previous patch does not help if your commit were
> made in non UTF-8 with not too recent git; the code assumes that
> commit messages without the new "encoding" headers are in UTF-8.

Wasn't there a repository option, "commitencoding"?  I can't see it bei=
ng
used here. I.e., we should err out if the log message is not UTF-8 and =
the=20
option is not set (giving a message telling the user to set it).  If it=
 is=20
set we should consider the repository encoding to be the one and if tha=
t too=20
is wrong (only possible to detect for some encodings), just assume iso-=
8859-1=20
as anything could in theory be iso-8859-1 encoded. =20

-- robin
