From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/17] Documentation: remove stray backslash in show-branch
 discussion
Date: Fri, 20 Aug 2010 05:37:06 -0500
Message-ID: <20100820103706.GM10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:39:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOzy-0005kx-At
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623Ab0HTKiy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 06:38:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65189 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab0HTKiw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 06:38:52 -0400
Received: by iwn5 with SMTP id 5so690942iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8xCUzvnslV4H8OaiQwIHQYjwVvVR2h6FRO0jH6HSp/Y=;
        b=Ak3e1vcZxx43BFWxRIksCSP3+GszZmjZCWAxAHeNR7OL5k5tq7tx5+po5BYZgOOPWm
         WUE7lZko2cLCJ8uZMC9tfHepxrrx10J49btb4p4Fk8c/Cjqii3xC1W7E93+fdjSAWoty
         vGs0W8MMXxFupnfvd/TvLGz6OMsOCkYmwVczE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Mgx/oVxarRv4YJQ84HljwWfmXxcszTkdP6yC4a+/Gs4GM1/0vGvkBN5tLphtsRZ7rX
         ltvXC3Sx4JYVCDOGP3/Tr2iwsJSjuO2P34utsnqNBhtyA84aY5Z1uFcGmC2oCsrOS5+v
         Wbtkwch9qBv0u6wq0X0eQyF3maQijUdRQHz+8=
Received: by 10.231.173.9 with SMTP id n9mr1373388ibz.146.1282300732318;
        Fri, 20 Aug 2010 03:38:52 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id j2sm2505468iba.0.2010.08.20.03.38.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:38:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154008>

Because there is no unescaped apostrophe to pair it with, asciidoc
does not consider this apostrophe a candidate for escaping and
the backslash passes through.

Reported-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-show-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show=
-branch.txt
index 81ba296..01fc157 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -168,7 +168,7 @@ $ git show-branch master fixes mhf
 ------------------------------------------------
=20
 These three branches all forked from a common commit, [master],
-whose commit message is "Add \'git show-branch\'". The "fixes"
-branch adds one commit "Introduce "reset type" flag to "git reset"".
-The "mhf" branch adds many other commits. The current branch
-is "master".
+whose commit message is "Add {apostrophe}git show-branch{apostrophe}".
+The "fixes" branch adds one commit "Introduce "reset type" flag to
+"git reset"". The "mhf" branch adds many other commits.
+The current branch is "master".
--=20
1.7.2.2.536.g42dab.dirty
