From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git ls-files -o seems to ignore .gitignore
Date: Mon, 27 Oct 2014 09:31:56 +0100
Message-ID: <vpq8uk1lxqb.fsf@anie.imag.fr>
References: <544DE351.9060800@netbsd.org>
	<20141027064747.GA7773@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Richard PALO <richard@netbsd.org>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Oct 27 09:32:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xifir-0001aC-73
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 09:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbaJ0IcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 04:32:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49925 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbaJ0IcM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 04:32:12 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s9R8VuAC001769
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Oct 2014 09:31:56 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s9R8Vum2005268;
	Mon, 27 Oct 2014 09:31:56 +0100
In-Reply-To: <20141027064747.GA7773@hashpling.org> (Charles Bailey's message
	of "Mon, 27 Oct 2014 06:47:47 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 27 Oct 2014 09:31:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s9R8VuAC001769
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1415003518.04486@+zyM5bkWFpbPUGr5hbqTzQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charles Bailey <charles@hashpling.org> writes:

> On Mon, Oct 27, 2014 at 07:16:49AM +0100, Richard PALO wrote:
>> Hash: SHA1
>> 
>> I'm having an issue in that 'git ls-files -o' seems to ignore
>> [parts of] .gitignore whereas other commands, such as 'git status'
>> seem fine.
>
> This is, as far as I am aware, by design.

I would not call that "by design", but indeed "git ls" was written this
way, and it's a plumbing command for which we do not want
backward-incompatible changes. So, --exclude-standard is available, but
not activated by default.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
