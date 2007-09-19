From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] Full rework of quote_c_style and write_name_quoted.
Date: Tue, 18 Sep 2007 17:55:52 -0700
Message-ID: <7vabrjtqw7.fsf@gitster.siamese.dyndns.org>
References: <20070918223947.GB4535@artemis.corp>
	<20070918224122.2B55D344AB3@madism.org>
	<20070919000757.GC4535@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 02:56:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXnrG-0004ie-Np
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 02:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbXISAz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 20:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbXISAz6
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 20:55:58 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbXISAz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 20:55:57 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1EEEC137AD1;
	Tue, 18 Sep 2007 20:56:16 -0400 (EDT)
In-Reply-To: <20070919000757.GC4535@artemis.corp> (Pierre Habouzit's message
	of "Wed, 19 Sep 2007 02:07:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58670>

Pierre Habouzit <madcoder@debian.org> writes:

> On Tue, Sep 18, 2007 at 10:00:51PM +0000, Pierre Habouzit wrote:
>> +		cp = strchr(qname.buf + qname.len + 3 - max, '/');
>> +		if (cp)
>> +			cp = qname.buf + qname.len + 3 - max;
>
>   OMG, this is supposed to be if (!cp) of course...
>
>   I wonder how this passed the testsuite.

You would need a new test, I guess, before a huge rewrite.
