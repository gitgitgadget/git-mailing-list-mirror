From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG?] HEAD detached at HEAD
Date: Fri, 18 Sep 2015 19:23:50 +0200
Message-ID: <vpqeghviqu1.fsf@anie.imag.fr>
References: <vpqk2rnirz0.fsf@anie.imag.fr>
	<CA+P7+xoeXiZd=WU460Xfjthe0U5BnAV69_KNKW39p10ZGLHx7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 19:24:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZczOA-0006Vw-3Q
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 19:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbbIRRXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 13:23:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38670 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbbIRRXx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 13:23:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8IHNmJV023390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 18 Sep 2015 19:23:48 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8IHNoGp016973;
	Fri, 18 Sep 2015 19:23:50 +0200
In-Reply-To: <CA+P7+xoeXiZd=WU460Xfjthe0U5BnAV69_KNKW39p10ZGLHx7g@mail.gmail.com>
	(Jacob Keller's message of "Fri, 18 Sep 2015 10:08:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 18 Sep 2015 19:23:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8IHNmJV023390
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443201828.67707@oYnBJ4k82p7aUcC8HRODYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278210>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Fri, Sep 18, 2015 at 9:59 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> I'm getting it even if there's a tag and/or a branch pointing to the
>> same commit.
>>
>> Any idea what's going on?
>
> Any chance you accidentally made a branch or tag named HEAD?

Nice try ;-), but no:

$ git status   
HEAD detached at HEAD
nothing to commit, working directory clean

$ git for-each-ref
16aa1796fb487fc7178ceef0525fed80284a4c52 commit	refs/heads/master
16aa1796fb487fc7178ceef0525fed80284a4c52 commit	refs/tags/foo

$ git rev-parse HEAD
16aa1796fb487fc7178ceef0525fed80284a4c52

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
