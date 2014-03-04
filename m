From: Alexander Holler <holler@ahsoftware.de>
Subject: Confgure option like tagopt=note to notice changed remote tags
Date: Tue, 04 Mar 2014 16:42:54 +0100
Message-ID: <5315F47E.3040801@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 16:43:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKrUq-0003Z5-EX
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 16:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbaCDPnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 10:43:03 -0500
Received: from h1446028.stratoserver.net ([85.214.92.142]:48610 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbaCDPnC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 10:43:02 -0500
Received: by mail.ahsoftware.de (Postfix, from userid 65534)
	id 90DE6423C2C6; Tue,  4 Mar 2014 16:43:00 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mail.ahsoftware.de
X-Spam-Level: 
X-Spam-Status: No, score=-98.7 required=5.0 tests=RDNS_NONE,USER_IN_WHITELIST
	autolearn=disabled version=3.3.1
Received: from eiche.ahsoftware (p57B21C17.dip0.t-ipconnect.de [87.178.28.23])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id C9E86423C298
	for <git@vger.kernel.org>; Tue,  4 Mar 2014 16:42:59 +0100 (CET)
Received: by eiche.ahsoftware (Postfix, from userid 65534)
	id E2D767F965; Tue,  4 Mar 2014 16:42:57 +0100 (CET)
Received: from krabat.ahsoftware (unknown [IPv6:feee::5246:5dff:fe8b:95f8])
	by eiche.ahsoftware (Postfix) with ESMTP id A5DD87F897
	for <git@vger.kernel.org>; Tue,  4 Mar 2014 15:42:54 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243348>

Hello,

also I'm using git since a long time, I can't remember that I've noticed 
that git doesn't make a note or warning if remotes tags have changed.

E.g. what's often will be forgotten is to annotate tags before pushing 
them. The usual resolution is just to annotate them locally and push 
them again.

But such a change never ends up at people which already have fetched the 
tag (without them using git fetch -t). They even don't receive a notice 
which could remind them to use git fetch -t.

Unfortunately I'm not aware a lot about git internals, but would it be 
hard to make it configurable (tagopts comes into mind) that git outputs 
a warning if a remote tag and local tag do disagree about the commit, 
annotation or sign? I even would prefer such a warning as the default.

Regards,

Alexander Holler
