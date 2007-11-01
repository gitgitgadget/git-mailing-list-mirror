From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitweb: Always set 'from_file' and 'to_file' in parse_difftree_raw_line
Date: Thu, 01 Nov 2007 15:47:52 -0700
Message-ID: <7v7il18twn.fsf@gitster.siamese.dyndns.org>
References: <1193917089-15920-1-git-send-email-jnareb@gmail.com>
	<1193917089-15920-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 23:48:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inipf-0005b9-6e
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 23:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683AbXKAWr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 18:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbXKAWr6
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 18:47:58 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:59673 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbXKAWr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 18:47:57 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B76952F9;
	Thu,  1 Nov 2007 18:48:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 55CAF912DF;
	Thu,  1 Nov 2007 18:48:16 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63029>

Jakub Narebski <jnareb@gmail.com> writes:

> Always set 'from_file' and 'to_file' keys when parsing raw diff output
> format line, even if filename didn't change (file was not renamed).
> This allows for simpler code (and no problems with file named '0').
>
> Use
>   $diffinfo->{'from_file'}
> instead of
>   $diffinfo->{'from_file'} || $diffinfo->{'file'}
> from now on.

Isn't this description the other way around?
