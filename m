From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3] cherry-pick: make sure all input objects are commits
Date: Tue, 16 Apr 2013 16:22:37 +0200
Message-ID: <516D5EAD.4070503@alum.mit.edu>
References: <20130403092704.GC21520@suse.cz> <7v38v1yn8o.fsf@alter.siamese.dyndns.org> <20130411092638.GA12770@suse.cz> <CALkWK0n6FjGbXTqiOT_O6NbB5h0DLaNWKCCTQAFSO_BL-pPdBA@mail.gmail.com> <20130411110324.GD12770@suse.cz> <CALkWK0kb+2KZLvRJDJb_VrNNs1k4grsfyFv0HfYv0Kr9v4sChQ@mail.gmail.com> <20130411130652.GG12770@suse.cz> <87vc7odvzi.fsf@linux-k42r.v.cablecom.net> <7v61znsj49.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>, Miklos Vajna <vmiklos@suse.cz>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 16:22:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US6mU-0004gv-PU
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 16:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935721Ab3DPOWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 10:22:42 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:48367 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933715Ab3DPOWm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 10:22:42 -0400
X-AuditID: 12074411-b7f286d0000008e8-60-516d5eb1667c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 1C.6E.02280.1BE5D615; Tue, 16 Apr 2013 10:22:41 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3GEMbW9030982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 16 Apr 2013 10:22:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7v61znsj49.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqLsxLjfQ4PslWYtVMx+zW3Rd6Way
	WDHlHovF3cur2C12TpnP7MDqsXPWXXaP26/nM3tcvKTscWbBEXaPz5vkAlijuG2SEkvKgjPT
	8/TtErgzNl3tZyroYq14eecHewNjL0sXIweHhICJxK8rRl2MnECmmMSFe+vZuhi5OIQELjNK
	vLvwmgXCOc4k8XXvJBaQKl4BbYk9t+8ygdgsAqoSfzY1s4LYbAK6Eot6msHiogJhEqvWL2OG
	qBeUODnzCdgyEQEVib5TMSAzmQV6GCXOdWxnA6kRFvCRuLtwNtTmGcwSS7dPBhvKKWAmcfDI
	d0YQm1lAR+Jd3wNmCFteYvvbOcwTGAVmIdkxC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYn
	J+blpRbpmurlZpbopaaUbmKEBLngDsYZJ+UOMQpwMCrx8AbI5wQKsSaWFVfmHmKU5GBSEuUN
	C88NFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCe9YRKMebklhZlVqUD5OS5mBREuflW6LuJySQ
	nliSmp2aWpBaBJOV4eBQkuBtjgVqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfF
	anwxMFpBUjxAeyeAtPMWFyTmAkUhWk8x6nKsvPLkNaMQS15+XqqUOG89SJEASFFGaR7cClhK
	e8UoDvSxMG8JSBUPMB3CTXoFtIQJaMmBVdkgS0oSEVJSDYzcGVXe5q7Pfh0sCZNt7dKd0n1A
	QULsjBFr3qrLM77lyD7+Z+y1danRAs9ZiVYuqonehyQs9v1X/JskGfmaZbr/tfQd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221420>

On 04/15/2013 09:12 PM, Junio C Hamano wrote:
> The paths given to handle_refs() may also have to be copied before
> saved, depending on how ref iteration is implemented, details of
> which may change as Michael seems to be updating the area again.
> I think we let the callback peek ref_entry->name[] which is stable,
> so I suspect we are OK.

ref_entry->name is stable as long as invalidate_ref_cache() is not
called, and I am not even thinking of changing that (partly because I
don't have the energy to audit and adjust all of the callers).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
