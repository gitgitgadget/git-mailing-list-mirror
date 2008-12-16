From: jidanni@jidanni.org
Subject: Re: git-clone --how-much-disk-space-will-this-cost-me? [--depth n]
Date: Tue, 16 Dec 2008 08:37:02 +0800
Message-ID: <87zlixvtu9.fsf@jidanni.org>
References: <4946F4D9.8050803@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jlh@gmx.ch
X-From: git-owner@vger.kernel.org Tue Dec 16 01:38:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCNxf-0002j9-O3
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 01:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbYLPAhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 19:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbYLPAhG
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 19:37:06 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:46827 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753018AbYLPAhF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Dec 2008 19:37:05 -0500
Received: from jidanni2.jidanni.org (122-127-35-251.dynamic.hinet.net [122.127.35.251])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id D5834119DE5;
	Mon, 15 Dec 2008 16:37:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103222>

>> And don't tell us to just figure it out from the progress messages
>> after the download begins, and hit ^C if we don't like it.

JH> Maybe that's a dumb answer, but... why not?  This works pretty
JH> well for me.

Sounds like my last marriage. "Just hit ^C if you don't like it". How
do you think the in-laws will feel? Nope, plan ahead I now say.

JH> So maybe what you really want is an ETA display during the cloning
JH> process?  Sounds like a good idea to me.

ETA implies that git has an estimate of what is going to happen.

The key is to now allow the user to get such an estimate too, before
deciding to git-clone or not.
