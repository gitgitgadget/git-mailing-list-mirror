From: "D. Stuart Freeman" <stuart.freeman@et.gatech.edu>
Subject: Confused about recovering from a merge conflict
Date: Wed, 14 May 2008 11:59:14 -0400
Message-ID: <482B0C52.4030206@et.gatech.edu>
Reply-To: stuart.freeman@et.gatech.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050508030208010300090100"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 18:25:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwJm1-0006PF-Ay
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 18:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761829AbYENQXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 12:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762009AbYENQXN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 12:23:13 -0400
Received: from deliverator1.ecc.gatech.edu ([130.207.185.171]:51476 "EHLO
	deliverator1.ecc.gatech.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761931AbYENQXL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2008 12:23:11 -0400
X-Greylist: delayed 1434 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 May 2008 12:23:11 EDT
Received: from deliverator6.ecc.gatech.edu (deliverator6.ecc.gatech.edu [130.207.185.176])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by deliverator1.ecc.gatech.edu (Postfix) with ESMTP id 8C41A2DD0B5
	for <git@vger.kernel.org>; Wed, 14 May 2008 12:00:16 -0400 (EDT)
Received: from deliverator6.ecc.gatech.edu (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id C1F5E20C050
	for <git@vger.kernel.org>; Wed, 14 May 2008 11:59:15 -0400 (EDT)
Received: from mailprx5.gatech.edu (mailprx5.prism.gatech.edu [130.207.171.19])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.mail.gatech.edu", Issuer "Equifax" (verified OK))
	by deliverator6.ecc.gatech.edu (Postfix) with ESMTP id 662CF20C09A
	for <git@vger.kernel.org>; Wed, 14 May 2008 11:59:15 -0400 (EDT)
Received: from [130.207.46.56] (cetel-004-xx6.admin.gatech.edu [130.207.46.56])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	(sasl: method=PLAIN, username=dfreeman31@mailprx5.gatech.edu, sender=n/a)
	by mailprx5.gatech.edu (Postfix) with ESMTP id E86A11F86
	for <git@vger.kernel.org>; Wed, 14 May 2008 11:59:14 -0400 (EDT)
	(envelope-from stuart.freeman@et.gatech.edu)
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82107>

This is a multi-part message in MIME format.
--------------050508030208010300090100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I've made some local modifications and want to 'git svn dcommit' them so
I 'git svn rebase' first:

 $ git svn rebase
 First, rewinding head to replay your work on top of it...
 HEAD is now at cdef7ac Cleanup of new assignment screens
 Applying Cleanup new assignment screens
 error: tool/src/webapp/content/css/thickbox.css: does not match index
 error: patch failed:
tool/src/webapp/content/templates/newassignment1.html:6
 error: tool/src/webapp/content/templates/newassignment1.html: patch
does not apply
 Using index info to reconstruct a base tree...
 Falling back to patching base and 3-way merge...
 error: Entry 'tool/src/webapp/content/css/thickbox.css' not uptodate.
Cannot merge.
 fatal: merging of trees aa2dad90c89e9063f2a8002e4b5a11f6b1583955 and
6535ebaaebf
 fdaadd44a93bc1fc4a66a5ec4dcf4 failed
 Failed to merge in the changes.
 Patch failed at 0001.

 When you have resolved this problem run "git rebase --continue".
 If you would prefer to skip this patch, instead run "git rebase --skip".
 To restore the original branch and stop rebasing run "git rebase --abort".

 rebase refs/remotes/iteration_5: command returned error: 1

Uh-oh, now I appear to be on 'no branch' and the contents of
thickbox.css aren't marked up with the conflict markers, it appears to
just be the old file without my revisions.  Did I do something wrong?
How do I recover from this state?

-- 
D. Stuart Freeman
Georgia Institute of Technology

--------------050508030208010300090100
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


--------------050508030208010300090100--
