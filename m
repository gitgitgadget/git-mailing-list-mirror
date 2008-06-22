From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Exec format error when using gitweb
Date: Sun, 22 Jun 2008 16:51:52 +0300
Message-ID: <ce513bcc0806220651g5cf59516w3fc30a68d7f09e79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 15:52:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAPzt-0004LU-CZ
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 15:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbYFVNvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 09:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbYFVNvx
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 09:51:53 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:22008 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbYFVNvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 09:51:53 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6521298rvb.1
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=9THTFutKhwiG9sY14C0eeGaxzILQJ6xTLMjvWnt4Gww=;
        b=BhDPam25u8u+xQqaTCrlt/umWbuUL/Yafgz0IUqpcj9sAQUn+fdUb5rKkzHcRhHXTb
         zvCmhxLnPdDzA2PDQN2e0R4azT6ALNhN1JXs0sBeBon8mTYqI38JFORp4NaIIKRwrqda
         pseW+riPjXA9hC3xr1IXMeNz+U6SVRWksUwr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=U4w8DX6EYUpzs+P4FoKqttRUxrVpTzuVwGUXbXuuJBMfGtyDFKbdc1b1zpjeF5IALE
         3PNLxHKRrgnuKSyh3zfNlN734pUIxP4/CH3pgV9eQNl/3wx/NSi33f3XXJKal+j3AFdh
         ZbKb4+4uOYUlwEEgd2qCGUWlKf8wEV/LUl34E=
Received: by 10.140.140.3 with SMTP id n3mr10852950rvd.299.1214142712300;
        Sun, 22 Jun 2008 06:51:52 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Sun, 22 Jun 2008 06:51:52 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85772>

Hi,

I'm trying to config gitweb using v1.5.5.3. I'm able to see my
repositories (through gitweb) but I see the following errors in
/var/log/httpd/error_log. Can anyone help?

[Sun Jun 22 16:33:53 2008] [error] [client 172.16.0.7] (8)Exec format
error: exec of '/var/www/cgi-bin/gitweb/gitweb.css' failed, referer:
http://kites/cgi-bin/gitweb/gitweb.cgi
[Sun Jun 22 16:33:53 2008] [error] [client 172.16.0.7] Premature end
of script headers: gitweb.css, referer:
http://kites/cgi-bin/gitweb/gitweb.cgi
[Sun Jun 22 16:33:53 2008] [error] [client 172.16.0.7] (8)Exec format
error: exec of '/var/www/cgi-bin/gitweb/git-logo.png' failed, referer:
http://kites/cgi-bin/gitweb/gitweb.cgi
[Sun Jun 22 16:33:53 2008] [error] [client 172.16.0.7] Premature end
of script headers: git-logo.png, referer:
http://kites/cgi-bin/gitweb/gitweb.cgi

Thanks,
Erez
