From: Eric Lesh <eclesh@ucla.edu>
Subject: Re: [GUILT PATCH 4/4] Use guards information and functions
Date: Mon, 30 Jul 2007 00:06:08 -0700
Message-ID: <87bqducqvz.fsf@hubert.paunchy.net>
References: <118569541814-git-send-email-eclesh@ucla.edu>
	<1185695418227-git-send-email-eclesh@ucla.edu>
	<20070730041549.GF22017@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jsipek@cs.sunysb.edu, git@vger.kernel.org
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 09:06:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFPL1-0001Zb-9d
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 09:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938982AbXG3HGZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 03:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938972AbXG3HGZ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 03:06:25 -0400
Received: from smtp-7.smtp.ucla.edu ([169.232.46.138]:32854 "EHLO
	smtp-7.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938901AbXG3HGW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 03:06:22 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.48.151])
	by smtp-7.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6U76EFQ028930;
	Mon, 30 Jul 2007 00:06:14 -0700
Received: from localhost (adsl-75-26-169-114.dsl.scrm01.sbcglobal.net [75.26.169.114])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6U76EbU004903
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jul 2007 00:06:14 -0700
Received: by localhost (Postfix, from userid 1000)
	id 436AD1E80A8; Mon, 30 Jul 2007 00:06:08 -0700 (PDT)
In-Reply-To: <20070730041549.GF22017@filer.fsl.cs.sunysb.edu> (Josef Sipek's message of "Mon\, 30 Jul 2007 00\:15\:49 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.46.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54196>

Josef Sipek <jsipek@fsl.cs.sunysb.edu> writes:

>> -get_series | awk "{ if (NR == $n) print \$0}"
>> +get_guarded_series | awk "{ if (NR == $n) print \$0}"
>
> Seeing this almost makes me thing that get_series should give you the
> guarded series unless you poke it the right way...something like:
>
> get_series --full
>
> or
>
> get_full_series
>
>
> The guarded series is what most commands care about, right?
>

You're right.  I'll do it with get_full_series.

	Eric
