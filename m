From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Mon, 16 Jul 2012 00:45:13 +0200
Message-ID: <500347F9.3040005@alum.mit.edu>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu> <7v1ukd5wis.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 00:52:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqXft-0006p5-Sl
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 00:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736Ab2GOWwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 18:52:20 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:51331 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750955Ab2GOWwS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2012 18:52:18 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Jul 2012 18:52:18 EDT
X-AuditID: 12074414-b7f846d0000008b8-85-500347fc1b5e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 30.AB.02232.CF743005; Sun, 15 Jul 2012 18:45:16 -0400 (EDT)
Received: from [192.168.69.140] (p57A25BFA.dip.t-dialin.net [87.162.91.250])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q6FMjEjs022325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 15 Jul 2012 18:45:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <7v1ukd5wis.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqPvHnTnA4PB9KYvjT6+zWHRd6Way
	aOi9wmyx+vEddgcWj52z7rJ7XLyk7PF5k1wAcxS3TVJiSVlwZnqevl0Cd8aEdV9ZC34LV/w7
	OI2pgfEjfxcjJ4eEgInEx6eLGCFsMYkL99azdTFycQgJXGaUODD7KTOEc4ZJYsPiD2BVvALa
	Eu9n/GYGsVkEVCUO337MDmKzCehKLOppZupi5OAQFQiTmL6THaJcUOLkzCcsILaIgJrExLZD
	YDazQK5E650rTCC2sICzxMo5O8BsIaB4+4PFYOM5BcwkWq9MZQQZySxgLfFtdxFEq7zE9rdz
	mCcwCsxCsmEWQtUsJFULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFula6OVmluilppRuYoQE
	sMgOxiMn5Q4xCnAwKvHwCokxBQixJpYVV+YeYpTkYFIS5WVwZg4Q4kvKT6nMSCzOiC8qzUkt
	PsQowcGsJMIrDJLjTUmsrEotyodJSXOwKInzflus7ickkJ5YkpqdmlqQWgSTleHgUJLgLQVG
	qpBgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KErji4FxCpLiAdo7AaSdt7ggMRco
	CtF6itGYY8Gue7cYObq/AEkhlrz8vFQpcV4/kFIBkNKM0jy4RbDU9YpRHOhvYd5wkCoeYNqD
	m/cKaBUT0CrLEiaQVSWJCCmpBsZVh94eu/f/3JJee+fQysverd+/6709mBA6eerarrAHN625
	20rE1byuHfw4e/c37e1eByPuPhEpO/LqTEhue9yPCzETXqiHrtrpej88yOtVwqNt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201488>

On 07/15/2012 09:11 AM, Junio C Hamano wrote:
> mhagger@alum.mit.edu writes:
>> Add a new Python script, contrib/hooks/post-receive-multimail.py, that
>> can be used to send notification emails describing pushes into a git
>> repository.  This script is derived from
>> contrib/hooks/post-receive-mail, but has many differences, including:
>
> The new script (I didn't read it at all) may be useful to some
> people, but I'm fairly negative on adding 47 different "I know there
> is something in contrib/, I looked at it, but I didn't bother
> updating it to fill my needs and wrote a new one instead" at this
> point to my tree.

I understand your concern.

> It is a different matter if the patch was to replace the existing
> one, saying "the users of the old script can use this one, which is
> backward compatible with respect to the external interface such as
> command line, or configuration variables used".  Instead of a total
> backward compatibility, "here is a script to migrate the existing
> set of configuration variables so that users of the old script can
> run it once, and start using this new one" is also perfectly fine.
>
> Such an enhancement, especially if the rewritten result is cleaner
> and easier to enhance going forward than the original, would be very
> much appreciated.

I didn't originally put the new script forward as a replacement for the 
old one mainly because it seems that Python is relatively unwelcome in 
the git project.  But if the use of Python doesn't disqualify it, then 
yes, I think the new script (with a little more work) will be a worthy 
replacement for the old shell script.

The new script is already mostly compatible with the old one:

* It accepts the same command-line arguments and uses most of the same 
configuration variables.

* It is possible to configure the new script to send only the refchange 
summary emails and skip sending the emails for individual commits, 
though I would want to put some work into supporting this mode better.

* I tested the earliest versions of the new script by verifying that its 
output was identical to that of the shell script.  (Of course the output 
is no longer identical; I claim that it is now better :-) .)

So I think it would be quite possible to touch up the new script to make 
it a drop-in replacement for the old one, and I am willing to do so.  If 
I understand correctly that there is a non-negligible chance of this 
happening, then I will continue working towards that goal.

Michael
