From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 0/4] Documentation update (mainly for apply)
Date: Sun, 22 Nov 2009 20:35:32 +0100
Message-ID: <4B099284.7090603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 20:35:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCIDt-0003Tw-EP
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 20:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065AbZKVTfc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 14:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbZKVTfc
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 14:35:32 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:49252 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbZKVTf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 14:35:29 -0500
Received: by ewy19 with SMTP id 19so1200966ewy.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 11:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=1YOGKB1CyVgMo3VRqafXqI3kGfMr7iDj9DMv8/rlJVk=;
        b=YanrzuLMgXF5kmjlxtOzqZ1Fr1+j3Ko7qzx/eyMitENU6QY6kKBCAWYtI7XhbX8qOX
         nDZQ7YUla/pbOuYLR2FXvl7Q9EWw1MWYQ8kf15OhZSnlz9UyI6d+ZDSpvERqxLKJRo9P
         g08khZq9LbvXbnEe/aoTz6IKsOG9xuqE7NQOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=qw28+IdH2wucRZJzBnsx9wLKBRThbImgFs0OXhcHcEmjJO2/3BRzTH4o/ZQCFFKIdN
         tR4BCsMgs6kumB2HTwHpLdoerzLOaKIf2xGsrQhzBZmfRPM+BIcNy2qRtbWDcygKZ9/y
         ayvew0OU0em/wdXu5CLNTCDAn+qKSsZR/D/Y4=
Received: by 10.213.103.137 with SMTP id k9mr3925371ebo.0.1258918534148;
        Sun, 22 Nov 2009 11:35:34 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 5sm486899eyf.8.2009.11.22.11.35.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 11:35:33 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133450>

Here is my updated patch series based on Junio's feedback.

The first patch now also updates the description of -z
for the log and diff* commands.

The second patch has better wording based on Junio's
suggestion.

I have swapped patch 3 and 4 so that the "working tree"
patch comes last, to make it easier to replace or drop.

Bj=C3=B6rn Gustavsson (4):
  Clarify and correct -z
  apply: apply works outside a repository
  apply: Format all options using back-quotes
  apply: Use the term "working tree" consistently

 Documentation/diff-options.txt |   17 +++++++++++++--
 Documentation/git-apply.txt    |   41 ++++++++++++++++++++++----------=
-------
 2 files changed, 37 insertions(+), 21 deletions(-)
