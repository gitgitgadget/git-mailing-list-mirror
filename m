From: "D. Stuart Freeman" <stuart.freeman@et.gatech.edu>
Subject: Re: Newbie question about making a bare repository
Date: Fri, 20 Jun 2008 16:53:06 -0400
Message-ID: <485C18B2.1060801@et.gatech.edu>
References: <4856B7A6.50508@et.gatech.edu>
Reply-To: stuart.freeman@et.gatech.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000408090509050803030608"
Cc: git@vger.kernel.org
To: stuart.freeman@et.gatech.edu
X-From: git-owner@vger.kernel.org Fri Jun 20 22:54:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9ncb-0003Zf-FX
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 22:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657AbYFTUxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 16:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbYFTUxL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 16:53:11 -0400
Received: from deliverator6.ecc.gatech.edu ([130.207.185.176]:48304 "EHLO
	deliverator6.ecc.gatech.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755163AbYFTUxJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jun 2008 16:53:09 -0400
Received: from deliverator6.ecc.gatech.edu (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 2433920C12D
	for <git@vger.kernel.org>; Fri, 20 Jun 2008 16:53:09 -0400 (EDT)
Received: from mailprx5.gatech.edu (mailprx5.prism.gatech.edu [130.207.171.19])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.mail.gatech.edu", Issuer "Equifax" (verified OK))
	by deliverator6.ecc.gatech.edu (Postfix) with ESMTP id C902220C107;
	Fri, 20 Jun 2008 16:53:07 -0400 (EDT)
Received: from [130.207.46.56] (cetel-004-xx6.admin.gatech.edu [130.207.46.56])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	(sasl: method=PLAIN, username=dfreeman31@mailprx5.gatech.edu, sender=n/a)
	by mailprx5.gatech.edu (Postfix) with ESMTP
	id 8DED22174; Fri, 20 Jun 2008 16:53:07 -0400 (EDT)
	(envelope-from stuart.freeman@et.gatech.edu)
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
In-Reply-To: <4856B7A6.50508@et.gatech.edu>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85676>

This is a multi-part message in MIME format.
--------------000408090509050803030608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

D. Stuart Freeman wrote:
> I have a repository that I made with 'git-svn clone' that I'd like to
> make bare but retain the svn info.  Would I just change the "bare" in
> .git/config to true?  Is there anything I have to do to remove the
> working copy info?
> 
> I plan to do this so that a co-worker and I can clone the git repo, and
> push our changes back to it, and maintain the "proxy" to svn from that
> central location.
> 

I think I've found a flaw in my plan.  Now that the repo is bare I can't
get any changes from upstream.  I run 'git --bare svn fetch' and that
works, but then I have no way to rebase those changes into a local
branch because I don't have a working copy.  Is there a way to see a
remote repo's remotes, and merge/rebase from there?

-- 
D. Stuart Freeman
Georgia Institute of Technology

--------------000408090509050803030608
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


--------------000408090509050803030608--
