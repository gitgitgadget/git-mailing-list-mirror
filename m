From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Documentation: avoid dangling modifier for imap-send
Date: Mon, 4 Aug 2014 19:57:21 -0700
Message-ID: <20140805025721.GX12427@google.com>
References: <xmqq8un4rtv6.fsf@gitster.dls.corp.google.com>
 <1407201189-12787-1-git-send-email-sandals@crustytoothpaste.net>
 <20140805024535.GV12427@google.com>
 <20140805025108.GW12427@google.com>
 <20140805025229.GB10435@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Aug 05 04:57:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEUwL-0001oM-Pw
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 04:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbaHEC50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 22:57:26 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33474 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbaHEC5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 22:57:25 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so448379pdj.26
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 19:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MvF+wGvjDV4kzkW+YKBetxT3jRvfNLRpIwXZYLvNsCM=;
        b=nBiFh4F5KlICE1g9sy+8jlkcj8VIvr6TTJGWJCsMgPLg4rNiI/Ea8xRyLDyxrpBGRP
         LTykodPXGcbo++VjLiTwEWBkL2QhmClkVlbvBnpbJTZ8THIKmKvtGhETqu9benutPSfG
         N8MYR29plGkJfRFf5orqclkY9HkfK6OOlUP4yXzNVKv2UPM/DhwVKrWmZq7sUgzIjrSF
         xlps1Kix2zK5tdA4HHc6ZTsLrW/EYQUJgbceFtuzN29CqTlLJN9KxZsGTrPdwd0P+MDs
         fXP0+/M4jCOXEeTd6zAGQUwZ4BFs+lmbNsNMI4QDPy+xMGhBz9ilCpAEIX3V9E4sUy3b
         N1Fw==
X-Received: by 10.68.135.42 with SMTP id pp10mr936873pbb.58.1407207445272;
        Mon, 04 Aug 2014 19:57:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:921:be1f:9e2d:3c59])
        by mx.google.com with ESMTPSA id l3sm290986pbq.8.2014.08.04.19.57.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 19:57:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140805025229.GB10435@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254801>

brian m. carlson wrote:

> This has an extra period at the end of the line.

Good catch.

-- >8 --
Subject: fixup! imap-send doc: omit confusing "to use imap-send" modifier
---
Thanks,
Jonathan

 Documentation/git-imap-send.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index d3b465d..eabcaf0 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -48,8 +48,7 @@ imap.tunnel::
 imap.host::
 	A URL identifying the server. Use a `imap://` prefix for non-secure
 	connections and a `imaps://` prefix for secure connections.
-	Ignored when imap.tunnel is set, but required.
-	otherwise.
+	Ignored when imap.tunnel is set, but required otherwise.
 
 imap.user::
 	The username to use when logging in to the server.
-- 
