From: "Tim Visher" <tim.visher@gmail.com>
Subject: Problems Cloning an SVN repo.
Date: Tue, 9 Dec 2008 12:54:20 -0500
Message-ID: <c115fd3c0812090954n6e5e527anadf04936e1ca01f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 18:56:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA6oO-0003jM-UV
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 18:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965AbYLIRyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 12:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754372AbYLIRyY
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 12:54:24 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:59768 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081AbYLIRyW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 12:54:22 -0500
Received: by yw-out-2324.google.com with SMTP id 9so40349ywe.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 09:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=I70gMFNWuUEbOSwWyisUEeqR5pnxnRNceoZ+RKPYeUM=;
        b=ZruPRBWEOnOnT26ISraTzkMwpWJ8DjM7P77GLQVl7SCdpAx46RRQjfvAHlkCmydxRC
         B7dpnPnZCSekO2qZC8TJpL6AinQFPBzjrTqww8zhyY61/l6PWhGrOL8b6lVNudgGU2yW
         ughccBq8xELZ0ejNk+THzKiiWoS4+J71Bq8p4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=PMJ+nnCRqRgPS+rU2rzz9gbrRwCesNO0O/RTa0KVmdcyiwJ5jA16MXZNGOnkzq6CSB
         hCziD/8bQyv/Z+jJzMcE0g7RXVRFC3v7+ouY2Q06EQiV38GaC7cKrpSAXeZxiT4DCsBE
         j5twJ/igQ+QkZPZLIz7uRikeHln6H3S8cZT+c=
Received: by 10.100.96.9 with SMTP id t9mr344778anb.109.1228845260834;
        Tue, 09 Dec 2008 09:54:20 -0800 (PST)
Received: by 10.100.198.2 with HTTP; Tue, 9 Dec 2008 09:54:20 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102643>

Hello everyone,

I'm trying to use `git svn clone` to begin to work with a project
stored in subversion through git for the work I do on the project
locally.  I installed git through cygwin and I'm getting the following
error when executing the command.

    Can't locate SVN/Core.pm in @INC (@INC contains:
/usr/lib/perl5/site_perl/5.10 /usr/lib/perl5/5.10/i686-cygwin
/usr/lib/perl5/5.10 /usr/lib/perl5/site_perl/5.10/i686-cygwin
/usr/lib/perl5/vendor_perl/5.10/i686-cygwin
/usr/lib/perl5/vendor_perl/5.10 /usr/lib/perl5/site_perl/5.8
/usr/lib/perl5/vendor_perl/5.8 .) at /usr/sbin/git-core//git-svn line
29.

Any help?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
