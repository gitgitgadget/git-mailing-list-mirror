From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 09/22] api-lockfile: expand the documentation
Date: Wed, 02 Apr 2014 13:36:24 +0200
Message-ID: <533BF638.5060506@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu> <1396367910-7299-10-git-send-email-mhagger@alum.mit.edu> <20140401201906.GF21715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:32:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeN6-0000xS-7t
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758396AbaDBLg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 07:36:29 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:57866 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758372AbaDBLg2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Apr 2014 07:36:28 -0400
X-AuditID: 1207440f-f79326d000003c9f-51-533bf63b1f5e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 27.EE.15519.B36FB335; Wed,  2 Apr 2014 07:36:27 -0400 (EDT)
Received: from [192.168.69.148] (p57A25BD8.dip0.t-ipconnect.de [87.162.91.216])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s32BaO7H020052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 2 Apr 2014 07:36:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <20140401201906.GF21715@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqGv9zTrY4MEBQYuuK91MFg29V5gt
	frT0MDswezzr3cPocfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3Bmv3rxnKuhirXi6LKeBsZml
	i5GDQ0LAROLD8dguRk4gU0ziwr31bF2MXBxCApcZJXb/2sUKkhASOMckcfd+HUg9r4C2RM/1
	QpAwi4CqxK7WL8wgNpuArsSinmYmEFtUIEji8IZTYK28AoISJ2c+YQGxRQRkJb4f3sgIYjML
	WEuseH0YrF5YwFHi8rFWZoi9q4H27j4M1swJVPRsyl42iDvFJXoag0BMZgF1ifXzhCDGyEts
	fzuHeQKj4Cwk22YhVM1CUrWAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6JXm5miV5qSukm
	Rkgg8+9g7Fovc4hRgINRiYf3wHmrYCHWxLLiytxDjJIcTEqivH++WAcL8SXlp1RmJBZnxBeV
	5qQWH2KU4GBWEuGd9Akox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS
	4PX9CtQoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rb+GJg5IKkeID21oDcxFtc
	kJgLFIVoPcWoy7Fh25pGJiGWvPy8VClx3jefgYoEQIoySvPgVsDS1itGcaCPhXntQC7hAaY8
	uEmvgJYwAS3hXmcFsqQkESEl1cCoUrFuafL9n0FrOiwPsv369mZxnmZ7ts3lPfHvfh05ojqH
	4ebUqaXfF2wIl/l24pbh60v5byfL2927KPI4ZXXshiJnZ9Oneh726SlvWaSK3r27 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245680>

On 04/01/2014 10:19 PM, Jeff King wrote:
> On Tue, Apr 01, 2014 at 05:58:17PM +0200, Michael Haggerty wrote:
> 
>> +unable_to_lock_error::
>> +
>> +	Emit an error describing that there was an error locking the
>> +	specified path.  The err parameter should be the errno of the
>> +	problem that caused the failure.
>> +
>> +unable_to_lock_index_die::
>> +
>> +	Like `unable_to_lock_error()`, but also `die()`.
> 
> Should this last one lost the "index" in its name? I think it is
> vestigial at this point.

Yes.  Will be done in re-roll.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
