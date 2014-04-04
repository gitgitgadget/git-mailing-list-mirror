From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Patch Series v3 for "use the $( ... ) construct for command substitution"
Date: Fri, 04 Apr 2014 19:40:35 +0200
Message-ID: <vpqk3b56lik.fsf@anie.imag.fr>
References: <CA+EOSBkF+hLOab0oJH7HuUb_KKn+1sgV_Lshwupgj-_yAAfmFw@mail.gmail.com>
	<20140404172946.GI6851@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 19:40:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WW86m-0001nn-41
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 19:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbaDDRkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2014 13:40:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43480 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754008AbaDDRkp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2014 13:40:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s34HeX7w027129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 Apr 2014 19:40:33 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s34HeZPC013568;
	Fri, 4 Apr 2014 19:40:35 +0200
In-Reply-To: <20140404172946.GI6851@google.com> (Jonathan Nieder's message of
	"Fri, 4 Apr 2014 10:29:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 04 Apr 2014 19:40:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s34HeX7w027129
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1397238036.26654@WJNVCb9u4/0YZn7Lynf2Gw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245766>

Jonathan Nieder <jrnieder@gmail.com> writes:

> If the script is "obviously correct" enough then there is no need
> to manually go through 140 files after that point.

The script cannot be "obviously correct", as there are a lot of
potential corner-cases (nested `, nesting ` within ", comments, ...).

> If the only way to get this done is to actually manually review those
> 140 files, I just don't think it's worth it.

Honnestly, I went through the series once and it wasn't that painful. I
need to do a more carefull review, but using "git diff --color-words=."
it can be really fast.

Junio suggested splitting the series into batches of around 10 patches,
sending one per week, but that would make too many patches IMHO (14
weeks ...).

I'd suggest doing a first batch with only scripts that are not tests and
pushing this to git.git. Then the remaining series will be a bit less
scary.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
