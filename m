From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Mon, 16 Jul 2012 18:38:31 +0200
Message-ID: <50044387.8080607@alum.mit.edu>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu> <500439F1.2040409@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <mbranchaud@xiplink.com>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Mon Jul 16 18:45:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqoQa-0001oX-MQ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 18:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665Ab2GPQpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 12:45:40 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:59714 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753498Ab2GPQpg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2012 12:45:36 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2012 12:45:36 EDT
X-AuditID: 1207440e-b7f036d0000008b5-6d-50044389a16e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id C1.BB.02229.98344005; Mon, 16 Jul 2012 12:38:33 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q6GGcW0T030090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 16 Jul 2012 12:38:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <500439F1.2040409@xiplink.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsUixO6iqNvpzBJg0DzbxOL40+ssFl1Xupks
	Vs64wWjR+KTIYvXjO+wOrB47Z91l9/i8Sc7jwOXHbAHMUdw2SYklZcGZ6Xn6dgncGV8ftrEX
	zFWpmHR/NksD4yeZLkZODgkBE4m1f84zQ9hiEhfurWfrYuTiEBK4zCjx+8sRZgjnOJPEw6m/
	WUGqeAW0JR7f+8kCYrMIqErsenyNCcRmE9CVWNTTDGRzcIgKhElM38kOUS4ocXLmExaQsIiA
	hMSDl/4gI5kF5jNKbHp/FGyxsICzxMo5O8DGCAkkSWx4uRZsPCfQqs3Ns1lBepkFrCW+7S4C
	CTMLyEtsfzuHeQKjwCwkG2YhVM1CUrWAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5m
	iV5qSukmRkgo8+1gbF8vc4hRgINRiYf3hg1LgBBrYllxZe4hRkkOJiVR3qWOQCG+pPyUyozE
	4oz4otKc1OJDjBIczEoivI32QDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpis
	DAeHkgSvMDBmhQSLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBURpfDIxTkBQP0N7N
	TiB7iwsSc4GiEK2nGO05rj28dYuR48kXELlg1z0g2f0FSAqx5OXnpUqJ8z4EaRMAacsozYNb
	CkturxjFgWEgzDsfpIoHmBjhZr8CWssEtNayhAlkbUkiQkqqgTFlgdhex/BFrWkXZymzdYbv
	Zv0effqrWJnBgh23AnaZ1GaHSj658YZ9osN1YcV5M9jVN9Qe/9Fqw3VzJqNmwMNp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201529>

On 07/16/2012 05:57 PM, Marc Branchaud wrote:
> On 12-07-14 02:59 AM, mhagger@alum.mit.edu wrote:
>> * Various changes to the format of the notification emails:
>>
>>    * List commits in chronological (rather than topological) order.
>
> I'm not sure this is a good idea.  Topological order ensures that the commits
> apply in the order they're presented.  If you're attached to chronological
> ordering, perhaps make this configurable?

I should have been more accurate.  The output is not, strictly speaking, 
in chronological order; rather, it is in "--reverse" topological order 
(which is approximately chronological).  Perhaps this should be called 
"causal" order :-)

The old script listed the commits in default "git log" order, which I 
believe is called topological order, and is approximately 
reverse-chronological.

>> This script does not support the "hooks.showrev" configuration option.
>
> This is pretty much the only downside.  We use hooks.showrev to insert a link
> to our gitweb for each commit.

I thought of hooks.showrev as mostly a poor-man's way of generating 
commit diffs, and that is why I didn't add support for it.  But your use 
case is indeed interesting.

Maybe you could be more specific about what kinds of places in the 
emails you would like to add links, and how you like the links to look, 
to give me the idea of what you want.  I'm sure we can find a way to add 
it to the script.

> I'd be OK with dropping support for hooks.showrev if there was some other way
> to add extra info to the commit email.  Perhaps another template string after
> REVISION_HEADER_TEMPLATE, one that's empty by default?

ISTM that you could already just append your special content to 
REVISION_HEADER_TEMPLATE rather then having to add a new template:

     import sys, post_receive_multimail
     post_receive_multimail.REVISION_HEADER_TEMPLATE += """..."""
     post_receive_multimail.main(sys.argv[1:])

And I plan to make the template strings even easier to customize (see 
below).

>> [3] When announcing a new annotated tag, post-receive-mail lists *all*
>>      of the commits since the previous annotated tag.  I found such
>>      emails rather confusing than useful, so I omitted this feature.
>
> I actually like that aspect of the current script.  Another configuration
> flag, maybe?

Yes, I don't think it would be so hard to retrofit this behavior into 
the script.  Actually, I think I would teach it how to generate *two* 
emails for annotated tags:

* one in the new script's current minimalist style, sent to the
   "hooks.refchangelist" email addresses

* a second in the longer style of the old script, sent to the
   "hooks.announcelist" email addresses (only if configured)

People could add themselves to one mailing list or the other, depending 
on what they prefer.  Other suggestions are welcome.

> As a replacement for the current script, I think this is great.  One thing
> that I think would help make it more maintainable is to have it read template
> strings from a file, so that people can customize templates without changing
> the script itself.  It would also help to document all the allowed template
> variables.  You might also consider expanding the templates to cover all
> strings that might appear in the emails, as that would basically
> internationalize the code and let people create translations.
>
> Similarly, it would be good for folks who write their own Environments to
> also be able to use a separate file instead of modifying the script itself.

We seem to be on the same wavelength; these are all things that I have 
planned under the rubric of "improved configurability".  My tentative 
plan is to support two modes of use:

1. Use the script directly as a post-receive hook, to be executed 
directly as a program, configurable only via configuration settings

2. Write a short post-receive hook that imports 
post-receive-multimail.py as a Python module.  The calling script would 
be able to affect the script's behavior at a deeper level by, for 
example, defining a new Environment class or changing the template 
strings, then it would call a function in the module to do the real 
work.  See above for a trivial example.

> Thanks again -- this is good work!

Thanks for the feedback.  If you want to get involved, please let me 
know...having more than one contributor would undoubtedly help the 
script's chances of being accepted into the git project.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
