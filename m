From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve and fix git-check-attr(1)
Date: Tue, 14 Oct 2008 16:58:08 -0700
Message-ID: <7vabd6686n.fsf@gitster.siamese.dyndns.org>
References: <20081013175705.GA9538@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Oct 15 01:59:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KptnV-0001B9-Kc
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 01:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbYJNX6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 19:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbYJNX6Q
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 19:58:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbYJNX6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 19:58:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B1F9C6F713;
	Tue, 14 Oct 2008 19:58:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D87316F712; Tue, 14 Oct 2008 19:58:11 -0400 (EDT)
In-Reply-To: <20081013175705.GA9538@diku.dk> (Jonas Fonseca's message of
 "Mon, 13 Oct 2008 19:57:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F6F06034-9A4B-11DD-9CBF-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98227>

Jonas Fonseca <fonseca@diku.dk> writes:

> Always use 'verse' for multi-line synopsis sections. Add output and
> example sections to document what output can be expected.
>
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
>
> ---
>  Documentation/git-check-attr.txt |   63 +++++++++++++++++++++++++++++++++++++-
>  1 files changed, 62 insertions(+), 1 deletions(-)
>
>  At least the first chunk should be applied. The last is a quick attempt
>  at documenting the expected output formally and with examples.
> ...
> tg: (340fcf4..) jf/man-git-check-attr (depends on: next)

Should this really have to depend on next?  I have a feeling that a large
part of this (sans --stdin/-z) is a 'maint' material.

Could you split this into two patches, one for 'maint' to describe the
output format, and another for 'next' (or 'dp/checkattr') to update the
SYNOPSIS part?
