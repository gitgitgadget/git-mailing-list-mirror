From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] refs: remove unused function invalidate_ref_cache
Date: Sun, 27 Oct 2013 05:26:57 +0100
Message-ID: <526C9611.6090200@alum.mit.edu>
References: <1382806982-20634-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 27 05:27:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaHwi-0005zu-2h
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 05:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042Ab3J0E1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 00:27:01 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59762 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750914Ab3J0E1A (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Oct 2013 00:27:00 -0400
X-AuditID: 12074414-b7fb46d000002a4d-80-526c96130fb9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 2B.71.10829.3169C625; Sun, 27 Oct 2013 00:26:59 -0400 (EDT)
Received: from [192.168.69.9] (p57A242CF.dip0.t-ipconnect.de [87.162.66.207])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9R4QuMB024882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 27 Oct 2013 00:26:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <1382806982-20634-1-git-send-email-stefanbeller@googlemail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1BWelhNkcPWVmkXXlW4mi4beK8wW
	vxbMZXNg9ng6YTK7x8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGe0bNzEWrCArWLLxw2MDYxT
	WbsYOTkkBEwk7u46ygRhi0lcuLeerYuRi0NI4DKjxIpHG5kgnLNMEv1rp4N18ApoS9w4vg6o
	ioODRUBV4mCrJkiYTUBXYlFPM9ggUYEQiYWrjrNDlAtKnJz5hAXEFhFIkJjxdiJYjbCAl8S2
	55fBRgoJeEtc/7yLFWQkp4CPxOPTBiBhZgEdiXd9D5ghbHmJ7W/nME9g5J+FZOosJGWzkJQt
	YGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6iRESoCI7GI+clDvEKMDBqMTD
	qxGaEyTEmlhWXJl7iFGSg0lJlFesAyjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHcXSI43JbGy
	KrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxWhoNDSYLXaypQo2BRanpqRVpmTglCmomD
	E2Q4l5RIcWpeSmpRYmlJRjwoHuOLgREJkuIB2psC0s5bXJCYCxSFaD3FqMsx78uHb4xCLHn5
	ealS4rzhIEUCIEUZpXlwK2Dp6BWjONDHwrwlIFU8wFQGN+kV0BImoCV/r2SBLClJREhJNTAu
	6L8W8uerwG8L/z8CPC9Y5jS1xXqktCcm+ayzDrvRM2nub6WTj24Wm79KKyt/yfa0d0mDeaM2
	U3x5/HEG7Vqfqu1l2xryeF+c6vzseVdd+RGb0V6LS+b+xuWKH+JUHt+5KCnEGXdS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236771>

On 10/26/2013 07:03 PM, Stefan Beller wrote:
> The function 'invalidate_ref_cache' was introduced in 79c7ca5 (2011-10-17,
> invalidate_ref_cache(): rename function from invalidate_cached_refs())
> by a rename and elevated to be publicly usable in 8be8bde (2011-10-17,
> invalidate_ref_cache(): expose this function in the refs API)
> 
> However it is not used anymore, as 8bf90dc (2011-10-17, write_ref_sha1():
> only invalidate the loose ref cache) and (much) later 506a760 (2013-04-22,
> refs: change how packed refs are deleted) removed any calls to this
> function. So it seems as if we don't need that function any more,
> good bye!

Looks good.  Stefan, thanks for cleaning up after me!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
