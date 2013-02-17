From: Thibault Kruse <tibokruse@googlemail.com>
Subject: Fwd: git clone combined with --depth, --branch and --single-branch
Date: Sun, 17 Feb 2013 20:10:37 +0100
Message-ID: <CAByu6UV+M76tcHPR4NqotiU=Fag-=sQFxyTOu3evhw+nRxQGhA@mail.gmail.com>
References: <CAByu6UWNZLrtwo+FUeq2OELoX3jo1Qng9amko36JGa5pq+y11A@mail.gmail.com>
	<CACsJy8C5G7yy=KDtdsE-9aYTdSEO3v=-25WKtGnLALshXnE+uQ@mail.gmail.com>
	<CAByu6UWw-6ssEug-Fm1t7_L2jVuC-KMh-NC=kzxfum=r6X5VcQ@mail.gmail.com>
	<CAByu6UVR7k-d8PkqhHBG-A1zTCETemjhch0OA7i6_56yBV_YyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 20:11:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U79de-0005G9-Kp
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 20:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab3BQTKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 14:10:39 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:34990 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab3BQTKi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 14:10:38 -0500
Received: by mail-oa0-f48.google.com with SMTP id j1so5220813oag.21
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 11:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=nGDFOrfgtvSqQfVxcCp/L9h7QLa4h4DkOJb7qUVD3cc=;
        b=p4y7PJicEsh4/a1ClBBBk9tfOONE9U1JyaAtQl1WsW4vNzeWxpKhjkdP6XDuCI1m+E
         XdiIeRoNi8MMk/A4nE9qCiV+dAIC2U3ts9d/h/ogTHEvF6OpVQolr3fXWhvON4BkJ/DJ
         6N0gGS1vkICtAX9Rr/Ougmy/VQvow3eziXsz3z2KpBQF1sO3DYkEiJVP4f0NpBaUmSmm
         BJI98rKDQQIGzdgqmO0mYsJ696NLiPnpKpcIAAvu+yMrSh6vvcpt7h4i8eDlzbP/bXSg
         jc5kcCIp51H0JVmoz3yelHs7waUt8cUKmKe6VGISp+9FjGQGJ3TlUE4gvWV6W0Jkq8Zw
         /2LA==
X-Received: by 10.182.159.98 with SMTP id xb2mr5190311obb.35.1361128237713;
 Sun, 17 Feb 2013 11:10:37 -0800 (PST)
Received: by 10.182.251.165 with HTTP; Sun, 17 Feb 2013 11:10:37 -0800 (PST)
In-Reply-To: <CAByu6UVR7k-d8PkqhHBG-A1zTCETemjhch0OA7i6_56yBV_YyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216402>

Actually, using git 1.8.3, I get:

git clone repo1 repo2 --depth 1
warning: --depth is ignored in local clones; use file:// instead.
...

So I guess the warning says it all, it helps to read it.
