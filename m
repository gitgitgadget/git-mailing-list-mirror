From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: Re: git log --no-walk --tags produces strange result for certain user
Date: Mon, 16 Dec 2013 15:52:35 +0400
Message-ID: <AEF2BC21-6EE1-479F-BC63-7A5B95406A7F@jetbrains.com>
References: <5EE449B7-AB75-4EFF-85F9-292727FA1C53@jetbrains.com> <01D3F259-94E1-4084-9210-34E2DB7B7545@jetbrains.com> <52AEB181.9020006@alum.mit.edu>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 16 12:52:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsWiz-0005Nu-8i
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 12:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab3LPLwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 06:52:33 -0500
Received: from mail1.intellij.net ([46.137.178.215]:45029 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab3LPLwd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Dec 2013 06:52:33 -0500
Received: (qmail 29450 invoked by uid 89); 16 Dec 2013 11:52:31 -0000
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@81.3.129.2)
  by ip-10-62-119-91.eu-west-1.compute.internal with ESMTPA; 16 Dec 2013 11:52:31 -0000
In-Reply-To: <52AEB181.9020006@alum.mit.edu>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239333>


Hi everybody,

I received one more complaint for this issue, and now it appears in a public repository https://github.com/spray/spray 

To reproduce:

# git clone https://github.com/spray/spray 
# cd spray
# git log --no-walk --tags --pretty="%H %d" --decorate=full | tail -3
3273edafcd9f9701d62e061c5257c0a09e2e1fb7  (tag: refs/tags/v0.8.0-RC1)
ff3a2946bc54da76ddb47e82c81419cc7ae3db6b  (tag: refs/tags/v0.7.0)
8b4043428b90b7f45b7241b3c2c032cf785479ce 

So here the last hash doesn't have a decoration.

Thanks for any help.
Kirill. 
