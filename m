From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 5/5] diff: activate diff.renames by default
Date: Thu, 25 Feb 2016 09:54:12 +0100
Message-ID: <vpqwppt5fwr.fsf@anie.imag.fr>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456249498-3232-6-git-send-email-Matthieu.Moy@imag.fr>
	<20160224104203.GD21152@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 09:54:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYrh2-0004Q2-8x
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 09:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760236AbcBYIy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 03:54:27 -0500
Received: from mx2.imag.fr ([129.88.30.17]:35897 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759232AbcBYIyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 03:54:25 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8sC5M015649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 09:54:12 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8sC9x010815;
	Thu, 25 Feb 2016 09:54:12 +0100
In-Reply-To: <20160224104203.GD21152@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 24 Feb 2016 05:42:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 25 Feb 2016 09:54:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1P8sC5M015649
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456995256.11178@AlMGSGxaTqPcYURP7f0NJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287346>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 23, 2016 at 06:44:58PM +0100, Matthieu Moy wrote:
>
>> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
>> index 1acd203..fdf5a79 100644
>> --- a/Documentation/diff-config.txt
>> +++ b/Documentation/diff-config.txt
>> @@ -111,7 +111,7 @@ diff.renames::
>>  	Whether and how Git detects renames.  If set to "false",
>>  	rename detection is disabled. If set to "true", basic rename
>>  	detection is enable.  If set to "copies" or "copy", Git will
>> -	detect copies, as well.  Defaults to false.
>> +	detect copies, as well.  Defaults to true.
>
> I wonder if we need to talk about plumbing versus porcelain here, as it
> does not default to true for diff-tree, for example. But I guess that is
> already the case (even setting it to true yourself does not affect
> diff-tree).

Yes, it was already the case. But it doesn't harm to document it while
we're there. I've added this in v2:

        Note that this
	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
	linkgit:git-log[1], and not lower level commands such as
	linkgit:git-diff-files[1].

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
