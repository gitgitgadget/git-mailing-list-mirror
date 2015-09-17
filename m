From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4] gc: save log from daemonized gc --auto and print it
 next time
Date: Thu, 17 Sep 2015 11:40:26 +0200
Message-ID: <55FA8A8A.7000707@alum.mit.edu>
References: <1440209546-23442-1-git-send-email-pclouds@gmail.com>	<1442108202-25746-1-git-send-email-pclouds@gmail.com>	<xmqq8u88ykv4.fsf@gitster.mtv.corp.google.com>	<xmqq1te0ykaj.fsf@gitster.mtv.corp.google.com>	<55F93646.9050709@alum.mit.edu> <xmqqmvwms6b1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 11:40:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcVgE-0003Pz-O3
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 11:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbbIQJkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 05:40:35 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59544 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752171AbbIQJkb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2015 05:40:31 -0400
X-AuditID: 12074413-f79bd6d000007ac2-9c-55fa8a8de54a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id AF.E2.31426.D8A8AF55; Thu, 17 Sep 2015 05:40:29 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96EAB.dip0.t-ipconnect.de [79.201.110.171])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t8H9eRqF031077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 17 Sep 2015 05:40:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqqmvwms6b1.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqNvb9SvU4Pt0JYu1z+4wWXRd6Way
	aOi9wmzRPeUto8WZN42MDqweO2fdZfe4eEnZY/EDL4/Pm+QCWKK4bZISS8qCM9Pz9O0SuDMm
	bE4q2MRS0XD/MmMD4yrmLkZODgkBE4nlD18xQthiEhfurWcDsYUELjNKzFxd1cXIBWRfYJJY
	3LEerIhXQFvi6cQtYDaLgKpE3/UpTCA2m4CuxKKeZjBbVCBIYsXyF1D1ghInZz5hAbFFBNQk
	JrYdYgEZyizwglFiwvZ+sG3CAuESq34fZYHYvIRJ4sjOOhCbU8BaYuu/7+xdjBxADeoS6+cJ
	gYSZBeQltr+dwzyBUWAWkhWzEKpmIalawMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXXC83
	s0QvNaV0EyMkpIV3MO46KXeIUYCDUYmHt8LtV6gQa2JZcWXuIUZJDiYlUV6HVqAQX1J+SmVG
	YnFGfFFpTmrxIUYJDmYlEd7CNqAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFM
	VoaDQ0mC178TqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFKXxxcA4BUnxAO2N
	BmnnLS5IzAWKQrSeYtTlWPDj9lomIZa8/LxUKXFeN5AiAZCijNI8uBWwBPaKURzoY2HeOSBV
	PMDkBzfpFdASJqAlr2LBlpQkIqSkGhgV2dXd/h9Y/97tZrvF1o1p7lYr39+J8el99etOw70Z
	nAdEsyITGq+yVt5jf7T2UeFdNqknRxIuPxHZ1bw84Ofbp+UrbjxYxf+8kvPzhJOR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278102>

On 09/16/2015 06:00 PM, Junio C Hamano wrote:
> *1* But one "gc" could be foreground gc that does not write to a log
>     file and the other "gc" could be background that does write to a
>     log file, so this cannot be the primary way to avoid double
>     execution.

^^^ This was the point that was confusing me. If this is not one of the
roles of the log file, then things are easier.

If you decide to go the route of tempfile/lockfile modifications, feel
free to CC me for feedback.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
