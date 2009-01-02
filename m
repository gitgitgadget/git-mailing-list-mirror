From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout does not warn about tags without corresponding
 commits
Date: Fri, 02 Jan 2009 13:44:50 -0800
Message-ID: <7v8wptcrhp.fsf@gitster.siamese.dyndns.org>
References: <200901021325.58049.henrik@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Henrik Austad <henrik@austad.us>
X-From: git-owner@vger.kernel.org Fri Jan 02 22:46:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIrqe-0003mb-Nh
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 22:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758693AbZABVpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 16:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758650AbZABVpA
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 16:45:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757503AbZABVo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 16:44:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E75AF8D504;
	Fri,  2 Jan 2009 16:44:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3BC7D8D503; Fri,
  2 Jan 2009 16:44:53 -0500 (EST)
In-Reply-To: <200901021325.58049.henrik@austad.us> (Henrik Austad's message
 of "Fri, 2 Jan 2009 13:25:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 985746E6-D916-11DD-BA1D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104419>

Henrik Austad <henrik@austad.us> writes:

> I recently tried to do a checkout of (what I thought was the first) inux 
> kernel in the linux git repo.
>
> git checkout -b 2.6.11 v2.6.11

This should have barfed, and indeed I think it is a regression around
v1.5.5.  v1.5.4 and older git definitely fails to check out a tree object
like that.
