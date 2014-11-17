From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Merge without marking conflicts in working tree
Date: Tue, 18 Nov 2014 00:20:29 +0100
Message-ID: <87sihhza6a.fsf@igel.home>
References: <20141117223836.GH615@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 00:20:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqVb9-0004rY-FR
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 00:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbaKQXUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 18:20:36 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:52482 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaKQXUd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 18:20:33 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3jhR8v2XtDz3hjMr
	for <git@vger.kernel.org>; Tue, 18 Nov 2014 00:20:31 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3jhR8v2Fyqzvh1j
	for <git@vger.kernel.org>; Tue, 18 Nov 2014 00:20:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id IM7eMtcuvw_w for <git@vger.kernel.org>;
	Tue, 18 Nov 2014 00:20:30 +0100 (CET)
X-Auth-Info: ueoZn5o4XkOk/+JjOK8HoDxJki6eBeGWzLoXLfqlqtScGkoFzQMeoM577VIDHmDd
Received: from igel.home (ppp-188-174-153-115.dynamic.mnet-online.de [188.174.153.115])
	by mail.mnet-online.de (Postfix) with ESMTPA
	for <git@vger.kernel.org>; Tue, 18 Nov 2014 00:20:30 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id D27E32C3959; Tue, 18 Nov 2014 00:20:29 +0100 (CET)
X-Yow: This PIZZA symbolizes my COMPLETE EMOTIONAL RECOVERY!!
In-Reply-To: <20141117223836.GH615@pug.qqx.org> (Aaron Schrab's message of
	"Mon, 17 Nov 2014 17:38:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Schrab <aaron@schrab.com> writes:

> Is there a way to do a merge but only record conflicts in the index, not
> update the working versions of files with conflict markers?
>
> Like many people, I use git to manage configuration files for my shell,
> editor, git itself, and a number of other things.  The vast majority of
> times that I update things no conflicts are occur and everything just
> works, so I'd like to avoid extra work in this case.  But occasionally a
> conflict will occur, and if it's in a file that will be read while trying
> to resolve the conflict this can make things more difficult.

You could perform the merge in a separate working directory.  The only
extra step required is a checkout to deploy the new revision, which
could be triggered automatically by a hook.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
