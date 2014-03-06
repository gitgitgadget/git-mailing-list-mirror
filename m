From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: RFC GSoC idea: git configuration caching (needs co-mentor!)
Date: Thu, 06 Mar 2014 22:33:14 +0100
Message-ID: <5318E99A.20708@alum.mit.edu>
References: <53180E40.5050308@alum.mit.edu> <xmqqtxbbxh99.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 22:33:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLfut-0006bq-2A
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 22:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbaCFVdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 16:33:19 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50414 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751645AbaCFVdS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2014 16:33:18 -0500
X-AuditID: 1207440e-f79c76d000003e2c-21-5318e99d3479
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 26.0E.15916.D99E8135; Thu,  6 Mar 2014 16:33:17 -0500 (EST)
Received: from [192.168.69.148] (p57A24A5D.dip0.t-ipconnect.de [87.162.74.93])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s26LXEXW001413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 6 Mar 2014 16:33:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqtxbbxh99.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqDv3pUSwwbLXJhZdV7qZLBp6rzBb
	XPq8ntXiR0sPswOLx8Qvx1k9nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujP8dagXb
	hSueH5rA3sB4nb+LkZNDQsBEYtKdrcwQtpjEhXvr2boYuTiEBC4zSjTun88I4ZxlknizpI8J
	pIpXQFOid/YydhCbRUBV4vzXA6wgNpuArsSinmawGlGBYInVlx+wQNQLSpyc+QTMFhFQk5jY
	dgjI5uBgFqiT+NwkCBIWFvCQmN+3CqxESCBK4szzuWAjOQWsJb4tuMAGUi4hIC7R0xgEEmYW
	0JF41/eAGcKWl9j+dg7zBEbBWUiWzUJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealF
	usZ6uZkleqkppZsYISHOt4Oxfb3MIUYBDkYlHt6ORRLBQqyJZcWVuYcYJTmYlER57zwCCvEl
	5adUZiQWZ8QXleakFh9ilOBgVhLhNT4IlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5N
	LUgtgsnKcHAoSfBOfQHUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K3vhiYPyC
	pHiA9l54DrK3uCAxFygK0XqKUZfjdtuvT4xCLHn5ealS4rwfQYoEQIoySvPgVsAS2itGcaCP
	hXkng1zCA0yGcJNeAS1hAloSzScOsqQkESEl1cDI2vtoypFzJ0U0c/tmXo/6vFWdgf+5hr7s
	odLDkg1nXvV/a6r4KcP7J/5PmJDQmS+XJt/lyggJ/dN39UfLev8TjxqPnvjiPefb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243559>

On 03/06/2014 08:24 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I just wrote up the idea that fell out of the discussion [1] about the
>> other configuration features that I proposed.  As far as I am concerned,
>> it can be merged as soon as somebody volunteers as a co-mentor.  The
>> idea is embodied in a pull request against the git.github.io repository
>> [2]; the text is also appended below for your convenience.
>>
>> Michael
>>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/242952
>> [2] https://github.com/git/git.github.io/pull/7
>>
>> ### git configuration API improvements
>>
>> There are many places in Git that need to read a configuration value.
>> Currently, each such site calls `git_config()`, which reads and parses
>> the configuration files every time that it is called.  This is
>> wasteful, because it results in the configuration files being
>> processed multiple times during a single `git` invocation.  It also
>> prevents the implementation of potential new features, like adding
>> syntax to allow a configuration file to unset a previously-set value.
>>
>> This goal of this project is to make configuration work as follows:
>>
>> * Read the configuration from files once and cache the results in an
>>   appropriate data structure in memory.
>>
>> * Change `git_config()` to iterate through the pre-read values in
>>   memory rather than re-reading the configuration files.
>>
>> * Add new API calls that allow the cache to be inquired easily and
>>   efficiently.  Rewrite other functions like `git_config_int()` to be
>>   cache-aware.
> 
> Are you sure about the second sentence of this item is what you
> want?
> 
> git_config_<type>(name, value) are all about parsing "value" (string
> or NULL) as <type>, return the parsed value or complain against a
> bad value for "name".  They do not care where these "name" and
> "value" come from right now, and there is no reason for them to
> start caring about caching.  They will still be the underlying
> helper functions the git_config() callbacks will depend on even
> after the second item in your list happens.

You're right of course.  For some reason I had it in my brain that these
functions retrieved *and* parsed values, as opposed to just parsing them.

I just fixed the text and pushed it live.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
