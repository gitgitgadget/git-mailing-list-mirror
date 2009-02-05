From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 026fa0d5ad Breaks installs with absolue $(gitexecdir) and
 $(template_dir) variables using older GNU makes
Date: Wed, 04 Feb 2009 23:04:39 -0800
Message-ID: <7vab91icu0.fsf@gitster.siamese.dyndns.org>
References: <4985E8E1.90303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Feb 05 08:09:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUyMS-0004g1-1A
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 08:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbZBEHEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 02:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbZBEHEs
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 02:04:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbZBEHEr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 02:04:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CFC8E2A78C;
	Thu,  5 Feb 2009 02:04:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F11752A789; Thu, 
 5 Feb 2009 02:04:40 -0500 (EST)
In-Reply-To: <4985E8E1.90303@gmail.com> (A. Large Angry's message of "Sun, 01
 Feb 2009 13:24:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 44845E62-F353-11DD-98D0-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108508>

A Large Angry SCM <gitzilla@gmail.com> writes:

> In 026fa0d5ad9538ca76838070861531c037d7b9ba, "Move computation of
> absolute paths from Makefile to runtime (in preparation for
> RUNTIME_PREFIX)", the following change was made to the Makefile. The
> problem is that $(abspath names...) is a relatively recent addition to
> GNU make and when used in an older GNU make, the test always fails
> resulting incorrect installation dirs for the templates and commands.

Is there anything being done on this issue?

I could revert ed096c4 (Merge branch 'sp/runtime-prefix', 2009-01-31), but
I'd rather not if we can avoid it.
