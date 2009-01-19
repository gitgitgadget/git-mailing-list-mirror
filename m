From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: parent-filter loses my merged branch -- what am I doing wrong?
Date: Mon, 19 Jan 2009 09:41:27 +0100
Message-ID: <49743CB7.4030300@viscovery.net>
References: <7578B9A6-BF81-4096-B0FD-F433AD62A41E@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 09:43:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOpj5-00005g-1T
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 09:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640AbZASIlf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 03:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754700AbZASIlf
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 03:41:35 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:23524 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbZASIle convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 03:41:34 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LOphL-0005Fq-Qz; Mon, 19 Jan 2009 09:41:32 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 91F3A6D9; Mon, 19 Jan 2009 09:41:31 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7578B9A6-BF81-4096-B0FD-F433AD62A41E@develooper.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106334>

Ask Bj=F8rn Hansen schrieb:
> On Sam Villain's recommendation I'm spending a bit of time cleaning u=
p
> the branches and merges with git filter-branch, but I don't think I'm
> quite understanding how it's supposed to work.

Don't use --parent-filter for this; use grafts. You can see the history=
 in
gitk right away. Later run filter-branch without a filter (except perha=
ps
the tag-name-filter).

-- Hannes
