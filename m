From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/6] prune_remote(): sort delete_refs_list references
 en masse
Date: Tue, 25 Nov 2014 09:04:21 +0100
Message-ID: <54743805.20601@alum.mit.edu>
References: <1416423000-4323-1-git-send-email-sbeller@google.com> <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu> <1416578950-23210-4-git-send-email-mhagger@alum.mit.edu> <CAPc5daWubo+CSD-C+AH6Y-PKQ7h2MoUU=DbW+nYKO9uceogsAg@mail.gmail.com> <54742DEE.7090905@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 09:04:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtB73-00035Q-U7
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 09:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbaKYIEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 03:04:31 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48222 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752029AbaKYIE3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 03:04:29 -0500
X-AuditID: 12074414-f797f6d000004084-21-54743807e0c3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id FE.80.16516.70834745; Tue, 25 Nov 2014 03:04:23 -0500 (EST)
Received: from [192.168.69.130] (p5DDB361F.dip0.t-ipconnect.de [93.219.54.31])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAP84MpM027986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 25 Nov 2014 03:04:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <54742DEE.7090905@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqMtuURJi8GCuiUXXlW4mi4beK8wW
	b28uYbT4N6HGYvPmdhYHVo+ds+6yeyzYVOpx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGfem
	vmYrWMhecfDALLYGxsesXYycHBICJhKbP5yGssUkLtxbz9bFyMUhJHCZUeLCrsssEM45JonG
	dXvBqngFNCX2bgFJcHKwCKhKTGxfww5iswnoSizqaWYCsUUFgiRO7rnODlEvKHFy5hOwehEB
	NYmJbYfAbGaBtYwSx//kgdjCAiESDSsnMUIsm8EksbbjLRtIglNAR2J92yZGiAZ1iT/zLjFD
	2PIS29/OYZ7AKDALyY5ZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXQi83s0Qv
	NaV0EyMksEV2MB45KXeIUYCDUYmHt+FYcYgQa2JZcWXuIUZJDiYlUV4Rw5IQIb6k/JTKjMTi
	jPii0pzU4kOMEhzMSiK8UfOAynlTEiurUovyYVLSHCxK4rzfFqv7CQmkJ5akZqemFqQWwWRl
	ODiUJHjvmQENFSxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFa3wxMF5BUjxAe4tA
	2nmLCxJzgaIQracYdTlamt72Mgmx5OXnpUqJ814EKRIAKcoozYNbAUtjrxjFgT4W5j0OUsUD
	TIFwk14BLWECWhI3sxBkSUkiQkqqgZH/mphCtcMswTOWP2o0eLx0+6KUbsXw9t8T6y2LKn1h
	lGWtIrqU8f1/1YO7dUSYf+6Zfu5oevkuJyUWkYd+Ee0CW2M3Zlqreh5r51zjfMiP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260205>

On 11/25/2014 08:21 AM, Michael Haggerty wrote:
> On 11/21/2014 05:44 PM, Junio C Hamano wrote:
>> [...]
>> Eh, why is that called sort_string_list()?  Perhaps it is a good
>> opening to introduce string_list_sort(list, flag) where flag would
>> be a bitmask that represents ignore-case, uniquify, etc., and
>> then either deprecate the current one or make it a thin wrapper
>> of the one that is more consistently named.
> 
> I agree. Indeed, I typed that function's name wrong once when
> constructing this patch. It would be better to name it consistently with
> the other string_list_*() functions.
> 
> I put it on my todo list (but don't let that dissuade somebody else from
> doing it).

Since I was re-rolling the patch series anyway, I tacked this renaming
change onto the end of it. Feel free to omit it if you think it belongs
separately.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
