From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: 026fa0d5ad Breaks installs with absolue $(gitexecdir) and $(template_dir) variables using older GNU makes
Date: Thu, 5 Feb 2009 08:13:30 +0100
Message-ID: <54B6E81F-FCC5-453D-9F38-9F29C41F5613@zib.de>
References: <4985E8E1.90303@gmail.com> <7vab91icu0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: gitzilla@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 08:17:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUyUG-0006UI-K9
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 08:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbZBEHNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 02:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbZBEHNu
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 02:13:50 -0500
Received: from mailer.zib.de ([130.73.108.11]:65006 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752332AbZBEHNu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 02:13:50 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n157Deqd028968;
	Thu, 5 Feb 2009 08:13:45 +0100 (CET)
Received: from [192.168.178.21] (brln-4db95056.pool.einsundeins.de [77.185.80.86])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n157DZ9b025667
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 5 Feb 2009 08:13:40 +0100 (MET)
In-Reply-To: <7vab91icu0.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108509>


On Feb 5, 2009, at 8:04 AM, Junio C Hamano wrote:

> A Large Angry SCM <gitzilla@gmail.com> writes:
>
>> In 026fa0d5ad9538ca76838070861531c037d7b9ba, "Move computation of
>> absolute paths from Makefile to runtime (in preparation for
>> RUNTIME_PREFIX)", the following change was made to the Makefile. The
>> problem is that $(abspath names...) is a relatively recent addition  
>> to
>> GNU make and when used in an older GNU make, the test always fails
>> resulting incorrect installation dirs for the templates and commands.
>
> Is there anything being done on this issue?

Not yet.  I haven't had time.


> I could revert ed096c4 (Merge branch 'sp/runtime-prefix',  
> 2009-01-31), but
> I'd rather not if we can avoid it.

I'll propose a fix on Saturday.

	Steffen
