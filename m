From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] documentation: Makefile accounts for SHELL_PATH setting
Date: Sun, 12 Apr 2009 01:28:45 -0700
Message-ID: <7vzlem9sxu.fsf@gitster.siamese.dyndns.org>
References: <1237728044-15651-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20090410093430.6117@nanako3.lavabit.com>
 <7vmyamdirk.fsf@gitster.siamese.dyndns.org>
 <1239500938-sup-5545@ntdws12.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT List <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sun Apr 12 10:30:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsv5F-0004MU-Qv
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 10:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805AbZDLI3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 04:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756343AbZDLI3A
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 04:29:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47386 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbZDLI26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 04:28:58 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A21D3A95DB;
	Sun, 12 Apr 2009 04:28:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A7EBEA95DA; Sun,
 12 Apr 2009 04:28:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F77CDD5C-273B-11DE-8C9A-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116372>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> Excerpts from Junio C Hamano's message of Sat Apr 11 16:42:39 -0400 2009:
>> There was a discussion going that eventurally petered out without seeing
>> success (or breakage) reports from people with various platforms.
>
> I didn't see that part of the discussion.  Were there breakage
> reports?  I'm willing to make any required corrections to the patch
> such that it gets included (then I could drop it locally).

I do not recall breakage reports nor success reports.  At least it does
not seem to break things for me, but I do not do anything so...
