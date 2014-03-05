From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC 2/3] merge: Add hints to tell users about "git merge --abort"
Date: Wed, 05 Mar 2014 19:35:49 +0100
Message-ID: <vpqbnxkebne.fsf@anie.imag.fr>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<1393437985-31401-3-git-send-email-andrew.kw.w@gmail.com>
	<20140226203836.GM7855@google.com>
	<CADgNjak3aqPDV0iZYc8b6QJ9y+6bUd28n0UJOm6WjufQhjfuwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 19:36:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLGff-0000Z3-3s
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 19:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbaCESfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 13:35:55 -0500
Received: from mx1.imag.fr ([129.88.30.5]:40327 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbaCESfy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 13:35:54 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s25IZlUn028575
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Mar 2014 19:35:47 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s25IZnoT022245;
	Wed, 5 Mar 2014 19:35:49 +0100
In-Reply-To: <CADgNjak3aqPDV0iZYc8b6QJ9y+6bUd28n0UJOm6WjufQhjfuwA@mail.gmail.com>
	(Andrew Wong's message of "Wed, 5 Mar 2014 10:30:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 05 Mar 2014 19:35:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s25IZlUn028575
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394649349.15046@uDLM4RQYwI0gNH3coeX7Kg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243459>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> On Wed, Feb 26, 2014 at 3:38 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Andrew Wong wrote:
>>
>>> --- a/builtin/merge.c
>>> +++ b/builtin/merge.c
>>> @@ -909,7 +909,8 @@ static int suggest_conflicts(int renormalizing)
>>> +                     "fix conflicts and then commit the result.\n"
>>> +                     "To abort the merge, use \"git merge --abort\".\n"));
[...]
> This means contexts are no longer only about "resolving conflict", so
> I was thinking of renaming advice.resolveConflict to something like
> advice.mergeHints.
>
> Any thoughts?

If the advice suggests merge --abort, then why not advice.abortMerge ?

But mergeHints makes sense to me also, as it would potentially encompass
more cases.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
