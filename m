From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to prevent empty git commit --amend
Date: Wed, 14 Jan 2015 13:45:31 +0100
Message-ID: <vpqvbk9a5uc.fsf@anie.imag.fr>
References: <CA+iO_8mLsdsf1PepiB4M9jJh7pX8brqPdiwAvWGMdfYO0YKrCQ@mail.gmail.com>
	<vpqzj9lfzqg.fsf@anie.imag.fr>
	<CA+iO_8nmrw7SiXWS22VcEHObQDJYDwKqRPariAmv5DzUvzAdsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Ivo Anjo <ivo.anjo@ist.utl.pt>
X-From: git-owner@vger.kernel.org Wed Jan 14 13:45:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBNKP-0008UC-2X
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 13:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbbANMpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 07:45:36 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36606 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbbANMpf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 07:45:35 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t0ECjULb029900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Jan 2015 13:45:30 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t0ECjVvT013097;
	Wed, 14 Jan 2015 13:45:31 +0100
In-Reply-To: <CA+iO_8nmrw7SiXWS22VcEHObQDJYDwKqRPariAmv5DzUvzAdsQ@mail.gmail.com>
	(Ivo Anjo's message of "Wed, 14 Jan 2015 12:15:16 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Jan 2015 13:45:30 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t0ECjULb029900
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1421844331.54025@nuazx0DdzMCm1MWDoKoWEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262383>

Ivo Anjo <ivo.anjo@ist.utl.pt> writes:

> Hello,
>
> On Wed, Jan 14, 2015 at 10:00 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> [alias]
>>         amend = !git diff --staged --quiet || git commit --amend
>>
>> and then use "git amend".
>
> Genius! This is exactly what I wanted, thanks!

You probably want to tweak the alias by adding a && echo "Nothing to
commit, sorry" (or an if/then/fi) after git diff to get the appropriate
error message though.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
