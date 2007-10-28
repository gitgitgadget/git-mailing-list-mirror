From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] rev-parse: teach "git rev-parse --symbolic" to print the full ref name
Date: Sun, 28 Oct 2007 01:24:06 -0700
Message-ID: <7v640rwst5.fsf@gitster.siamese.dyndns.org>
References: <119350380778-git-send-email-prohaska@zib.de>
	<11935038081211-git-send-email-prohaska@zib.de>
	<11935038081650-git-send-email-prohaska@zib.de>
	<1193503808519-git-send-email-prohaska@zib.de>
	<11935038083369-git-send-email-prohaska@zib.de>
	<7v3avvy9yc.fsf@gitster.siamese.dyndns.org>
	<79CE31EE-0975-48EB-8B3E-FC9D6A8EB3E4@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 09:24:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im3Rd-0000el-0Y
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 09:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbXJ1IYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 04:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbXJ1IYR
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 04:24:17 -0400
Received: from rune.pobox.com ([208.210.124.79]:46619 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbXJ1IYP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 04:24:15 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 6FD7114FC96;
	Sun, 28 Oct 2007 04:24:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id CD71414FBDC;
	Sun, 28 Oct 2007 04:24:32 -0400 (EDT)
In-Reply-To: <79CE31EE-0975-48EB-8B3E-FC9D6A8EB3E4@zib.de> (Steffen Prohaska's
	message of "Sun, 28 Oct 2007 08:58:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62539>

Steffen Prohaska <prohaska@zib.de> writes:

> So the idea of --symbolic is really to return the argv as is?
> No change whatsoever allowed. Why would someone need this?
> Is it only for convenience when writing shell code?

rev-parse _is_ for convenience for writing shell scripts, to
sift various parameters into "rev-list arguments" and "non
rev-list arguments".
