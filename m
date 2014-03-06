From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Fri, 07 Mar 2014 00:29:37 +0100
Message-ID: <531904E1.6010606@alum.mit.edu>
References: <20140304174806.GA11561@sigill.intra.peff.net> <xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com> <20140305005649.GB11509@sigill.intra.peff.net> <xmqqy50oh45n.fsf@gitster.dls.corp.google.com> <20140305185212.GA23907@sigill.intra.peff.net> <xmqqppm0h2ti.fsf@gitster.dls.corp.google.com> <53183506.5080002@alum.mit.edu> <20140306155626.GB18519@sigill.intra.peff.net> <5318A537.4010400@alum.mit.edu> <20140306174803.GA30486@sigill.intra.peff.net> <08A515BA063C44E5A9EFC754793B2AD8@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:29:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLhjX-0005c0-6h
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 00:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbaCFX3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 18:29:43 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42923 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751190AbaCFX3m (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2014 18:29:42 -0500
X-AuditID: 12074414-f79d96d000002d2b-a1-531904e56e07
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 52.5C.11563.5E409135; Thu,  6 Mar 2014 18:29:41 -0500 (EST)
Received: from [192.168.69.148] (p57A24A5D.dip0.t-ipconnect.de [87.162.74.93])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s26NTcYU007080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 6 Mar 2014 18:29:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <08A515BA063C44E5A9EFC754793B2AD8@PhilipOakley>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsUixO6iqPuURTLY4OAOfYvbM1uYLbqudDNZ
	NPReYbb40dLDbNE5VdaB1WPnrLvsHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4Mw6da2Ip+MhZ8WnOeuYGxlfsXYycHBICJhLztm1nhrDFJC7cW8/WxcjFISRwmVHi8psL
	jBDOWSaJ3UdOglXxCmhLNE8+AdbNIqAqMfn0T0YQm01AV2JRTzMTiC0qECyx+vIDFoh6QYmT
	M5+A2SICGhI3dt0EG8os0Mco8WX3C7BmYQEbiZtHfzFBbPvMLPFp4kk2kAQnUGJ+81KgzRxA
	94lL9DQGgZjMAuoS6+cJgVQwC8hLbH87h3kCo+AsJOtmIVTNQlK1gJF5FaNcYk5prm5uYmZO
	cWqybnFyYl5eapGuhV5uZoleakrpJkZI4IvsYDxyUu4QowAHoxIPr8ECiWAh1sSy4srcQ4yS
	HExKoryT/wGF+JLyUyozEosz4otKc1KLDzFKcDArifD6fwfK8aYkVlalFuXDpKQ5WJTEeb8t
	VvcTEkhPLEnNTk0tSC2CycpwcChJ8D5glgwWEixKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1K
	LC3JiAdFcHwxMIZBUjxAe8+DtPMWFyTmAkUhWk8x6nLcbvv1iVGIJS8/L1VKnDcUpEgApCij
	NA9uBSzNvWIUB/pYmJcPmPSEeIApEm7SK6AlTEBLovnEQZaUJCKkpBoYHfjuztdRemreaa0R
	vfKJlFfb0f0cU46s416ZfGjhFc8+C1+TfwvY/WKylwQ7/177hnv6b3GJohXvTHZU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243574>

On 03/07/2014 12:01 AM, Philip Oakley wrote:
> From: "Jeff King" <peff@peff.net>
>> On Thu, Mar 06, 2014 at 05:41:27PM +0100, Michael Haggerty wrote:
>>
>>> > We can wrap that in "git replace --convert-grafts", but I do not >
>>> think
>>> > grafts are so common that there would be a big demand for it.
>>>
>>> It's probably easier to wrap it than to explain to Windows users what
>>> they have to do.
>>
>> How would Windows users get a graft file in the first-place? There's no
>> GUI for it! ;)
> 
> Now, now... It's dead easy using the git-gui and Notepad++, you can see
> and confirm the sha1's, copy and paste, and the graft file is a very
> easy format, so even wimps (windows, icons, menus, pointers aka mouse)
> folks can do it. (It worked for me when I needed it ;-)

I didn't mean to insult all Windows users in general.  I was only
referring to the fact that since the default Windows command line is not
a POSIX shell, even an experienced Windows user might have trouble
figuring out how to execute a shell loop.  Putting this functionality in
a git command or script, by contrast, would make it work universally, no
fuss, no muss.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
