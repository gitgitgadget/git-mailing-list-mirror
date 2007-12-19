From: Thomas Harning <harningt@gmail.com>
Subject: Git-to-svn convert
Date: Wed, 19 Dec 2007 17:14:25 -0500
Message-ID: <476997C1.2080506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:17:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J57E8-00012r-1b
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 23:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbXLSWQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 17:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753758AbXLSWQ5
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 17:16:57 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:54744 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbXLSWQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 17:16:56 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2792930rvb.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 14:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=Z17Z6VVJVq3oYKz9wi9b90zNVjGblpoG7Z+PMbEX334=;
        b=EZy39aNP0ilAzibTtzIawJdXgqvvtfRTeAl1/YeWzf1EfXoAWou5pPkKaMMGbOkasi0F0rfgRWDW3qhE4CDsF3rteXj02deJKaLvej6QssFOYCmEY2+qfe9SFGFXR6EpgV9ot3Gz2sjnNwZOKBnik2dpjNQm+CrSNs7ejBiKSvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=vC3JWHbONzrWY58Qu+OOAA/Cj3kzQFdZTlMuks+kWWLiuOVTBtyEpqXdAq/7yaPFPDFvbthOMRhapGrz7wibVXeC4ItjMGh+TZiJ8MKjUihtpIyeMAQTVi3nLQg+SNh9OvJb4hrCTUp6DkwE1sN8w32rXdxLfcznhucLLamufS4=
Received: by 10.141.122.20 with SMTP id z20mr3588717rvm.160.1198102615998;
        Wed, 19 Dec 2007 14:16:55 -0800 (PST)
Received: from ?192.168.24.40? ( [149.164.193.61])
        by mx.google.com with ESMTPS id g34sm18281369rob.2007.12.19.14.16.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Dec 2007 14:16:55 -0800 (PST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070716)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68944>

Is there a reasonable way to convert a Git project to Subversion...
Yeah, I know, blasphemy :-P... but I worked on a project in Git and my 
boss wants me to put it into Subversion.

git-svn looks to be the tool for this.. however I had some non-linear 
dev, which doesn't look like it'd commit (In the past I think I tried 
this and it failed to deal w/ a branch-and-merge...).

Example of what I mean...:

a - b -
 `c'


As to how to pull the repository into subversion.. how would I do that?
git-svn init ?
