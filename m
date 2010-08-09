From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] Documentation: add a FILES section for show-ref
Date: Sun, 8 Aug 2010 20:32:43 -0500
Message-ID: <20100809013243.GA9385@burratino>
References: <AANLkTi=J3tDnZUg3k5bzDk2ydzYVVLKLwoW0gpBypYAs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 03:34:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiHFv-0005KM-Sd
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 03:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132Ab0HIBeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 21:34:19 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51067 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab0HIBeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 21:34:19 -0400
Received: by yxg6 with SMTP id 6so3270716yxg.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 18:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=O1xaSOc3CWNceuHwssbbyQBeKBsPoxcPutUMqk/ffVM=;
        b=PTB12Qja1h2SNIAAJWWObZIl4QPRnBkSMBWRk4+aoW1Ks4etIeFqJy0aGtBiRSq/Ru
         Q8GFVs2X9JP0FLf2/YAO9N+x/0jSg6MHGvgdv6vjOtn8EHv14CXlJI3xc8n/WQO0zzUp
         12kVRsEyCVLaC9oEI8gAQU6qfFsL1LIfwTh+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SkU+HKNF0/jKyJ4yFNG9dwWauV+1BsI05ji+lgbqGaHkv/uc0eu3L9tPUXSF0tJTJD
         1LExo9GVKy6LJIR+airdm2PuMNZBU/dYXVJ7cw7nG7U63jgMJJYn17khZPLpQ+lmuKwR
         hncMdNbxBnRffjwCYUlqoK2RhOF+7GUUcgdK8=
Received: by 10.100.191.20 with SMTP id o20mr17070140anf.18.1281317658417;
        Sun, 08 Aug 2010 18:34:18 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id t30sm7419677ann.27.2010.08.08.18.34.14
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 18:34:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=J3tDnZUg3k5bzDk2ydzYVVLKLwoW0gpBypYAs@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152943>

A peek at where the refs are kept might help understanding, even if,
as the DESCRIPTION section suggests, direct access is not part of the
public API.

Balance that out with a pointer to update-ref.

Suggested-by: Geoff Russell <geoffrey.russell@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-show-ref.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 3f9d9c6..3fe961d 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -163,9 +163,15 @@ flag, so you can do
 
 to get a listing of all tags together with what they dereference.
 
+FILES
+-----
+`.git/refs/*`, `.git/packed-refs`
+
 SEE ALSO
 --------
-linkgit:git-ls-remote[1]
+linkgit:git-ls-remote[1],
+linkgit:git-update-ref[1],
+linkgit:gitrepository-layout[5]
 
 AUTHORS
 -------
-- 
1.7.2.1.544.ga752d.dirty
