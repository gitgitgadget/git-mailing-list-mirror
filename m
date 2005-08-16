From: Alex Bennee <alexjb@transitive.com>
Subject: Re: Importing from CVS issues
Date: Tue, 16 Aug 2005 14:48:19 +0100
Message-ID: <1124200099.7444.37.camel@okra.transitives.com>
References: <1124188894.7444.9.camel@okra.transitives.com>
	 <u5toe7y2i28.fsf@fidgit.hq.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Aug 16 15:50:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E51ov-0003B7-6F
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 15:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233AbVHPNt1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 Aug 2005 09:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbVHPNt1
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 09:49:27 -0400
Received: from smarthost0.mail.uk.easynet.net ([212.135.6.10]:24327 "EHLO
	smarthost0.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S965233AbVHPNt0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 09:49:26 -0400
Received: from [217.207.128.220] (helo=mx.transitive.com)
	by smarthost0.mail.uk.easynet.net with esmtp (Exim 4.10)
	id 1E51oZ-000DuO-00
	for git@vger.kernel.org; Tue, 16 Aug 2005 14:49:15 +0100
To: git@vger.kernel.org
In-Reply-To: <u5toe7y2i28.fsf@fidgit.hq.vtech>
X-Mailer: Evolution 2.2.1 
X-TL-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-08-16 at 14:16 +0200, David K=E5gedal wrote:
> Alex Bennee <kernel-hacker@bennee.com> writes:
>=20
> > Before the import script finally dies with:
> >
> > WARNING: revision 1.3.2.1 of file
> > scripts/xmltools/t/data/gzip/DO-NOT-BACKUP on unnamed branch
> > DONE; creating master branch
> > cp: cannot stat `/export/test/cvstogit/.git/refs/heads/origin': No =
such
> > file or directory
>=20
> Was this done with an empty destination dir?  I've seen similar thing=
s
> happen in a dir where an interrupted cvs import was done previously,
> and the 'origin' branch was never created.

Yes, in fact I let the script create the new destination dir. So I don'=
t
think its an issue with stale data from a previous attempt being left
around.

>=20
--
Alex Bennee - alexjb@transitive.com
"The world is beating a path to our door" -- Bruce Perens, (Open
Sources, 1999 O'Reilly and Associates)
