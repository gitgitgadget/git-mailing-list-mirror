From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clean up .dotest if an error occurs before rebase work starts
Date: Wed, 05 Sep 2007 13:07:10 -0700
Message-ID: <7vmyw0j2q9.fsf@gitster.siamese.dyndns.org>
References: <1189020436633-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 22:07:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT19r-0001AK-5f
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 22:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044AbXIEUHV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 16:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755232AbXIEUHU
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 16:07:20 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbXIEUHS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 16:07:18 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id CE24212EFE7;
	Wed,  5 Sep 2007 16:07:35 -0400 (EDT)
In-Reply-To: <1189020436633-git-send-email-robin.rosenberg@dewire.com> (Robin
	Rosenberg's message of "Wed, 5 Sep 2007 21:27:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57758>

It looks to me that we should instead delay the creation of
that .dotest directory until we determine that we _are_ going to
be able to run git-rebase, no?
