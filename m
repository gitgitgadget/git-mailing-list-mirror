From: James Cloos <cloos@jhcloos.com>
Subject: keeping remote repo checked out?
Date: Mon, 28 Nov 2005 02:13:31 -0500
Message-ID: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 28 08:29:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgdEI-0000bO-RE
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 08:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVK1HPB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 02:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVK1HPB
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 02:15:01 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:10002 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S932107AbVK1HPA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 02:15:00 -0500
Received: from lugabout.jhcloos.org (host-69-48-15-9.roc.choiceone.net [69.48.15.9])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lugabout.jhcloos.org", Issuer "ca.jhcloos.com" (verified OK))
	by ore.jhcloos.com (Postfix) with ESMTP id B2D271C2EF
	for <git@vger.kernel.org>; Mon, 28 Nov 2005 01:14:48 -0600 (CST)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id C0D7C210C42; Mon, 28 Nov 2005 07:13:31 +0000 (GMT)
To: git@vger.kernel.org
Copyright: Copyright 2005 James Cloos
X-Hashcash: 1:23:051128:git@vger.kernel.org::zU9xjWcePyODjvrw:000000000000000000000000000000000000000000J9JM
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12855>

I am testing git as a replacement for how I was using bk to manage web
sites.  As such, I created a new git repo on the server, populated it
with the old data (ignoring history; there wasn't much relevant on
that site) and cloned that to the laptop.

Editing on the server works well.  I can add, checking and a
subsequent pull on the laptop grabs the changes.

But any edits on the laptop's copy are not checked out when I push
them to the server.

Is it possible to arrange that a push does a checkout on the remote
the same way a pull does on the local?

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com>
