From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Thu, 22 Jan 2015 16:49:31 +0100
Message-ID: <54C11C0B.6080200@alum.mit.edu>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>	<cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de>	<xmqqzjavgym5.fsf@gitster.dls.corp.google.com>	<alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>	<xmqq38878gao.fsf@gitster.dls.corp.google.com>	<alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info>	<xmqqtx0n710m.fsf@gitster.dls.corp.google.com>	<alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>	<xmqqppbb6zx9.fsf@gitster.dls.corp.google.com>	<alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info>	<xmqqmw6e499u.fsf@gitster.dls.corp.google.com>	<alpine.DEB.1.00.1412231736490.21312@s15462909.onlinehome-server.info> <xmqqa92e47ap.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Tanay Abhra <tanayabh@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 22 16:49:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEK14-0000uI-TU
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 16:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbbAVPtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 10:49:49 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:61022 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753280AbbAVPtq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 10:49:46 -0500
X-AuditID: 12074411-f79fa6d000006b8a-26-54c11c0fd858
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 77.7F.27530.F0C11C45; Thu, 22 Jan 2015 10:49:35 -0500 (EST)
Received: from [192.168.69.130] (p5DDB02C5.dip0.t-ipconnect.de [93.219.2.197])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t0MFnWVs019782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 22 Jan 2015 10:49:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <xmqqa92e47ap.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqMsvczDE4HaLvEXXlW4mi4beK8wW
	/cu72Cx+XXjP7MDisXPWXXaPDx/jPC5eUvb4vEkugCWK2yYpsaQsODM9T98ugTtj/5ou9oLD
	xhXr52k1MC7S7GLk5JAQMJHYef0UC4QtJnHh3nq2LkYuDiGBy4wSS3ousUI455gk9v5cywRS
	xSugLTHh3WRGEJtFQFVixbdVYN1sAroSi3qawWpEBYIkrrRsZoaoF5Q4OfMJWI2IQKLEtLZL
	YDazgKXEqTUXweYIC7hIdE99ArW5n01i/sI9YAlOAWuJjdc+skM06EnsuP6LFcKWl2jeOpt5
	AqPALCQ7ZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXVO93MwSvdSU0k2MkHAW
	3ME446TcIUYBDkYlHl6BwgMhQqyJZcWVuYcYJTmYlER5u0QPhgjxJeWnVGYkFmfEF5XmpBYf
	YpTgYFYS4S0UBsrxpiRWVqUW5cOkpDlYlMR5+Zao+wkJpCeWpGanphakFsFkZTg4lCR4N0kB
	NQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYjW+GBitICkeoL1M0iB7iwsSc4Gi
	EK2nGBWlxHn3g8wVAElklObBjYUlqVeM4kBfCvNeAaniASY4uO5XQIOZgAYXbD8AMrgkESEl
	1cDIVGt+YkXY6wfi6zPqTFMTTnsaddUU7hPZpfF4d3RIRoV1/hT3BD6uqAQtuWrFyHSZBYe7
	n4vePWXvVr5bbv/t1pCFnJcj52povqt7mtw+o0jSj19Ecq72/Yv2T3iiVJcGv370 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262841>

On 12/23/2014 06:14 PM, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> On Tue, 23 Dec 2014, Junio C Hamano wrote:
>>> I suspect that it would be much better if the configuration variables
>>> were organized the other way around, e.g.
>>>
>>> 	$ git config fsck.warn missingTagger,someOtherKindOfError
>>
>> I had something similar in an earlier version of my patch series, but it
>> was shot down rightfully: if you want to allow inheriting defaults from
>> $HOME/.gitconfig, you have to configure the severity levels individually.
> 
> Hmmm.  What's wrong with "fsck.warn -missingTagger" that overrides
> the earlier one, or even "fsck.info missingTagger" after having
> "fsck.warn other,missingTagger,yetanother", with the usual "last one
> wins" rule?
> 
> Whoever shot it down "rightfully" is wrong here, I would think.

Sorry I didn't notice this earlier; Johannes, please CC me on these
series, especially the ones that I commented on earlier.

I might have been the one who "shot down" the "<severity>=<name>" style
of configuration [1].

I don't feel strongly enough to make a big deal about this, especially
considering that the other alternative has already been implemented. But
for the record, let me explain why I prefer the "<name>=<severity>"
style of configuration.

First, it is a truer representation of the data structure within the
software, which is basically one severity value for each error type.
This is not a decisive argument, but it often means that there is less
impedance mismatch between the style of configuration and the concepts
that it is configuring. For example,

    $ git config receive.fsck.warn A,B,C
    $ git config receive.fsck.error C,D,E

seems to be configuring two sets, but it is not. It is mysteriously
setting "C" to be an error, in seeming contradiction of the first line [2].

Second, it is not correct to say that this is just an application of the
"last setting wins" rule. The "last setting wins" rule has heretofore,
as far as I know, only covered *single* settings that take a single
value. If we applied that rule to the following:

    $ git config receive.fsck.warn A,B,C
    $ git config receive.fsck.warn B,F

then the net result would be "B,F". But that is not your proposal at
all; your proposal is for these two settings to be interpreted the same as

    $ git config receive.fsck.warn A,B,C,F

Similarly, the traditional last setting rule, applied to the first
example above, wouldn't cause the value of "fsck.warn" to be reduced to
"A,B", as you propose. This is not the "last setting rule" that we are
familiar with--it operates *across and within* values and across
*multiple* names rather than just across the values for a single name.

Third, the "<severity>=<name>" style is hard to inquire via the command
line, and probably also incompatible with the simplified internal config
API in git (and probably libgit2, JGit, etc). The problem is that
determining a *single* setting requires *three* configuration variables
be inquired, and that the settings for those three variables need to be
processed in the correct order, including the correct order of
interleavings. For example, how would you inquire about the configured
severity level of "missingTaggerEntry" using the shell? It would be a
mess that would necessarily have to involve "git config --get-regexp"
and error-prone parsing of comma-separated values. It would be so much
easier to type

    $ git config receive.fsck.missingtaggerentry

Fourth, the "<severity>=<name>" style would cause config files to get
cluttered up with unused values. Suppose you have earlier run

    $ git config receive.fsck.warn A,B,C
    $ git config receive.fsck.ignore D,E

and now you want to demote "B" to "ignore". You can do

    $ git config --add receive.fsck.ignore B

(don't forget "--add" or you've silently erased other, unrelated
settings!) This gives the behavior that you want. But now your config
file looks like

    [receive "fsck"]
            warn = A,B,C
            ignore = D,E
            ignore = B

The "B" on the first line is now just being carried along for no reason,
but it would be quite awkward to clean it up programmatically.
Effectively, these settings can only be added to but never removed
because of the way multiple properties are mashed into a single setting.


I believe that one of the main arguments for the "<severity>=<name>"
style of configuration is that it carries over more easily into
convenient command-line options. But I think it will be unusual to want
to configure these options by hand on the command line, let alone adjust
many settings at the same time. The idea isn't to make it easy to work
with repositories that have a level of breakage that fluctuates over
time. It is to make it possible to work with *specific* repositories
that have known breakage in their history. For such a repo you would
configure one or two "ignore" options one time and then never adjust
them again. (And it will also allow us to make our checks stricter in
the future without breaking existing repositories, and even to add
optional "policy" checks, like "forbid Windows-incompatible filenames".)

I would even go so far as to say that we don't *need* command-line
option versions of these settings; if somebody really needs that they
can type

    $ git -c receive.fsck.missingtaggerentry=ignore fsck

(which also has the advantage of passing the setting through to any
child processes). But *if* command-line options are considered
necessary, I don't think that using a "<name>=<severity>" style within
the config needs to rule out allowing command-line options in the form
"--<severity>=<name>,<name>" as Junio has suggested.

Looking back at this email, I guess that I'm more strongly against the
"<name>=<severity>" configuration style than I thought :-/

Michael

[1] I prefer to think that I just offered a little gentle discussion
that informed Johannes's independent decision :-)

[2] But even on these terms, it is anomalous. The usual git way to
configure a set in git would be

    $ git config receive.fsck.warn A
    $ git config --add receive.fsck.warn B
    $ git config --add receive.fsck.warn C
    $ git config receive.fsck.error C
    $ git config --add receive.fsck.error D
    $ git config --add receive.fsck.error E

, which in fact has fewer of the disadvantages listed in this email.

-- 
Michael Haggerty
mhagger@alum.mit.edu
