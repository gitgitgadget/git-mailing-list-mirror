From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 5/6] Document a bunch of functions defined in sha1_file.c
Date: Tue, 25 Feb 2014 16:23:26 +0100
Message-ID: <530CB56E.9020703@alum.mit.edu>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu> <1393000327-11402-6-git-send-email-mhagger@alum.mit.edu> <530B8CEB.5040903@gmail.com> <530BA530.3070603@alum.mit.edu> <20140224200855.GI7855@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 25 16:23:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIJr4-0003wU-Lj
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 16:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbaBYPXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 10:23:30 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:42290 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752492AbaBYPXa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Feb 2014 10:23:30 -0500
X-AuditID: 12074411-f79ab6d000002f0e-0c-530cb5717ded
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 75.54.12046.175BC035; Tue, 25 Feb 2014 10:23:29 -0500 (EST)
Received: from [192.168.69.148] (p57A2448A.dip0.t-ipconnect.de [87.162.68.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1PFNQGk005628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 25 Feb 2014 10:23:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140224200855.GI7855@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsUixO6iqFu4lSfY4PcxTouuK91MFiuuzmG2
	eHtzCaMDs8fOWXfZPT5vkgtgiuK2SUosKQvOTM/Tt0vgznh28zlzwWXuimdPe5kbGBdwdjFy
	ckgImEh0/VzPDGGLSVy4t56ti5GLQ0jgMqNE541lrCAJIYHzTBLzvvt1MXJw8ApoS9y+JgkS
	ZhFQlbhzvR2shE1AV2JRTzMTiC0qECyx+vIDFhCbV0BQ4uTMJ2C2iICGxPNP39hAbGYBH4m1
	v66yg9jCAr4S3zbfgdp7l1Giq3kN2EGcAvoSXbM/M4PslRAQl+hpDAIxmQXUJdbPE4IYIy+x
	/e0c5gmMgrOQbJuFUDULSdUCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqmermZJXqpKaWb
	GCFBLLiDccZJuUOMAhyMSjy8ncXcwUKsiWXFlbmHGCU5mJREeV9u5AkW4kvKT6nMSCzOiC8q
	zUktPsQowcGsJMJ7dRVQjjclsbIqtSgfJiXNwaIkzsu3RN1PSCA9sSQ1OzW1ILUIJivDwaEk
	wdu5BahRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhS78cXA6AVJ8QDtLQZp5y0u
	SMwFikK0nmJUlBLnLdkMlBAASWSU5sGNhaWmV4ziQF8K86aAtPMA0xpc9yugwUxAg49Kgw0u
	SURISTUwzko+dq51ivFibc5FYYcnMDesfRQYJPF2cVea0b//b9zzf0TI79z+tbd4tYbLz/VK
	mTzJr4QLnWvq1K97+z2S25OlLm92d35H926lD2GOzb+ZN2V+1tyQ6VF3K0qsJsfb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242670>

On 02/24/2014 09:08 PM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
>> [...]  I've been documenting public functions in the
>> header files above the declaration, and private ones where they are
>> defined.  [...]
>>
>> Let me know if you think I've made it less helpful.
> 
> In the present state of the codebase, where many important functions
> have no documentation or out-of-date documentation, the first place I
> look to understand a function is its point of definition.  So I do
> think that moving docs to the header file makes it less helpful.  I'd
> prefer a mass move in the opposite direction (from header files to the
> point of definition).
> 
> On the other hand I don't feel strongly about it.

Jonathan,

I see your point.  But I'd rather that we, as a project, strive to make
our header files good tables of contents of the publicly-accessible
functionality, including decent documentation for each function.  I try
to add comments to everything I touch, and I wish other developers would
too.

[What we really need is a comment fascist who patrols patch submissions
making sure that they add docstrings for new functions.  If I only had
the time and the jackboots for it...]

So I'd rather leave the comments for public functions in the header
files.  But if other regular developers prefer that comments be by the
function definitions, of course I can live with that, too.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
