From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Documentation: avoid dangling modifier for imap-send
Date: Mon, 4 Aug 2014 19:51:08 -0700
Message-ID: <20140805025108.GW12427@google.com>
References: <xmqq8un4rtv6.fsf@gitster.dls.corp.google.com>
 <1407201189-12787-1-git-send-email-sandals@crustytoothpaste.net>
 <20140805024535.GV12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Aug 05 04:51:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEUqO-0001Vi-F4
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 04:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbaHECvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 22:51:14 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:52999 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbaHECvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 22:51:12 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so465293pab.26
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 19:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rJbSXzTs7KtiPcH/p07uPhOndmUnx/yl8MdNDjvE9Iw=;
        b=H5D/O/SInUC81mHaL7zJ64RuE2IHdlI7UzRxUPsmKEbp1liDc5cZYykl9odAe6mSii
         nU6QyWSsVuYuY6LbTOS/QY5QhcWpcMWtz0CT1W+uopdFkNYzfK0w812NXx4eODLQAROZ
         YhYDiOO1HueE804HGDdDgGmOfEHDSo9AghFdaMmg95ebgEKM8ATcwmGvKgQyGvTF8v3X
         krgwqTleC2BfziKTvdzVzc7mJfFr8Y1HZHWKeThll4vK3b/bikKB3VdQ6drjoiz9g74q
         OU8pM8q+kPS9bw1kmku3xdve7RgfiBqujw0hpVzR2oy+CGMmIbIVxhnd4QysPXaDVn+3
         V09Q==
X-Received: by 10.68.105.197 with SMTP id go5mr786575pbb.73.1407207072224;
        Mon, 04 Aug 2014 19:51:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:921:be1f:9e2d:3c59])
        by mx.google.com with ESMTPSA id ez9sm456277pdb.92.2014.08.04.19.51.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 19:51:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140805024535.GV12427@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254798>

Jonathan Nieder wrote:

> Should the neighboring instances of '[Rr]equired to use imap-send
> be changed to plain "Required", too?  (I suspect yes.)

Here's what that would look like.

-- >8 --
From: brian m. carlson <sandals@crustytoothpaste.net>
Subject: imap-send doc: omit confusing "to use imap-send" modifier

It wouldn't make sense for these configuration variables to be
required for Git in general to function.  'Required' in this context
means required for git imap-send to work.

Noticed while trying to figure out what the sentence describing
imap.tunnel meant.

[jn: expanded to also simplify explanation of imap.folder and
 imap.host in the same way]

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-imap-send.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 875d283..d3b465d 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -38,17 +38,17 @@ Variables
 imap.folder::
 	The folder to drop the mails into, which is typically the Drafts
 	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
-	"[Gmail]/Drafts". Required to use imap-send.
+	"[Gmail]/Drafts". Required.
 
 imap.tunnel::
 	Command used to setup a tunnel to the IMAP server through which
 	commands will be piped instead of using a direct network connection
-	to the server. Required when imap.host is not set to use imap-send.
+	to the server. Required when imap.host is not set.
 
 imap.host::
 	A URL identifying the server. Use a `imap://` prefix for non-secure
 	connections and a `imaps://` prefix for secure connections.
-	Ignored when imap.tunnel is set, but required to use imap-send
+	Ignored when imap.tunnel is set, but required.
 	otherwise.
 
 imap.user::
-- 
