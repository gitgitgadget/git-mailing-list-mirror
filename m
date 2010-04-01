From: Tim Visher <tim.visher@gmail.com>
Subject: Problems Fetching from HTTP?
Date: Thu, 1 Apr 2010 11:03:20 -0400
Message-ID: <v2xc115fd3c1004010803g98a279e8mf395a0d14be4f6bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 01 17:03:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxLvy-0001mg-VA
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 17:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab0DAPDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 11:03:46 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44530 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813Ab0DAPDo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 11:03:44 -0400
Received: by gwaa18 with SMTP id a18so892097gwa.19
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=8ModXGZTWthydSvhv0WKsa37Dn1/tfUxNluReP8ufis=;
        b=JkHSQSlAGD8ZLCITjf8P6+eNEaa2W2P+pOCfVpxDbZmAt6qO0GlPXj0EJ/OqAh2sF9
         CktpCZDYteRtDRk8JBh9uYUhtmKv4cZY7sRiId3tfudEzsx3tHwVgjqKejDjT1IN4R8w
         79qbFT8aK2X+KS/PfpLTTyiHGQnEeu54h/9jg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=QijiLiR3szbVYgsQaL3aPhvcDGkFyAkVmCAQWjJJP23LofXB+6karECsb7YG1C92ny
         ymJJMmCF89dgaX+zKn5QRHW5WfKHLAckGpniLxdz9tM2yaIC/Iu3IkGtP9LlXTMnIHl3
         rPeiwLCyJKw9oi+yTbsSVLHRuWNfflUun/fdw=
Received: by 10.100.209.20 with HTTP; Thu, 1 Apr 2010 08:03:20 -0700 (PDT)
Received: by 10.100.24.39 with SMTP id 39mr2965065anx.20.1270134220332; Thu, 
	01 Apr 2010 08:03:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143731>

Hello Everyone,

I recently seem to have developed problems fetching from
http://www.kernel.org/pub/scm/git/git.git.  The error is simply:

    error: Failed connect to www.kernel.org:80; Connection refused
while accessing http://www.kernel.org/pub/scm/git/git.git/info/refs

    fatal: HTTP request failed

I looked around and discovered that perhaps the URL had changed via
[git.kernel.org][] so I went ahead and changed the URL and still get
the error.

    error: Failed connect to git.kernel.org:80; Connection refused
while accessing http://git.kernel.org/pub/scm/git/git.git/info/refs

    fatal: HTTP request failed

What could be going on here?  I can't pull from `git://` as I'm behind
a firewall.

Thanks in advance!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
