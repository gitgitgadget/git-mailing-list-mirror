From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git push tags
Date: Mon, 29 Oct 2012 08:13:36 +0100
Message-ID: <CAB9Jk9BmMMDLsY=kU5o-c4XF6fN3O44h_vXe3d=WF-W9HTBh_g@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<508D7628.10509@kdbg.org>
	<CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
	<4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Rorvick <chris@rorvick.com>, Johannes Sixt <j6t@kdbg.org>,
	git <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 08:13:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSjXi-0001MB-Ee
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 08:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab2J2HNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 03:13:38 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50827 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab2J2HNh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 03:13:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4065826pbb.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 00:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HKzcktnoytv0flPZkcp3q54xLh5oIxA6ekSUu1uQHXo=;
        b=0wCqxfZrKEWsMQJ9kGEfM9fthmiwDS5QroTm/TTEsvPc8toVqWHdnfd5ViXaTTaNrM
         pOHrlqYnm0enpm5wxochyLbUhJgnO8o1YfVCF0X/NSE6ghcX6AKQ/SODIR8TBvNMKLHn
         kiW0YMhe9ZjsluTY1uyb/o7kIKShb0KPTPJfRmY4rAFMVUBNXLoP9OH+Qm/Hs4nJpXcY
         c7TwnU7mWQpJ7wF428IexmlBtb4M7mkkEEB+vDtsBc9B1Gau7HPluOLyUqRc+mpu6T3A
         ByhMxW3RsYu89kb67LDI92BpTVJC1i3E72X1DlYZckSuInWL9VaFuaQ6SmNQ/Kwsgyb0
         GWeg==
Received: by 10.66.88.4 with SMTP id bc4mr80847219pab.42.1351494816803; Mon,
 29 Oct 2012 00:13:36 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Mon, 29 Oct 2012 00:13:36 -0700 (PDT)
In-Reply-To: <4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208598>

Hi,

Pro Git, By Scott Chacon says:

2.6

   "Like most VCSs, Git has the ability to tag specific points in
history as being important.
Generally, people use this functionality to mark release points (v1.0,
and so on)."

2.6.2:

   "A [lightweight] tag is very much like a branch that does not change ..."

Clearly, tags are not the same as branches. They are there for a
different purpose. If they were exactly the same as branches, there
would be no need for them.
Of course, they share some behaviors with branches, and there are
several commands that handle them in the same way, but the key point
is that they do not change, or at least they do not do that by
default. The ability to force changes of tags is there only to correct
tags that might have set tags to the wrong points by mistake.
So, what I am telling is that this property must be preserved
consistently across all commands, including git-push.

-Angelo
