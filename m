From: jidanni@jidanni.org
Subject: commit.template
Date: Sat, 27 Dec 2008 06:42:09 +0800
Message-ID: <87tz8qsgn2.fsf_-_@jidanni.org>
References: <20081227070232.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: nanako3@lavabit.com
X-From: git-owner@vger.kernel.org Fri Dec 26 23:43:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGLP6-0004Al-5Z
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 23:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbYLZWmN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Dec 2008 17:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbYLZWmN
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 17:42:13 -0500
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:45731 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751895AbYLZWmN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Dec 2008 17:42:13 -0500
Received: from jidanni.org (122-127-32-218.dynamic.hinet.net [122.127.32.218])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 4163E414BD;
	Fri, 26 Dec 2008 14:42:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103958>

NS> Didn't you mean "Signed-off-by: =E7=A9=8D=E4=B8=B9=E5=B0=BC <jidann=
i@jidanni.org>"?

No. I want in fact just to use "Signed-off-by: jidanni@jidanni.org",
but apparently
1) man git-config mentions
       commit.template
           Specify a file to use as the template for new commit message=
s.

but doesn't mention what file is being used presently, so one can know
what to adjust.

2) .git/hooks/commit-msg etc. don't seem to control that line.
3) Making a line without a name would probably break other things.
