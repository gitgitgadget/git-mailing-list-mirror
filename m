From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2 v2] Add valgrind support in test scripts
Date: Wed, 21 Jan 2009 00:48:39 -0800
Message-ID: <7vskndgi3c.fsf@gitster.siamese.dyndns.org>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de>
 <20090120044447.GF30714@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302>
 <20090120141932.GB10688@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302>
 <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302>
 <20090121001219.GA18169@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901210209580.19014@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 09:50:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPYnO-00012u-AC
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 09:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763931AbZAUIsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 03:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764106AbZAUIst
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 03:48:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764097AbZAUIsr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 03:48:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E805C92EF3;
	Wed, 21 Jan 2009 03:48:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4007592EF2; Wed,
 21 Jan 2009 03:48:40 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901210209580.19014@racer> (Johannes
 Schindelin's message of "Wed, 21 Jan 2009 02:10:17 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 503AA9E4-E798-11DD-8204-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106581>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This patch adds the ability to use valgrind's memcheck tool to
> diagnose memory problems in git while running the test scripts....

Hmmm, why do I haf to suffer with these new warnings from the tests?

  $ sh t2012-checkout-last.sh --valgrind -v -i
  warning: templates not found /git/git.git/t/valgrind/bin/templates/blt/
  Initialized empty Git repository in /git/git.git/t/trash directory.t2012-checkout-last/.git/
  mv: cannot stat `.git/hooks': No such file or directory
  * expecting success:
          echo hello >world &&

Am I using the patch incorrectly somehow?
