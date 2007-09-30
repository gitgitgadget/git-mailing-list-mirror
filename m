From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Script to backdate tags
Date: Sat, 29 Sep 2007 22:16:46 -0700
Message-ID: <7vps00ivgh.fsf@gitster.siamese.dyndns.org>
References: <87bqbklu5r.fsf@hariken.mwolson.org>
	<871wcglqrg.fsf@hariken.mwolson.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Olson <mwolson@gnu.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 07:17:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbrB0-0002uQ-04
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 07:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbXI3FQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 01:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbXI3FQy
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 01:16:54 -0400
Received: from rune.pobox.com ([208.210.124.79]:47023 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbXI3FQy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 01:16:54 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id BBEB313E96F;
	Sun, 30 Sep 2007 01:17:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 46C6C13E96E;
	Sun, 30 Sep 2007 01:17:10 -0400 (EDT)
In-Reply-To: <871wcglqrg.fsf@hariken.mwolson.org> (Michael Olson's message of
	"Sun, 30 Sep 2007 00:29:55 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59522>

Michael Olson <mwolson@gnu.org> writes:

> Michael Olson <mwolson@gnu.org> writes:
>
>> This may run into issues if someone uses the "\" character in their
>> tag names, [snip].
>
> In fact, this isn't the case after all.

Wouldn't it be easier to create the tag with the desired
timestamp from the beginning, by exporting GIT_COMMITTER_DATE?
