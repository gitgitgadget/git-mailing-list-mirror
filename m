From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: Watchman support for git
Date: Fri, 02 May 2014 18:20:02 -0500
Message-ID: <536428224adfb_200c12912f010@nysa.notmuch>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: dturner@twopensource.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 01:30:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgMuj-0000oJ-Ho
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 01:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbaEBXam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 19:30:42 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:43520 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbaEBXal (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 19:30:41 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so5991322obb.40
        for <git@vger.kernel.org>; Fri, 02 May 2014 16:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=PFVVJwFZgSmIjLKbXsbuCKGgmr0d5iywSwXWtTmXo0Y=;
        b=FzsDTwZ2djpzf12nehLGFbo3pbJcVVZOLVg28TlgXPpK+1zLKgdPWN9XM/baxDpwO/
         MTcGA6EOU+CTzKSZWVG5FWeGDaGyA/we4E+ez7/6O6h4QUYZxehvxj7d1c7wUbbxgHa4
         KIOYdJdiIBsKa+r3woEOc9fxPa1xiM+NdnWxhHZIMHxhY+Cc5oHnTycjmXowmf+DTguG
         DF6qRm7XK04QkItkerHQF9jflmbdY7fNM6zzK3sd+uTI3kjWpAQJ8Y33aI8napErcqs4
         64o9bHJhqH1y8t93n9M6SnzgPxe2HLkYSW+PbS2JclD5A71CgoFA9A17sC3sYSjn84t8
         mNCA==
X-Received: by 10.182.33.73 with SMTP id p9mr17813645obi.37.1399073441032;
        Fri, 02 May 2014 16:30:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cn1sm1912253oeb.11.2014.05.02.16.30.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 16:30:40 -0700 (PDT)
In-Reply-To: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248007>

dturner@ wrote:
> Test repository 1: Linux
> 
> Linux is about 45k files in 3k directories.  The average length of a
> filename is about 32 bytes.
> 
> Git status timing:
> no watchman: 125ms
> watchman: 90ms

That's very interesting. Do you get similar improvements when doing
something similar in Merurial (watchman vs . no watchman).

-- 
Felipe Contreras
