From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation/fast-import: capitalize beginning of sentence
Date: Sat, 15 Jan 2011 20:16:05 -0600
Message-ID: <20110116021605.GA28307@burratino>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-2-git-send-email-david.barr@cordelta.com>
 <20101128194131.GA19998@burratino>
 <20101128194501.GD19998@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sun Jan 16 03:16:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeIAQ-0001au-22
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 03:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab1APCQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 21:16:19 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60426 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab1APCQS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 21:16:18 -0500
Received: by gyb11 with SMTP id 11so1573510gyb.19
        for <git@vger.kernel.org>; Sat, 15 Jan 2011 18:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+j1p5YcEEkEWymIMatjH9TbPntJWbLbaDZGeOVxEVn8=;
        b=quBs5KO1npnp2DinxJACkyzDbzxjv+5Sfm9utrtgU3PDDUWle9eC1dfZBXoiErN+xF
         QlyB//ijDSyxIkhd0LYw+UQoXF5cSCvv4+PH+7/UqPoTSfeyeEIqtvY6/K4RfoztpzhO
         RFRVCPGk/XjnMUKrrInDP0qIQFveEbYo3t8f0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WoMHaIUmVHYOMXY8x3gvQV61711WVEt1r2w+B3n/MmwiFtGcbplHVWqeiZo+iwfznC
         nrWTNGk2eDTo8JeXBn4SDp44PT0Zqe7052kctuhjfbNL+Q7lzaR7aM94Ms5zsHEpV5Jk
         WHGqkqs71cxW6x8MbVTLQmWm+Lzw1xXGLY3Os=
Received: by 10.236.109.141 with SMTP id s13mr5247756yhg.16.1295144178013;
        Sat, 15 Jan 2011 18:16:18 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id 62sm1444946yhl.24.2011.01.15.18.16.13
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 Jan 2011 18:16:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101128194501.GD19998@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165154>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Noticed by skimming through the v1.7.3..v1.7.4-rc2 diff.

 Documentation/git-fast-import.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index e2a46a5..43d2174 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -905,7 +905,7 @@ The `<dataref>` can be either a mark reference (`:<idnum>`)
 set previously or a full 40-byte SHA-1 of a Git blob, preexisting or
 ready to be written.
 
-output uses the same format as `git cat-file --batch`:
+Output uses the same format as `git cat-file --batch`:
 
 ====
 	<sha1> SP 'blob' SP <size> LF
-- 
1.7.4.rc2
