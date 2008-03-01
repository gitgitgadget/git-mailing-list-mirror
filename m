From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test for git rebase --abort
Date: Fri, 29 Feb 2008 23:41:10 -0800
Message-ID: <7vlk526gdl.fsf@gitster.siamese.dyndns.org>
References: <1204322927-22407-1-git-send-email-mh@glandium.org>
 <7v63w7bb06.fsf@gitster.siamese.dyndns.org>
 <20080301073612.GA26767@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 08:42:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVMM8-0005MX-5C
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 08:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbYCAHl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 02:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbYCAHl2
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 02:41:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42908 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbYCAHl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 02:41:27 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 401FA24C2;
	Sat,  1 Mar 2008 02:41:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 92A8224C1; Sat,  1 Mar 2008 02:41:18 -0500 (EST)
In-Reply-To: <20080301073612.GA26767@glandium.org> (Mike Hommey's message of
 "Sat, 1 Mar 2008 08:36:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75634>

Mike Hommey <mh@glandium.org> writes:

> On Fri, Feb 29, 2008 at 03:26:01PM -0800, Junio C Hamano wrote:
> ...
>> Please mark such an "expected to succeed but fails due to
>> suspected bug" with test_expect_failure.
>
> I was kind of expecting the bug would be fixed before the test be
> included ;)

Your patch does not have to go through me to whoever fixes the issue.
People can pick it up from the list, apply them to their tree and start
working on it.  The point is to be gentle to them.
