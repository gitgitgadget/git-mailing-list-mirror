From: kenet3@yahoo.com
Subject: ssh git-pull fails
Date: Fri, 5 Jun 2009 02:37:16 -0700 (PDT)
Message-ID: <765581.84306.qm@web38806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 11:44:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCVy4-0007Xm-2C
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 11:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbZFEJnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 05:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbZFEJnz
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 05:43:55 -0400
Received: from web38806.mail.mud.yahoo.com ([209.191.125.97]:31318 "HELO
	web38806.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750876AbZFEJny (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 05:43:54 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jun 2009 05:43:54 EDT
Received: (qmail 85040 invoked by uid 60001); 5 Jun 2009 09:37:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1244194636; bh=HgZXKM6r10bINoGNx8Yicc61guWC/QnaegNeAgtF5vI=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=5fjIWSonA8XkFKA33QVnp1IkDsBB+L73OwR6PpYs1j2gT64EwVfQPfVvPULMFKmZwhuIBsJ3Z8EyAmmb5egOaPq73AK24JxBoBP3l10e0ZPppyV67hUOJ5FjDADazapWdE1PCs33AsWYPnxIdAMLU3L15M+LT6MsmCJUh8AzomE=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=oNu15XGc0SjdYXMRPNibZJFc+EokI6VRQ65+dsL7Mf48aPk+QmphJEc4CEXSg4qZZphXgfnV10LqncofnDHW+8KzLfY3M4optYYXtjPoQxiprnoOAp0WXNWgd7xvn7DDr07CMgVQe3wAuOfJross8CVlrbPK3tXV7no9CNJtZmo=;
X-YMail-OSG: KGoO3ikVM1n8RmR6eB1Fd_yn9yt2t3NZa3b0mdamtDIkpnC3Ry4JyEez.4Mtr6mT75eq1GCmMqnNen7dm03mLAytVHVFBDZGq07bf4J20rCyOS6aKudt_5WOi9.4Kdf.v68oobLMoBV5exnuLrgulbft5.SkGPEoM1j9emLKelQYp.lGOH9EP2m34aG96_fU9bd4dKdLnJyhaoeFEB03Dt8yd2_.W2aiLxRiA_sx8QuLjO_ZBOBhMV.tQoJUGHKxgNQ8.DpT3..dDwPqOcOz9PxT6HILEZaf60ktdkCA.RYKJufo7TdcTfqaxt_XlW8VeRIK_As-
Received: from [192.146.101.71] by web38806.mail.mud.yahoo.com via HTTP; Fri, 05 Jun 2009 02:37:16 PDT
X-Mailer: YahooMailRC/1277.43 YahooMailWebService/0.7.289.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120765>


Hi everyone,

Can anybody please help me with this problem?

I have trouble pulling from an external Git repository through ssh.

Here is the command I use:
$ git-pull ssh://myusername@external.host:/path/to/git/dir

This error comes up:
ssh: external.host:: Name or service not known
fatal: The remote end hung up unexpectedly

I've set core.sharedRepository to true in another.host's Git repository.
Also, umask is set to 27.

If I can manually ssh to external.host with no problem.

Please bear with me as I'm new with this.

Thanks,
Kenneth



      
