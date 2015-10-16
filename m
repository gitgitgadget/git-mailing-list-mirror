From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 03/26] refs-be-files.c: rename refs to refs-be-files
Date: Fri, 16 Oct 2015 08:36:54 +0200
Message-ID: <56209B06.6000900@alum.mit.edu>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com> <1444938410-2345-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 08:44:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmykQ-0007J8-3J
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 08:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbbJPGoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 02:44:10 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:57206 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753420AbbJPGoH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2015 02:44:07 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Oct 2015 02:44:07 EDT
X-AuditID: 1207440c-f79e16d000002a6e-16-56209b08c72c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 90.60.10862.80B90265; Fri, 16 Oct 2015 02:36:56 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB262D.dip0.t-ipconnect.de [93.219.38.45])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9G6asUg001875
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 16 Oct 2015 02:36:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444938410-2345-4-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqMsxWyHM4Mt+A4v5m04wWnRd6Way
	aOi9wmzxb0KNA4vHgk2lHhcvKXsseH6f3ePzJrkAlihum6TEkrLgzPQ8fbsE7oxbH06yF7xi
	qzj2cStTA+Mm1i5GTg4JAROJryc3skDYYhIX7q1n62Lk4hASuMwoseTFbWYI5xyTxNtryxlB
	qngFtCX2PlwI1M3BwSKgKvFieRVImE1AV2JRTzMTiC0qECSxYvkLqHJBiZMzn4AtEBFwkLi8
	6ygziM0s4Cvx4slzMFtYwFtixeJOdhBbSKCZUWL7Xk8Qm1PAQ+LQwW+sEPV6Ejuu/4Ky5SW2
	v53DPIFRYBaSFbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6hXm5miV5qSukm
	Rkgo8+xg/LZO5hCjAAejEg8vg51CmBBrYllxZe4hRkkOJiVR3kOTgEJ8SfkplRmJxRnxRaU5
	qcWHGCU4mJVEeLtigHK8KYmVValF+TApaQ4WJXFe1SXqfkIC6YklqdmpqQWpRTBZGQ4OJQne
	lzOBGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBkRpfDIxVkBQP0N5ikHbe4oLE
	XKAoROspRl2OBT9ur2USYsnLz0uVEuftBCkSACnKKM2DWwFLXK8YxYE+Fub9BFLFA0x6cJNe
	AS1hAlqy578syJKSRISUVANjqOjzxzumNJ+e9ZPRj/34hMTmGvtZd6YtWBk8WSchYO3mSa0e
	64oW39h8cIXDkpbpAg7dPy2r3SVTa3Jb52pblkbvi1H/O6Prte0vxfz3eUfuuIlP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279729>

On 10/15/2015 09:46 PM, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Rename refs.c to refs-be-files.c to indicate that this file now
> holds the implementation for the files based refs backend.
> A smaller portion of the code in this file is backend agnostic and will
> be moved to a a new refs.c file that will hold all the common refs code

"a" is repeated above.

> that is shared across all backends.
> 
> A second reason for first moving all the code to the new file and then
> move the backend agnostic code back to refs.c instead of the other way
> around is because the code that will eventually remain in this new
> refs-be-files.c file is so entangled that it would then be very
> difficult to break the split up into small independent patches/chunks.
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
