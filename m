From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [Q] Branch aliases (synonyms)?
Date: Tue, 03 Jul 2012 17:29:26 +0200
Message-ID: <4FF30FD6.6020501@alum.mit.edu>
References: <1919214.YKUdgul2iY@laclwks004> <93cfd6eb9045585728dfe649359a103c@ulrik.uio.no> <4261222.bYBuBBxnOa@laclwks004>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git mailing list <git@vger.kernel.org>
To: Brian Foster <brian.foster@maxim-ic.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 17:36:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm59Z-0003h7-Gt
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 17:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182Ab2GCPgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 11:36:32 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:64264 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753616Ab2GCPgb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2012 11:36:31 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2012 11:36:31 EDT
X-AuditID: 1207440e-b7f036d0000008b5-d7-4ff30fd9d257
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B7.34.02229.9DF03FF4; Tue,  3 Jul 2012 11:29:29 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q63FTRkr032758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 3 Jul 2012 11:29:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <4261222.bYBuBBxnOa@laclwks004>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqHuT/7O/wZkOMYuXUyosuq50M1ms
	nvSTxYHZY/u816we3d1v2Dw+b5ILYI7itklKLCkLzkzP07dL4M44u3sNW8E1toq+Lc2sDYxd
	rF2MnBwSAiYSW3fcZIGwxSQu3FvP1sXIxSEkcJlR4vasY1DOMSaJrxteg3XwCmhLPDl/mQ3E
	ZhFQldh8agdYnE1AV2JRTzNTFyMHh6hAmMT0newQ5YISJ2c+AVsgIqAjMf/eCTCbWSBD4vjW
	22A1wkAj72x+ywhiCwlUSyz6NJMJxOYEqm+YdowVot5MomtrFyOELS+x/e0c5gmMArOQrJiF
	pGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9XIzS/RSU0o3MUJCl28HY/t6mUOM
	AhyMSjy8UtM++QuxJpYVV+YeYpTkYFIS5dUHBr4QX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV7u
	M0DlvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJXjOQoYJFqempFWmZ
	OSUIaSYOThDBBbKBB2iDCUghb3FBYm5xZjpE0SlGRSlx3jd8QAkBkERGaR7cAFiSecUoDvSP
	MC83SDsPMEHBdb8CGswENDhvMcjpxSWJCCmpBkbxiB81UkaCu3b0Lmp+6ftD6BbTzC8lj0Lb
	HtX7vVh17gFLJ/91LkPfE5J+KtJlUm/WCrse3579PM+wSuE088rJbC4Hyq3WmHKtPizd+8J5
	0v4Vvs+63rH0HtQSmyzofWviq6k3d/gvV3r1a5KS4rH3RQvMtzrptp3qnv1t2ZQF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200914>

On 07/03/2012 03:40 PM, Brian Foster wrote:
> On Tuesday 03-July-2012 05:23:29 Hallvard Breien Furuseth wrote:
>>              E.g. if it's hard to teach developers to switch
>>   from B to A, a hook which rejects pushes to B might help.
>
>   Whilst we _may_ have problems with some of the
>   internal developers (this can be managed so I'm
>   not worried about it), the concern is about the
>   external users (clients who clone but never push)
>   becoming confused.  Hence the requirement about
>   continuing to use the same branch name as you are
>   used to using.  That's it!  It's that simple.

Maybe create a new branch B (an orphan commit unconnected to the old 
branch B) with a single README file telling the person that from now on 
they should be using branch A.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
