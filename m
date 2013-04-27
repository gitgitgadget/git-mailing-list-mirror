From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [ANNOUNCE] Git v1.8.3-rc0
Date: Sat, 27 Apr 2013 07:32:08 +0200
Message-ID: <517B62D8.5020006@alum.mit.edu>
References: <7vvc78u8jl.fsf@alter.siamese.dyndns.org> <CAH_OBievcf-_z_AX9UrmWL_HVFT2vSQTu+wXAjAFeQBM8iFSGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: shawn wilson <ag4ve.us@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Sat Apr 27 07:32:22 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1UVxkD-0002ua-WF
	for glk-linux-kernel-3@plane.gmane.org; Sat, 27 Apr 2013 07:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675Ab3D0FcP (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sat, 27 Apr 2013 01:32:15 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:51043 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753957Ab3D0FcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Apr 2013 01:32:13 -0400
X-AuditID: 12074413-b7f226d000000902-87-517b62dd1ff2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 06.85.02306.DD26B715; Sat, 27 Apr 2013 01:32:13 -0400 (EDT)
Received: from [192.168.69.140] (p4FDD48CC.dip0.t-ipconnect.de [79.221.72.204])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3R5W9eY019379
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 27 Apr 2013 01:32:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAH_OBievcf-_z_AX9UrmWL_HVFT2vSQTu+wXAjAFeQBM8iFSGw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqHs3qTrQoOu/gMXKyVNYLbqudDNZ
	NPReYba4vGsOmwOLx85Zd9k9Ll5S9vi8SS6AOYrbJimxpCw4Mz1P3y6BO6Oz6xJbwRquijmP
	n7M3MC7j6GLk5JAQMJF4fnM6E4QtJnHh3nq2LkYuDiGBy4wS9z51s0A455kk2nd8ZgOp4hXQ
	lui9doYdxGYRUJX4dOM3K4jNJqArsainGWySqECYxKr1y5gh6gUlTs58wgJiiwDVz1l9DSjO
	wcEsUCjx9mk8SFhYQE2i9+BDVpCwkECVxJw58iBhToFAidlTVjNCVKtLrJ8nBBJmFpCX2P52
	DvMERoFZSObPQqiahaRqASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQ
	8BXewbjrpNwhRgEORiUe3oYlVYFCrIllxZW5hxglOZiURHnXxFYHCvEl5adUZiQWZ8QXleak
	Fh9ilOBgVhLhVXgGVM6bklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuDl
	BsapkGBRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoRuOLgVEKkuIB2rsgEaidt7gg
	MRcoCtF6ilGXY+WVJ68ZhVjy8vNSpcR574AUCYAUZZTmwa2AJatXjOJAHwvz3gOp4gEmOrhJ
	r4CWMAEtqZ1eDrKkJBEhJdXA6Le85sIqyWmWbFe7zq5PuDKFYxXfI1HL3MNv+lfWVE42W/gv
	YtrGj17muYHLXS+5N2eJF8rHOAgu2r+hkWHJvP0SU3v0pZpFHm6VCFuVczrwwr6Z 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222620>

On 04/27/2013 04:24 AM, shawn wilson wrote:
> On Fri, Apr 26, 2013 at 8:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
>>  * There was no good way to ask "I have a random string that came from
>>    outside world. I want to turn it into a 40-hex object name while
>>    making sure such an object exists".  A new peeling suffix ^{object}
>>    can be used for that purpose, together with "rev-parse --verify".
>>
> 
> What does this mean / what is the reason behind this? I can only think
> it might be useful in a test suite to make sure git isn't doing
> anything stupid with hashes...?

The topic is discussed here:

http://git.661346.n2.nabble.com/Bug-in-quot-git-rev-parse-verify-quot-td7580929.html

As discussed in the thread, when verifying that an argument names an
existing object, it is usually also appropriate to verify that the named
object is of a particular type (or can be converted to a particular
type), which could already be done with syntax like
"$userstring^{commit}".  But if, for example, you want to avoid
unwrapping tags but also want to verify that the named object really
exists, "$userstring^{object}" now provides a way.

And what do you have against test suites? :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
