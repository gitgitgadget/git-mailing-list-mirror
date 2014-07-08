From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 37/48] refs.c: remove lock_ref_sha1
Date: Tue, 08 Jul 2014 15:38:50 +0200
Message-ID: <53BBF46A.70802@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-38-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 15:41:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4VeI-000631-TL
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 15:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbaGHNla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 09:41:30 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:50463 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753882AbaGHNiw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 09:38:52 -0400
X-AuditID: 12074413-f79ed6d000002501-e9-53bbf46b9b45
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 92.3F.09473.B64FBB35; Tue,  8 Jul 2014 09:38:51 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68DcoD4001050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 09:38:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-38-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42IRYndR1M3+sjvYoP+/kUXXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTvjxAnhgmPMFXPOHWFqYHzN1MXIySEhYCJx4P9k
	RghbTOLCvfVsXYxcHEIClxklNq9+xg7hnGeS2HF1IitIFa+ApsTCvwvBbBYBVYml036BdbMJ
	6Eos6mkGmyoqECQx+/M8doh6QYmTM5+wgNgiAnYS628tZAaxhQWsJSZevgHUywG0oEZiXRcv
	SJhTwFXi5svvLCBhCQFxiZ7GIJAws4COxLu+B8wQtrzE9rdzmCcwCsxCsmAWkrJZSMoWMDKv
	YpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSndxAgJUOEdjLtOyh1iFOBgVOLhXXFw
	V7AQa2JZcWXuIUZJDiYlUd47b3cHC/El5adUZiQWZ8QXleakFh9ilOBgVhLh/XIKKMebklhZ
	lVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuDlAEaikGBRanpqRVpmTglCmomD
	E2Q4l5RIcWpeSmpRYmlJRjwoSuOLgXEKkuIB2nv5M8je4oLEXKAoROspRkUpcV6xT0AJAZBE
	Rmke3FhY2nnFKA70pTDvI5B2HmDKgut+BTSYCWjw5/c7QAaXJCKkpBoYl0udabf0kzBYvNpA
	XezzWh/p7Uuf/nRm7czVZn208p/vSZbWaDcLy71ebG55mfO670Z7T1yfzfn01pwdWq+euytL
	rwjbx6ziKn3dSMlw5f1P3OL+Ck8a55yX5CvO8KnNOqfyl2v9Lf1PlwxErl/lc+i9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253024>

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> lock_ref_sha1 was only called from one place in refc.c and only provided
> a check that the refname was sane before adding back the initial "refs/"
> part of the ref path name, the initial "refs/" that this caller had already
> stripped off before calling lock_ref_sha1.
> [...]

I'm especially glad to see this ugly function disappear!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
