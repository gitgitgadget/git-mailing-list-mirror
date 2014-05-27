From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 0/3] Add --graft option to git replace
Date: Tue, 27 May 2014 21:05:20 +0200 (CEST)
Message-ID: <20140527.210520.2165451218485597326.chriscool@tuxfamily.org>
References: <20140522211836.27162.80311.chriscool@tuxfamily.org>
	<xmqq7g5cl9d2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 27 21:05:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpMgl-00032E-4H
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 21:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbaE0TFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 15:05:25 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:55812 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbaE0TFW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 15:05:22 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id C1D0860;
	Tue, 27 May 2014 21:05:20 +0200 (CEST)
In-Reply-To: <xmqq7g5cl9d2.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250189>

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 0/3] Add --graft option to git replace
Date: Fri, 23 May 2014 09:59:05 -0700

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> Here is a small patch series to implement:
>>
>> 	git replace [-f] --graft <commit> [<parent>...]
>>
>> The changes since the RFC/PATCH are the following:
>>
>> - in patch 1/3, parse_commit_buffer() is now used to
>>   make sure <commit> is not corrupt
>> - patch 2/3 add some tests
>> - patch 3/3 add some documentation
>>
>> About the documentation, maybe we should add that --graft
>> can now be used instead of grafts in .git/info/grafts,
>> and maybe we could add an example that shows how it can
>> be done.
> 
> Or a procedure that reads .git/info/grafts, converts it to a set of
> replacements and drops .git/info/grafts.  A sample script could be
> thrown in to contrib/ somewhere as "convert-graft-to-replace.sh".

Ok, I just sent a patch that adds such a sample script.

Thanks,
Christian.
