From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] new test from the submodule chapter of the user manual
Date: Fri, 21 Sep 2007 11:04:05 -0700
Message-ID: <7v1wcrki96.fsf@gitster.siamese.dyndns.org>
References: <20070920003413.GJ16235@genesis.frugalware.org>
	<7v1wcum0ox.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709201133590.28395@racer.site>
	<20070920170831.GQ16235@genesis.frugalware.org>
	<7vd4wdkokn.fsf@gitster.siamese.dyndns.org>
	<20070921130908.GF16235@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 20:04:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYmrT-000319-IO
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 20:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbXIUSEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 14:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbXIUSEO
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 14:04:14 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbXIUSEO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 14:04:14 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A23F1391C3;
	Fri, 21 Sep 2007 14:04:29 -0400 (EDT)
In-Reply-To: <20070921130908.GF16235@genesis.frugalware.org> (Miklos Vajna's
	message of "Fri, 21 Sep 2007 15:09:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58866>

That's horrible.  Please do not depend on object SHA1's to stay
the same.  If somebody makes a fix to the test to add a new file
in a sample subproject it would break all the rest.  Also please
do not depend on the progress output.

In short, please do not try to get away with quick-and-dirty.
