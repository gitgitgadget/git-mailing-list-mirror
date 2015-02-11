From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/11] ref_transaction_update(): remove "have_old" parameter
Date: Wed, 11 Feb 2015 16:32:45 +0100
Message-ID: <54DB761D.6080300@alum.mit.edu>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>	<1423412045-15616-5-git-send-email-mhagger@alum.mit.edu> <CAGZ79kbbRdqd+EnJD3Opfc5Luf-1FnEarUpTnXAiKoxh-pqc1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 16:39:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLZON-0001lS-MD
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 16:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbbBKPjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 10:39:51 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:52368 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752530AbbBKPjv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2015 10:39:51 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Feb 2015 10:39:50 EST
X-AuditID: 1207440e-f79bc6d000000c43-f5-54db761f9384
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.26.03139.F167BD45; Wed, 11 Feb 2015 10:32:48 -0500 (EST)
Received: from [192.168.69.130] (p4FC9687D.dip0.t-ipconnect.de [79.201.104.125])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1BFWjcZ014630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 11 Feb 2015 10:32:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <CAGZ79kbbRdqd+EnJD3Opfc5Luf-1FnEarUpTnXAiKoxh-pqc1Q@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqKtQdjvEYMYDJouuK91MFg29V5gt
	3t5cwmjRPeUto0Vv3ydWi82b21kc2Dx2zrrL7rFgU6nHxUvKHp83yQWwRHHbJCWWlAVnpufp
	2yVwZ0yZtpCpYB1Lxad9N1kbGDczdzFycEgImEisOKzcxcgJZIpJXLi3nq2LkYtDSOAyo8Se
	rkMsEM4FJokZ5xaxgFTxCmhL3Lv5nxnEZhFQleg7tooJxGYT0JVY1NMMZosKBEkcOv0Yql5Q
	4uTMJ2C2iICaxMxVs8E2MAvMY5K40v6TDSQhLBAg8f32ZCaIbYcYJRZNf8UOkuAUCJT4NesD
	I4jNLKAu8WfeJWYIW15i+9s5zBMYBWYhWTILSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn
	5uWlFuka6+VmluilppRuYoQEOd8Oxvb1MocYBTgYlXh4P2y6FSLEmlhWXJl7iFGSg0lJlPd+
	yu0QIb6k/JTKjMTijPii0pzUYqCTOZiVRHj5s4ByvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJ
	JanZqakFqUUwWRkODiUJ3kklQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoGiN
	LwbGK0iKB2jvRZB23uKCxFygKETrKUZdjgXt+2cyCbHk5eelSonz3gUpEgApyijNg1sBS2mv
	GMWBPhbmvQNSxQNMh3CTXgEtYQJaUlBwA2RJSSJCSqqBMSf+xfZnc42a1jPlW9QmFZ84Ub4t
	fUfdTY0PD1fOOO5n3Rh67q7kYk7RSwfcL9Zft6j82FaS7W2zTzF5b8psmSk3ky0+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263678>

On 02/09/2015 07:20 PM, Stefan Beller wrote:
> On Sun, Feb 8, 2015 at 8:13 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Instead, if old_sha1 is non-NULL, verify it; otherwise, don't.
> 
> parsing error on that commit message. I needed to read the code to understand
> what you want to say here.

Thanks for the comment. I will change that sentence to

    Instead, verify the reference's old value if and only if old_sha1 is
    non-NULL.

(in this commit and its successor).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
