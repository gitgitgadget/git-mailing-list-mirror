From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] SubmittingPatches: Document how to request a patch review
 tag
Date: Sun, 06 Jan 2013 08:32:05 +0100
Message-ID: <50E92875.6080305@alum.mit.edu>
References: <7vy5gb33f9.fsf@alter.siamese.dyndns.org> <1357333116-6971-1-git-send-email-jason.k.holden.swdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jason Holden <jason.k.holden.swdev@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 08:32:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trkic-0005Km-Cg
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 08:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076Ab3AFHcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 02:32:12 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:56052 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750945Ab3AFHcK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2013 02:32:10 -0500
X-AuditID: 12074413-b7f786d0000008bb-32-50e928797a8e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 37.ED.02235.97829E05; Sun,  6 Jan 2013 02:32:09 -0500 (EST)
Received: from [192.168.69.140] (p57A246C2.dip.t-dialin.net [87.162.70.194])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r067W6c5007494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 6 Jan 2013 02:32:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1357333116-6971-1-git-send-email-jason.k.holden.swdev@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqFup8TLAYM0BKYuuK91MFg29V5gt
	7m47yOjA7LFz1l12j4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M6YNaW2YL1oxaYXPYwNjPMF
	uxg5OSQETCTWr3zJCmGLSVy4t56ti5GLQ0jgMqPEzTnrGSGc00wSW2/tZgSp4hXQllh55A87
	iM0ioCpx9VA7G4jNJqArsainmQnEFhUIkFi85Bw7RL2gxMmZT1hAbBEBQ4l9c06BzWEW0JJY
	19IL1issECLxYFM3WK+QQLnEj/VzwXo5BfwkfkxawgJRryPxru8BM4QtL7H97RzmCYwCs5Cs
	mIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM31cjNL9FJTSjcxQkJXeAfjrpNy
	hxgFOBiVeHgv7XwRIMSaWFZcmXuIUZKDSUmUd4vqywAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxK
	IrxuakA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEb5A6UKNgUWp6
	akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KFLji4GxCpLiAdrrCtLOW1yQmAsUhWg9xajL
	cavh5lNGIZa8/LxUKXFeT5DjBECKMkrz4FbAEtUrRnGgj4V5m0BG8QCTHNykV0BLmICWpD5+
	DrKkJBEhJdXAGL8relvb9pbyYywXvtW6b7LYNIVb69GR86vn3pGcaOiVJ/7HoH1b7udlgp3m
	qwr+VpbtSTl20ocxMafo8KnQzStDuO0fNu8o0uBIDJBr/TTdU66sXM790SShDTxH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212784>

On 01/04/2013 09:58 PM, Jason Holden wrote:
> Document the preferred way a developer should request to have their
> Acked-by/Tested-by/Reviewed-by tag to a patch series under discussion
> 
> Signed-off-by: Jason Holden <jason.k.holden.swdev@gmail.com>
> ---
> Junio,
>   I was ready to add my Reviewed-by to this patch series, but I wasn't sure if
> I should email just you the patch author (to cut down on overall list traffic)
> or both you and the list.  If all reviewed-by/acked-by/tested-by traffic 
> should go via the email list I think this patch would be helpful, as I 
> wasn't quite sure how wide of a distribution list to use for my 
> "Reviewed-by" email.
> 
> A very similiar question was asked previously in:
> http://thread.gmane.org/gmane.comp.version-control.git/185564/focus=185570

On 01/04/2013 10:47 PM, Junio C Hamano wrote:
> "Reviewed-by" is for those who are familiar with the part of the
> system being touched to say "I reviewed this patch, it looks good",
> and Michael indeed was involved in recent updates to the refs.c
> infrastructure, so as he said in his message "it looks like I should",
> it was the right thing to do.
>
> I do not think Michael was asking if that was the standard _thing_
> to do; I think the question was if there was a standard _way_
> (perhaps a tool) to send such a "Reviewed-by:" line.

Junio is correct; I was just asking whether there was a particular email
convention for adding a "Reviewed-by:" line.  It would be nice for this
to be mentioned in the documentation.

>  Documentation/SubmittingPatches | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index f6276ff..80001c9 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -268,6 +268,11 @@ If you like, you can put extra tags at the end:
>  4. "Tested-by:" is used to indicate that the person applied the patch
>     and found it to have the desired effect.
>  
> +If you are a reviewer and wish to add your Acked-by/Reviewed-by/Tested-by tag
> +to a patch series under discussion (after having reviewed it or tested it
> +of course!), reply to the author of the patch series, cc'ing the git mailing
> +list.
> +
>  You can also create your own tag or use one that's in common usage
>  such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".

I don't think this is quite correct.  Such emails should be
"reply-to-all" people who have participated in the thread, which might
include more than just the patch author and the git mailing list.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
