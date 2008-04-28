From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: reflog/show question
Date: Mon, 28 Apr 2008 11:29:17 +0930
Message-ID: <93c3eada0804271859p1b4d8b52i811bdc5e42672822@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 04:00:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqIf2-00076h-1q
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 04:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbYD1B7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 21:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354AbYD1B7U
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 21:59:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:39600 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbYD1B7T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 21:59:19 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4732074fgb.17
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 18:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=qHVkJB6BlFWarn6P0C7KjssbeO2oz/ozytUDgNYASXQ=;
        b=G2KOLBdeRydSJXv6AtoCNINkPUHqzBv3GrvrSQqolrj4OGiwObyns4yG/x3m//xOVw2wqisSJ6NscgzHHzY9XO/61u+8JC2v1i0xfH2P103EzZruxKz7fvxxcoGlwFBF6oQU9hRmD42reUKIFfcstOI5FJz8vZrvxN+lLKRhQZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jmUG7aafsu0lkRWuvxZ4X7nxa1wSJi9itc3lZ0FHbJsApSI8O9q1nw0DMP7E94UFiBY6PvNC5WkiB8F/2EAx8KK4dXeDCOFJ44LubtF8MeYRjhoOJGY1cU6UiKc3cNXXohX2jt5pfzWY+loigdFPUxwds8e7LXaoOctODKmarjE=
Received: by 10.82.151.9 with SMTP id y9mr3431019bud.8.1209347957685;
        Sun, 27 Apr 2008 18:59:17 -0700 (PDT)
Received: by 10.82.105.8 with HTTP; Sun, 27 Apr 2008 18:59:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80497>

     git show HEAD@{"3 minutes ago"}

works as I expect, but

     git show HEAD@{"3 minutes ago"}:data/node/node.data

gives me a message:

       warning: Log for 'HEAD' only goes back to Mon, 28 Apr 2008
10:18:37 +0930.
       fatal: ambiguous argument
'HEAD@{3.minutes.ago}:data/node/node.newds1': unknown revision or path
not in the working tree.
       Use '--' to separate paths from revisions

However,

     git show HEAD@{2}:data/node/node.data

shows me the file as it was 3 minutes ago.

I'm using 1.5.4.rc4

Cheers,

Geoff Russell
