From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/4] Add more tests of cvsimport
Date: Fri, 20 Feb 2009 12:24:45 +0100
Message-ID: <499E92FD.8000900@alum.mit.edu>
References: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu> <20090220062543.GA27837@coredump.intra.peff.net> <7vzlghftdj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 12:26:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaTWr-0001d3-Lo
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 12:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbZBTLYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 06:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbZBTLYy
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 06:24:54 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:51510 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbZBTLYy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 06:24:54 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n1KBOluQ031070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Feb 2009 12:24:48 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20090105 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <7vzlghftdj.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110837>

Junio C Hamano wrote:
> Also I noticed that [3/4] uses "diff -r -x" --- does it pretty much mean
> we require GNU diff to pass the test?  Can this be made more portable?

I can't think offhand of a more portable tool that could replace "diff
-r -x" here (suggestions, anyone?).  Of course one could re-implement
recursive diff in shell or perl, and I will take a stab at it if you
consider it important.  Alternatively, one could hardcode the paths that
the test scripts should test, but that would cost more per-test work
that I'd rather avoid.

Michael
