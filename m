From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add hints to revert documentation about other ways to
 undo changes
Date: Wed, 20 Aug 2008 16:06:32 -0700
Message-ID: <7vzln7mglj.fsf@gitster.siamese.dyndns.org>
References: <7vk5ec7s05.fsf@gitster.siamese.dyndns.org>
 <1219175431-20730-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Lea Wiemann <lewiemann@gmail.com>
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 01:07:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVwmJ-00030y-Hn
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 01:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbYHTXGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 19:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754393AbYHTXGn
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 19:06:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbYHTXGm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 19:06:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 904AA61225;
	Wed, 20 Aug 2008 19:06:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 18DE06121F; Wed, 20 Aug 2008 19:06:34 -0400 (EDT)
In-Reply-To: <1219175431-20730-1-git-send-email-tarmigan+git@gmail.com>
 (Tarmigan Casebolt's message of "Tue, 19 Aug 2008 12:50:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A68F4C00-6F0C-11DD-AAE8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93071>

Tarmigan Casebolt <tarmigan+git@gmail.com> writes:

> Based on its name, people may read the 'git revert' documentation when
> ...
>  Documentation/git-revert.txt |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index 98cfa3c..e578edf 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -15,7 +15,15 @@ Given one existing commit, revert the change the patch introduces, and record a

Why do you say you have 7 preimage lines and 15 postimage lines, when the
diffstat claims you have 9 insertions?

Did you hand edit the diff?
