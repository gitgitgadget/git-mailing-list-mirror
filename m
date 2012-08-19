From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest
 namespace change
Date: Sun, 19 Aug 2012 15:19:18 +0200
Message-ID: <5030E7D6.8020206@alum.mit.edu>
References: <20120719213311.GA20385@sigill.intra.peff.net> <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu> <7vboi8rl2q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Muranov <alexey.muranov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 15:27:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T35X6-0002i9-F1
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 15:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab2HSN00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 09:26:26 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:49048 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751661Ab2HSN0Y (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2012 09:26:24 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Aug 2012 09:26:24 EDT
X-AuditID: 1207440c-b7f616d00000270b-5c-5030e7dad862
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 12.02.09995.AD7E0305; Sun, 19 Aug 2012 09:19:22 -0400 (EDT)
Received: from [192.168.69.140] (p57A24F38.dip.t-dialin.net [87.162.79.56])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7JDJJL1008595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 Aug 2012 09:19:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vboi8rl2q.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsUixO6iqHvruUGAwdwuKYuFff3MFl1Xupks
	GnqvMFtMuN/AbPGjpYfZYuWuhUwObB47Z91l93jWu4fR4+IlZY+5nxaxenzeJBfAGsVtk5RY
	UhacmZ6nb5fAnbHw3zrWgsMCFZeaFrE1MC7k7WLk5JAQMJFY/+E1O4QtJnHh3nq2LkYuDiGB
	y4wSJ9ves0A4p5kklnUuZgWp4hXQlth2Yg0biM0ioCpx4ONSZhCbTUBXYlFPMxOILSoQIrHm
	2xRGiHpBiZMzn7CA2CICahIT2w6BDWUWuMYoMfvAPLCEsECMxNmml2DNQgJzGSUWL9EBsTkF
	zCT+7PoItoxZQEfiXd8DZghbXmL72znMExgFZiHZMQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSn
	JusWJyfm5aUW6Rrq5WaW6KWmlG5ihAQ8zw7Gb+tkDjEKcDAq8fBqahkECLEmlhVX5h5ilORg
	UhLl/fAUKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE1z8XKMebklhZlVqUD5OS5mBREudVXaLu
	JySQnliSmp2aWpBaBJOV4eBQkuCNAUa2kGBRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJ
	RjwoWuOLgfEKkuIB2hsE0s5bXJCYCxSFaD3FaMzx+enJu4wck2+dvcsoxJKXn5cqJc5rD1Iq
	AFKaUZoHtwiW6l4xigP9LcwbCFLFA0yTcPNeAa1iAlr1aC7YqpJEhJRUA+OS/q4W7+0PI9MV
	z3N+7rb6N3+vgqkXe12Sy7PXq6xi5nqcsZTYeWzDXs1AlpPKWt8fXmBkYZOx/LLq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203719>

On 08/18/2012 10:39 PM, Junio C Hamano wrote:
> mhagger@alum.mit.edu writes:
> 
>> Given that a flag day would anyway be required to add a d/f-tolerant
>> system, I could live with a separate "graveyard" namespace as
>> originally proposed by Jeff.
>>
>> However, I still think that as long as we are making a jump, we could
>> try to land closer to the ultimate destination.
> 
> Do we _know_ already what the "ultimate destination" looks like?  

No; we can only guess.  I just wanted to submit some code so that the
existence/absence of code would not prejudice the decision.

> If the answer is yes, then I agree, but otherwise, I doubt it is a
> good idea to introduce unnecessary complexity to the system that may
> have to be ripped out and redone.
> 
> I didn't get the impression that we know the "ultimate destination"
> from the previous discussion, especially if we discount the tangent
> around "having next and next/foo at the same time" which was on
> nobody's wish, but I may be misremembering things.

It's been a wish of mine, but it's pretty low priority.  I've also
brainstormed about some other changes that could be connected with a new
repo format:

* Allow "deleted" loose references (for example denoted by value 0{40})
that override packed references with the same name.  This would remove
the need to rewrite the packed-refs file when a reference is deleted.
(A prerequisite for this change would be to allow next and next/foo at
the same time.)

* Push HEAD and its friends down out of $GIT_DIR into a
reference-specific directory.

* Rename lock files to look less like reference names (e.g., something
like "refs/foo~lock" instead of "refs/foo.lock").

* Somehow munge reference names in a way to avoid other filesystem
limitations -- e.g., case insensitivity, filenames like "com" and "prn"
or with multiple dots under Windows.

* ...or maybe a packed-refs file that can (usually) be updated in-place,
and get rid of loose references entirely.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
