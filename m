From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH 0/3] Unconfuse git clone when two branches at are HEAD.
Date: Mon, 9 Sep 2013 18:08:17 +0200
Message-ID: <20130909160817.GN12966@inner.h.apk.li>
References: <20130906155204.GE12966@inner.h.apk.li> <6649DD0E3B6B4CE59D330217786B6B05@PhilipOakley> <xmqqfvthyfui.fsf@gitster.dls.corp.google.com> <94A71512041A4F9BB402474DB385E310@PhilipOakley> <xmqqwqmsvdfh.fsf@gitster.dls.corp.google.com> <531DBE1FF66D4356AEE6AEE5C2FE9389@PhilipOakley> <xmqqk3ir6wu3.fsf@gitster.dls.corp.google.com> <5425F66B510F423EA685BCEF40EF8FA7@PhilipOakley> <xmqqr4cy5a2z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 18:09:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ426-00080X-Q7
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 18:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183Ab3IIQJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 12:09:42 -0400
Received: from continuum.iocl.org ([217.140.74.2]:54327 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755283Ab3IIQJk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 12:09:40 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r89G8Id14296;
	Mon, 9 Sep 2013 18:08:18 +0200
Content-Disposition: inline
In-Reply-To: <xmqqr4cy5a2z.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234349>

On Mon, 09 Sep 2013 07:44:04 +0000, Junio C Hamano wrote:
...
> I'd rather not go this route.  Allowing refs/heads/master and local
> branches that forked from it in refs/heads/master/{a,b,c,...} could
> be a potentially useful future enhancement,

Want! We're currently going the route of naming the branches

  master
  feature/master
  feature/subfeature/master

to allow feature/subfeature/topic, and feature/subfeature in the first place.

(Other hierarchy separator candidates were ugly, shell-unwieldy, already
commonly used within branch names, or illegal.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
