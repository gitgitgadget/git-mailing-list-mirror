From: jidanni@jidanni.org
Subject: just can't live without a user.name
Date: Sat, 20 Dec 2008 07:20:56 +0800
Message-ID: <87fxkjbvl3.fsf_-_@jidanni.org>
References: <20081219223306.GH21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nanako3@lavabit.com, gitster@pobox.com, git@vger.kernel.org
To: vmiklos@frugalware.org
X-From: git-owner@vger.kernel.org Sat Dec 20 00:22:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDofj-0003LU-SM
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 00:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbYLSXVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 18:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbYLSXVA
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 18:21:00 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:48560 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751515AbYLSXU7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2008 18:20:59 -0500
Received: from jidanni.org (122-127-33-249.dynamic.hinet.net [122.127.33.249])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id B090E119DE8;
	Fri, 19 Dec 2008 15:20:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103599>

Actually it's all git's fault for not working if user.name is null or
unset. Ask yourself, would email programs panic if all there was only
bob@example.org in a header?
> But we need a user.name for legal reasons.
But there should be a way to override it, in case those laws don't apply.
I want
  Author: jidanni@jidanni.org
like my email address above. But the closest I can get is
  Author: jidanni <jidanni@jidanni.org>
And then there are some programs that need
$ git config --global user.name $USER
just to get that, else the springs come loose:
$ git-format-patch -s
*** Please tell me who you are.
Run
  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"
to set your account's default identity.
Omit --global to set the identity only in this repository.
fatal: empty ident  <jidanni@jidanni.org
> not allowed
