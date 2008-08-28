From: "Nathan Panike" <nathan.panike@gmail.com>
Subject: [PATCH 1/2] Document %as and %cs as a pretty format flag
Date: Thu, 28 Aug 2008 06:09:42 -0500
Message-ID: <d77df1110808280409k35eb0f83ta7d95847dfcd0620@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 13:11:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYfOx-00006A-9V
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 13:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYH1LJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 07:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbYH1LJr
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 07:09:47 -0400
Received: from ag-out-0708.google.com ([72.14.246.249]:63311 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbYH1LJr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 07:09:47 -0400
Received: by ag-out-0708.google.com with SMTP id 31so874303agc.10
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 04:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=i9ZU1HV/69EYTjMJtlaMoRu/Pimr0khbv28heAY3auM=;
        b=NeCdSdQ6Cdv5bVFFoGXj8QHfsrNaJ4EvT47gN3OXYhthWXBGiUX7tWiSIO5w8w6urx
         v7Deq5et22yPIOxr79leI/1oyFzKRcaqqZsPaJU+TXXQihaNH9oMGPKdyz5VjBCDQxes
         Iy+o8RELoBlTZhwT3pUyC+FKtGyadDBVcyfHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Z+X0pGiNOTW99FIcy5GsAKYOdS0Co/Q9DnPyVYduDX9Mv0gtfCAxNKuSbJFpCI20ot
         v6G2MY/iiNceWoIkMEKtdNwaWFb3w0fBYUs0w65eDVznm74ys+BdXDwsjCEh/C/Fnh8E
         SX92ip6Srh5t+2uNvD3HvadDUo0tokxdqjikY=
Received: by 10.67.116.8 with SMTP id t8mr3208778ugm.57.1219921782415;
        Thu, 28 Aug 2008 04:09:42 -0700 (PDT)
Received: by 10.66.234.6 with HTTP; Thu, 28 Aug 2008 04:09:42 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nathan W. Panike <nathan.panike@gmail.com>
---
 Documentation/pretty-formats.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index c11d495..2f98c5a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -108,6 +108,7 @@ The placeholders are:
 - '%ar': author date, relative
 - '%at': author date, UNIX timestamp
 - '%ai': author date, ISO 8601 format
+- '%as': author date, short format
 - '%cn': committer name
 - '%cN': committer name (respecting .mailmap)
 - '%ce': committer email
@@ -116,6 +117,7 @@ The placeholders are:
 - '%cr': committer date, relative
 - '%ct': committer date, UNIX timestamp
 - '%ci': committer date, ISO 8601 format
+- '%cs': committer date, short format
 - '%e': encoding
 - '%s': subject
 - '%b': body
-- 
1.6.0.1
