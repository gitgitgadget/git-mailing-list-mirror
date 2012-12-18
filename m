From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: track TCLTK_PATH as it used to be tracked
Date: Tue, 18 Dec 2012 19:23:10 +0100 (CET)
Message-ID: <20121218.192310.41888431995379865.chriscool@tuxfamily.org>
References: <20121218145753.28253.98431.chriscool@tuxfamily.org>
	<7vk3sfguh2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: paulus@samba.org, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 18 19:23:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl1pX-0004sT-6P
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 19:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458Ab2LRSXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 13:23:33 -0500
Received: from [194.158.122.58] ([194.158.122.58]:34005 "EHLO mail-3d.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751348Ab2LRSXd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 13:23:33 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3d.bbox.fr (Postfix) with ESMTP id 923FB95;
	Tue, 18 Dec 2012 19:23:10 +0100 (CET)
In-Reply-To: <7vk3sfguh2.fsf@alter.siamese.dyndns.org>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211770>

From: Junio C Hamano <gitster@pobox.com>

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> ...
>> +GIT-TCLTK-VARS: FORCE
>> +	@VARS='$(TRACK_TCLTK)'; \
>> +		if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
>> +			echo 1>&2 "    * new Tcl/Tk interpreter location"; \
> 
> I think in a related patch to the top-level Makefile changes it to
> lose "1" to read it as "echo >&2" here.

Yeah, I forgot to remove the 1 here.

Thanks,
Christian.
