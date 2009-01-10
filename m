From: jidanni@jidanni.org
Subject: Re: fetch branch blacklist
Date: Sat, 10 Jan 2009 10:30:24 +0800
Message-ID: <873afr6gfz.fsf@jidanni.org>
References: <m3wsd41b7q.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 10 03:31:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLTdg-0001Xm-Pz
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 03:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbZAJCa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 21:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbZAJCa2
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 21:30:28 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:52732 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751334AbZAJCa2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jan 2009 21:30:28 -0500
Received: from jidanni.org (122-127-34-138.dynamic.hinet.net [122.127.34.138])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a5.g.dreamhost.com (Postfix) with ESMTP id 5F5F39C4E6;
	Fri,  9 Jan 2009 18:30:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105069>

If anybody is going to implement this, then the order of the two lines
fetch=+refs/heads/*:refs/remotes/origin/*
fetch=!refs/heads/man
should probably matter...
