From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svnimport: Use separate arguments in the pipe for git-rev-parse
Date: Thu, 20 Sep 2007 23:59:40 -0700
Message-ID: <7vabrgjyg3.fsf@gitster.siamese.dyndns.org>
References: <200709161857.06065.danda@osc.co.cr>
	<7vlkb4wdzq.fsf@gitster.siamese.dyndns.org>
	<20070918092909.GU31176@kiste.smurf.noris.de>
	<200709201340.17023.danda@osc.co.cr>
	<20070921061122.GI11204@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Libby <danda@osc.co.cr>, git@vger.kernel.org
To: Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Fri Sep 21 08:59:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYcUU-0002Du-KZ
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 08:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbXIUG7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 02:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbXIUG7t
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 02:59:49 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:57191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbXIUG7s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 02:59:48 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 72BD513912B;
	Fri, 21 Sep 2007 03:00:05 -0400 (EDT)
In-Reply-To: <20070921061122.GI11204@kiste.smurf.noris.de> (Matthias Urlichs's
	message of "Fri, 21 Sep 2007 08:11:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58829>

Matthias Urlichs <smurf@smurf.noris.de> writes:

>> we do not like 'Cristian new code' as a tag name.
>
> Duh? That's a perfectly valid tag name.

Is it?

$ man git-check-ref-format
