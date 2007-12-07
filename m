From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Fri, 7 Dec 2007 12:21:59 +0100
Message-ID: <20071207112159.GA11035@elte.hu>
References: <20071207093439.GA21896@elte.hu> <7v63za4yic.fsf@gitster.siamese.dyndns.org> <7vwsrq3iox.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 12:22:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0bHw-00028C-DS
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 12:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbXLGLWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 06:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbXLGLWP
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 06:22:15 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:49671 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314AbXLGLWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 06:22:14 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1J0bHS-0005JQ-IU
	from <mingo@elte.hu>; Fri, 07 Dec 2007 12:22:12 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 63DF83E2166; Fri,  7 Dec 2007 12:22:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vwsrq3iox.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67412>


* Junio C Hamano <gitster@pobox.com> wrote:

>  (1) When no option is given, and $DISPLAY is set, it continues to
>      spawn gitk as before;
> 
>  (2) When no option is given, and $DISPLAY is unset, "git log" is run
>      to show the range of commits between the bad one and the good 
>      ones;
> 
>  (3) If only "-flag" options are given, "git log <options>" is run.
>      E.g. "git bisect visualize --stat"
> 
>  (4) Otherwise, all of the given options are taken as the initial part
>      of the command line and the commit range expression is given to 
>      that command.  E.g. "git bisect visualize tig" will run "tig" 
>      history viewer to show between the bad one and the good ones.

nice. One small detail though: i frequently ssh to testboxes that have 
DISPLAY set but i want text output. So git-bisect view --text should be 
a special-case perhaps?

	Ingo
