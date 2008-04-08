From: "D. Stuart Freeman" <stuart.freeman@et.gatech.edu>
Subject: Re: Migrating svn to git with heavy use of externals
Date: Tue, 08 Apr 2008 14:07:04 -0400
Message-ID: <47FBB448.3060900@et.gatech.edu>
References: <47F15094.5050808@et.gatech.edu>
Reply-To: stuart.freeman@et.gatech.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050206030203090809050403"
Cc: git@vger.kernel.org
To: stuart.freeman@et.gatech.edu
X-From: git-owner@vger.kernel.org Tue Apr 08 20:08:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjIEb-0006Dw-SA
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 20:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbYDHSHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 14:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbYDHSHH
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 14:07:07 -0400
Received: from deliverator4.ecc.gatech.edu ([130.207.185.174]:55295 "EHLO
	deliverator4.ecc.gatech.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752096AbYDHSHF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Apr 2008 14:07:05 -0400
Received: from deliverator4.ecc.gatech.edu (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id CC2CD5E4127
	for <git@vger.kernel.org>; Tue,  8 Apr 2008 14:07:03 -0400 (EDT)
Received: from mailprx1.gatech.edu (mailprx1.prism.gatech.edu [130.207.171.15])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.mail.gatech.edu", Issuer "Equifax" (verified OK))
	by deliverator4.ecc.gatech.edu (Postfix) with ESMTP id 801B95E412C;
	Tue,  8 Apr 2008 14:07:02 -0400 (EDT)
Received: from [130.207.46.56] (cetel-004-xx6.admin.gatech.edu [130.207.46.56])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	(sasl: method=PLAIN, username=dfreeman31@mailprx1.gatech.edu, sender=n/a)
	by mailprx1.gatech.edu (Postfix) with ESMTP
	id 6F3A01EF8; Tue,  8 Apr 2008 14:07:01 -0400 (EDT)
	(envelope-from stuart.freeman@et.gatech.edu)
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
In-Reply-To: <47F15094.5050808@et.gatech.edu>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79011>

This is a multi-part message in MIME format.
--------------050206030203090809050403
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Maybe I should clarify.
I've imported an svn managed project into a git repository
with 71 submodules, what I don't understand though is if I
have a branch called 2-5-x and another called 2-4-x in each of
the submodules and the superproject, is there a way to
associate those?

D. Stuart Freeman wrote:
> I'm a developer on the Sakai project.  I think Sakai could benefit
> greatly from use of git because we have a huge need to track local
> changes while contributing back to a central codebase.  I've started
> looking at git-svn and have managed to get a copy of our repository into
> git, and looked at the stuff to do with submodules as a replacement for
> externals.  The problem is we rely very heavily on externals, for
> instance when we make a tag for release we tag all the modules at the
> same time and use an externals file to build the release from those
> tags.  I realize that's probably not a best practice, but it's what we
> do.  Our latest release is here:
> https://source.sakaiproject.org/svn/sakai/tags/sakai_2-5-0/ if you want
> to get an idea of the scope of the problem.  How would you convert this
> to a git repository?  I'm currently looking at
> http://blog.alieniloquent.com/2008/03/08/git-svn-with-svnexternals/ but
> that doesn't look like it would leave all the old release tags intact.
> 


-- 
D. Stuart Freeman
Georgia Institute of Technology

--------------050206030203090809050403
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


--------------050206030203090809050403--
