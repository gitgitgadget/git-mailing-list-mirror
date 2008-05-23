From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/3] bisect: use a detached HEAD to bisect
Date: Thu, 22 May 2008 22:35:21 -0700
Message-ID: <7v3ao9twfa.fsf@gitster.siamese.dyndns.org>
References: <20080523012857.acce6457.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri May 23 07:36:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzPx0-00035z-Eq
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 07:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbYEWFfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 01:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752725AbYEWFfa
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 01:35:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbYEWFf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 01:35:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 304023C4E;
	Fri, 23 May 2008 01:35:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 83A603C4D; Fri, 23 May 2008 01:35:23 -0400 (EDT)
In-Reply-To: <20080523012857.acce6457.chriscool@tuxfamily.org> (Christian
 Couder's message of "Fri, 23 May 2008 01:28:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0D2104B4-288A-11DD-9A35-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82680>

Christian Couder <chriscool@tuxfamily.org> writes:

> When "git bisect" was first written, it was not possible to
> checkout a detached HEAD. The detached feature appeared latter.
> ...
> This patch makes "git bisect" checkout revisions to be tested on
> a detached HEAD. This simplifies the code a bit.

Yay!!

One potential worry/downside is "bisect visualize".  Because <bisect>
branch was used for bisection, the _current_ commit has always been
indicated with a label.  HEAD would not get any special label in gitk,
would it?
