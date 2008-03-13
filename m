From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/16] solaris portability patches
Date: Thu, 13 Mar 2008 00:56:21 -0700
Message-ID: <7v4pbbys4a.fsf@gitster.siamese.dyndns.org>
References: <20080312212932.GA26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 08:57:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZiJM-0004ZL-Pc
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 08:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbYCMH4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 03:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbYCMH4d
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 03:56:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbYCMH4d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 03:56:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F32252FD1;
	Thu, 13 Mar 2008 03:56:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 559AD2FD0; Thu, 13 Mar 2008 03:56:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77051>

Whew, a huge series.

I've queued the following for now.

    [PATCH 01/16] tr portability fixes
    [PATCH 02/16] t0050: perl portability fix
    [PATCH 03/16] more tr portability test script fixes
    [PATCH 04/16] grep portability fix: don't use "-e" or "-q"
    [PATCH 05/16] remove use of "tail -n 1" and "tail -1"
    [PATCH 06/16] add test_cmp function for test scripts
    [PATCH 07/16] t4020: don't use grep -a
    [PATCH 09/16] t6000lib: tr portability fix
    [PATCH 10/16] add NO_EXTERNAL_GREP build option
    [PATCH 13/16] filter-branch: don't use xargs -0
    [PATCH 14/16] filter-branch: use $SHELL_PATH instead of 'sh'
    [PATCH 15/16] t9112: add missing #!/bin/sh header
    [PATCH 16/16] t7505: use SHELL_PATH in hook

but being this close to -rc0 I do not really enjoy too disruptive
patches.
