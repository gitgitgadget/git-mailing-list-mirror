From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support diff.autorefreshindex=true in `git-diff --quiet'
Date: Mon, 01 Sep 2008 03:31:36 -0700
Message-ID: <7vskskw41j.fsf@gitster.siamese.dyndns.org>
References: <quack.20080901T0129.lth8wuci80o@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Mon Sep 01 12:32:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka6iH-0006KV-JQ
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 12:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbYIAKbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 06:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbYIAKbo
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 06:31:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbYIAKbn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 06:31:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EE0855BEFA;
	Mon,  1 Sep 2008 06:31:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7079B5BEF8; Mon,  1 Sep 2008 06:31:40 -0400 (EDT)
In-Reply-To: <quack.20080901T0129.lth8wuci80o@roar.cs.berkeley.edu> (Karl
 Chen's message of "Mon, 01 Sep 2008 01:29:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2B71ABAE-7811-11DD-8BB1-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94565>

Karl Chen <quarl@cs.berkeley.edu> writes:

> When diff.autorefreshindex is true, if a file has merely been 'touched'
> (mtime changed, but contents unchanged), then `git-diff --quiet' will
> now return 0 (indicating no change) instead of 1, and also silently
> refresh the index.

My knee-jerk reaction is that I do not particularly like this, but I
haven't thought things through.  What does --exit-code do with or without
the configuration variable?
