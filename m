From: jidanni@jidanni.org
Subject: Re: git-diff should not fire up $PAGER if there is no diff
Date: Tue, 16 Dec 2008 09:16:29 +0800
Message-ID: <87oczcx6ky.fsf@jidanni.org>
References: <alpine.DEB.1.00.0812160153340.14632@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 02:17:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCOZK-0004dV-F9
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 02:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbYLPBQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 20:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbYLPBQc
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 20:16:32 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:46943 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751406AbYLPBQc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Dec 2008 20:16:32 -0500
Received: from jidanni2.jidanni.org (122-127-35-251.dynamic.hinet.net [122.127.35.251])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 9EBFD119E37
	for <git@vger.kernel.org>; Mon, 15 Dec 2008 17:16:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103228>

>>>>> "JS" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

JS> Maybe you are not aware just how annoying these "this should do that, that
JS> should do this" without a patch are?

Yes but I must first learn the thing I am about to make a patch for.

In the mean time I could like most beginners, just feel dumb.

Or I could let you have my valuable insights on how things look to a
beginner. You would else have no way of knowing. Sorry I always come
across as Don Rickles the pushy customer... it's all a charade... now
let's get back to business,

>>>>> "JK" == Jeff King <peff@peff.net> writes:

JK> The usual workaround is to ask the pager to exit immediately if the
JK> output is small. I.e., putting "F" in your LESS variable (which git does
JK> automatically if you don't already have LESS set).

Ah, but who doesn't have LESS set these days? OK, the man page should
mention that so people will put the F on their LESS variable, like I
recall another man page already does.
