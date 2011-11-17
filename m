From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git clone --reference not working
Date: Thu, 17 Nov 2011 05:49:49 +0100
Message-ID: <4EC4926D.5050004@alum.mit.edu>
References: <20111116234314.GF3306@redhat.com> <7vobwbpnzr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrea Arcangeli <aarcange@redhat.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 05:50:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQtvK-0003au-D0
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 05:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507Ab1KQEt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 23:49:57 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:33620 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106Ab1KQEt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 23:49:56 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEBB0A.dip.t-dialin.net [84.190.187.10])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAH4nnXv029542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 17 Nov 2011 05:49:50 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vobwbpnzr.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185570>

On 11/17/2011 01:54 AM, Junio C Hamano wrote:
> Andrea Arcangeli <aarcange@redhat.com> writes:
> 
>> latest git.git won't clone linux upstream with --reference. Those
>> v*^{} tags breaks it. What's that stuff anyway, looks totally ugly
>> (two commits with same data contents and header) bah.
> 
> They point at commits they tag, and are essential for auto-following. They
> have been there forever in ls-remote output and they are not the real
> problem.
> 
> A recent topic that was merged at 9bd5000 tightened the refname checking
> code without thinking and started to needlessly barf upon seeing them. I
> think we have discussed about the issue on the list, but I do not think
> there were fixes yet.
> 
> Thanks for reminding.
> 
> Michael, how does this look?
>
> -- >8 --
> Subject: refs: loosen over-strict "format" check
> [...]

I reviewed the patch (and ran the test suite here for good measure).
Looks good.

>From SubmittingPatches it looks like I should authorize

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Is there a standard way to do so?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
