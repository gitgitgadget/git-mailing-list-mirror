From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] rev-list docs: clarify --topo-order description
Date: Tue, 14 Aug 2012 10:22:25 +0200
Message-ID: <502A0AC1.4060800@alum.mit.edu>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 10:29:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1CVS-0002Fi-9I
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 10:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab2HNI3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 04:29:35 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:60138 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754496Ab2HNI3b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Aug 2012 04:29:31 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Aug 2012 04:29:31 EDT
X-AuditID: 12074412-b7f216d0000008e3-f3-502a0ac4de58
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 78.D7.02275.4CA0A205; Tue, 14 Aug 2012 04:22:29 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7E8MQ6j005584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 14 Aug 2012 04:22:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqHuUSyvA4O4JJouuK91MFg29V5gt
	JtxvYHZg9tg56y67x8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGccWbGPqeCJSMWmhtMsDYyX
	BboYOTkkBEwk/r7pYYOwxSQu3FsPZHNxCAlcZpT49WIeM0hCSOA4k8SzD3ZdjBwcvALaEj1d
	USBhFgFViWtPrrKD2GwCuhKLepqZQGxRgRCJNd+mMILYvAKCEidnPmEBsUUE1CQmth0Cs5kF
	IiUOz/sDVi8s4CLxecYcFohVphLPu4+BreUUMJPo7JzIDLKWWcBa4tvuIohWeYntb+cwT2AU
	mIVkwyyEqllIqhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXTy80s0UtNKd3ECAlaoR2M
	60/KHWIU4GBU4uFd4a4ZIMSaWFZcmXuIUZKDSUmUV5NTK0CILyk/pTIjsTgjvqg0J7X4EKME
	B7OSCO+Cf0DlvCmJlVWpRfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvJLA6BQS
	LEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VofDEwSkFSPEB7VUHaeYsLEnOBohCt
	pxh1OVb9fnKbUYglLz8vVUqc9zTI4QIgRRmleXArYCnqFaM40MfCvNYgo3iA6Q1u0iugJUxA
	S8o4wJaUJCKkpBoYo5sWveJy4M84f9ljib3t38QlGyeL/+HhzFNkuGv6dW3twxytTb9fOK2w
	ys/vMN+25cSq0HeLF8fK+cYvL7muysfz8sg2hk9VxpfmNQuzzpFoO1THbRs8Q/uM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203391>

On 08/14/2012 12:21 AM, Junio C Hamano wrote:
> We said "--date-order" still does not violate the topology, but it
> was still not clear enough.
>
> Reword the description for both "--date-order" and "--topo-order",
> and add an illustration to it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks for this change.  I was recently trying to figure out the meaning 
of these ordering options myself, and found the old text confusing.

> ---
>
>   * Let's do this before I forget...; came up in discussion $gmane/203370
>
>   Documentation/rev-list-options.txt | 29 +++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 6a4b635..dc501ee 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -579,15 +579,32 @@ Commit Ordering
>   By default, the commits are shown in reverse chronological order.
>
>   --topo-order::
> -
> -	This option makes them appear in topological order (i.e.
> -	descendant commits are shown before their parents).
> +	This option makes them appear in topological order.  Even
> +	without this option, descendant commits are shown before
> +	their parents, but this tries to avoid showing commits on
> +	multiple lines of history intermixed.
>
>   --date-order::
>
> -	This option is similar to '--topo-order' in the sense that no
> -	parent comes before all of its children, but otherwise things
> -	are still ordered in the commit timestamp order.
> +	Show no parents before all of its children, but otherwise
> +	show commits in the commit timestamp order.
> ++
> +For example, in a commit history like this:
> ++
> +----------------------------------------------------------------
> +
> +    ---1----2----4----7
> +	\	       \
> +	 3----5----6----8---
> +
> +----------------------------------------------------------------
> ++
> +where the numbers denote the order of commit timestamps, `git
> +rev-list` and friends with `--date-order` show the commits in the
> +timestamp order: 8 7 6 5 4 3 2 1.
> ++
> +With `--topo-order`, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
> +3 1), to avoid commits from two branches mixed together.

Is it possible to predict which of the two orders would be taken here? 
It would be nice for the results to be deterministic.  For example, 
topology "ties" could be broken by choosing the commit with the most 
recent timestamp.

>   --reverse::
>
>

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
