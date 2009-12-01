From: Jochen <rick23@gmx.net>
Subject: Re: Umlaut in filename makes troubles
Date: Tue, 01 Dec 2009 10:58:10 +0100
Message-ID: <hf2pbp$rss$1@ger.gmane.org>
References: <200912010815.14515.rick23@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 10:58:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFPVX-0001be-01
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 10:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbZLAJ6m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 04:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753841AbZLAJ6m
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 04:58:42 -0500
Received: from lo.gmane.org ([80.91.229.12]:45154 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837AbZLAJ6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 04:58:41 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NFPVP-0001a4-A2
	for git@vger.kernel.org; Tue, 01 Dec 2009 10:58:47 +0100
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 10:58:47 +0100
Received: from rick23 by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 10:58:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: rain.gmane.org
User-Agent: KNode/0.99.01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134191>

I found another strange effect...

I made a file with "touch a=C3=B6=C3=A4=C3=BC.txt" and from "git status=
" I get=20
#       "a\303\266\303\244\303\274.txt"
reported as untracked. But when I start "git gui" I get file displayed =
with=20
it's correct name...
