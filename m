From: Eric Lesh <eclesh@ucla.edu>
Subject: Re: [GUILT PATCH 1/4] get_series: Remove comments from end of series lines
Date: Mon, 30 Jul 2007 00:07:12 -0700
Message-ID: <877ioicqu7.fsf@hubert.paunchy.net>
References: <118569541814-git-send-email-eclesh@ucla.edu>
	<11856954183111-git-send-email-eclesh@ucla.edu>
	<20070730035422.GB22017@filer.fsl.cs.sunysb.edu>
	<87r6mqcvzp.fsf@hubert.paunchy.net>
	<20070730052633.GI22017@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 09:07:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFPLx-0001oB-Hk
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 09:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938675AbXG3HHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 03:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938541AbXG3HHX
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 03:07:23 -0400
Received: from smtp-3.smtp.ucla.edu ([169.232.48.136]:53734 "EHLO
	smtp-3.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938633AbXG3HHW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 03:07:22 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.46.158])
	by smtp-3.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6U77JQ2008036;
	Mon, 30 Jul 2007 00:07:19 -0700
Received: from localhost (adsl-75-26-169-114.dsl.scrm01.sbcglobal.net [75.26.169.114])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6U77JSC019936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jul 2007 00:07:19 -0700
Received: by localhost (Postfix, from userid 1000)
	id B61FB1E80AC; Mon, 30 Jul 2007 00:07:13 -0700 (PDT)
In-Reply-To: <20070730052633.GI22017@filer.fsl.cs.sunysb.edu> (Josef Sipek's message of "Mon\, 30 Jul 2007 01\:26\:33 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.48.136
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54197>

Josef Sipek <jsipek@fsl.cs.sunysb.edu> writes:

>
> I think the script I wrote is a bit cleaner as it more easily translates to:
>
> if (!ignore_line) {
> 	strip comment
> 	print
> }
>
> to make it work, you'd need to run sed with -n to not implicitly print the
> line.
>

Told you my sed-foo sucks ;-)  You're right again, of course.

	Eric
