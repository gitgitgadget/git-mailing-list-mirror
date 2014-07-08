From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 22/48] refs.c: make ref_transaction_begin take an
 err argument
Date: Tue, 08 Jul 2014 13:53:04 +0200
Message-ID: <53BBDBA0.5070308@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-23-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 13:53:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4TxR-0002KM-8y
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 13:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352AbaGHLxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 07:53:08 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:57557 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754279AbaGHLxH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 07:53:07 -0400
X-AuditID: 1207440e-f79da6d0000002fc-4e-53bbdba23b43
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id F7.6C.00764.2ABDBB35; Tue,  8 Jul 2014 07:53:06 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68Br5X2028881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 07:53:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-23-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42IRYndR1F10e3ewweoFKhZdV7qZLP5NqHFg
	8liwqdTj8ya5AKYobpukxJKy4Mz0PH27BO6M92/WMhZ8Zq74fP4qawNjJ3MXIyeHhICJxO3N
	j6FsMYkL99azdTFycQgJXGaUON+zgAXCOc8kcXDZBaAMBwevgLZE+4oyEJNFQFXi2ON6kF42
	AV2JRT3NTCC2qECQxOzP89hBbF4BQYmTM5+wgNgiAnYS628tBNslLBAh8fFLFyuILSRQI3F8
	4Vcwm1PAVeLe0v8sIOMlBMQlehqDQMLMAjoS7/oeMEPY8hLb385hnsAoMAvJhllIymYhKVvA
	yLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIyRA+XYwtq+XOcQowMGoxMO7
	4uCuYCHWxLLiytxDjJIcTEqivEeP7w4W4kvKT6nMSCzOiC8qzUktPsQowcGsJML75RRQjjcl
	sbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwfvqFlCjYFFqempFWmZOCUKa
	iYMTZDiXlEhxal5KalFiaUlGPChK44uBcQqS4gHa+x6knbe4IDEXKArReopRUUqcNxEkIQCS
	yCjNgxsLSzuvGMWBvhTm3QdSxQNMWXDdr4AGMwEN/vx+B8jgkkSElFQDo6uO1PH+LlmNLy7n
	dm+Mi9MSNTi4ISBy2+32qvV9v0pmsF9nvR2abn+h49neCo+dioYyGy9cvv7s721lBZ3S3Wri
	7sHTTt32alX/Mvd1TlnkiSahlHPMrmqmO3I8nsbdec/d1rDyVuH/vUsuKh6b37n6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253013>

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> Add an err argument to _begin so that on non-fatal failures in future ref
> backends we can report a nice error back to the caller.
> While _begin can currently never fail for other reasons than OOM, in which
> case we die() anyway, we may add other types of backends in the future.
> For example, a hypothetical MySQL backend could fail in _being with

s/_being/_begin/

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
