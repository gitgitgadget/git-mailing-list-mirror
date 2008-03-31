From: "D. Stuart Freeman" <stuart.freeman@et.gatech.edu>
Subject: Migrating svn to git with heavy use of externals
Date: Mon, 31 Mar 2008 16:59:00 -0400
Message-ID: <47F15094.5050808@et.gatech.edu>
Reply-To: stuart.freeman@et.gatech.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030707070008010708040402"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 23:26:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgRWH-00070P-03
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 23:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756187AbYCaVZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 17:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756178AbYCaVZi
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 17:25:38 -0400
Received: from deliverator1.ecc.gatech.edu ([130.207.185.171]:42682 "EHLO
	deliverator1.ecc.gatech.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756124AbYCaVZh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2008 17:25:37 -0400
X-Greylist: delayed 1610 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Mar 2008 17:25:37 EDT
Received: from deliverator6.ecc.gatech.edu (deliverator6.ecc.gatech.edu [130.207.185.176])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by deliverator1.ecc.gatech.edu (Postfix) with ESMTP id C8F412DD237
	for <git@vger.kernel.org>; Mon, 31 Mar 2008 16:59:47 -0400 (EDT)
Received: from deliverator6.ecc.gatech.edu (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id EDBD820C0A4
	for <git@vger.kernel.org>; Mon, 31 Mar 2008 16:58:46 -0400 (EDT)
Received: from mailprx3.gatech.edu (mailprx3.prism.gatech.edu [130.207.171.17])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.mail.gatech.edu", Issuer "Equifax" (verified OK))
	by deliverator6.ecc.gatech.edu (Postfix) with ESMTP id 78DEC20C148
	for <git@vger.kernel.org>; Mon, 31 Mar 2008 16:58:46 -0400 (EDT)
Received: from [130.207.46.56] (cetel-004-xx6.admin.gatech.edu [130.207.46.56])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	(sasl: method=PLAIN, username=dfreeman31@mailprx3.gatech.edu, sender=n/a)
	by mailprx3.gatech.edu (Postfix) with ESMTP id 3E1B4214C
	for <git@vger.kernel.org>; Mon, 31 Mar 2008 16:58:46 -0400 (EDT)
	(envelope-from stuart.freeman@et.gatech.edu)
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78605>

This is a multi-part message in MIME format.
--------------030707070008010708040402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I'm a developer on the Sakai project.  I think Sakai could benefit
greatly from use of git because we have a huge need to track local
changes while contributing back to a central codebase.  I've started
looking at git-svn and have managed to get a copy of our repository into
git, and looked at the stuff to do with submodules as a replacement for
externals.  The problem is we rely very heavily on externals, for
instance when we make a tag for release we tag all the modules at the
same time and use an externals file to build the release from those
tags.  I realize that's probably not a best practice, but it's what we
do.  Our latest release is here:
https://source.sakaiproject.org/svn/sakai/tags/sakai_2-5-0/ if you want
to get an idea of the scope of the problem.  How would you convert this
to a git repository?  I'm currently looking at
http://blog.alieniloquent.com/2008/03/08/git-svn-with-svnexternals/ but
that doesn't look like it would leave all the old release tags intact.

-- 
D. Stuart Freeman
Georgia Institute of Technology

--------------030707070008010708040402
Content-Type: text/x-vcard; charset=utf-8;
 name="stuart_freeman.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="stuart_freeman.vcf"

begin:vcard
fn:D. Stuart Freeman
n:Freeman;Douglas
email;internet:stuart.freeman@et.gatech.edu
tel;work:(404)385-1473
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------030707070008010708040402--
