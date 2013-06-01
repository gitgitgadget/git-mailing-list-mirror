From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 04/11] tests: introduce test_ln_s and test_ln_s_add
Date: Sat, 01 Jun 2013 17:06:01 +0200
Message-ID: <51AA0DD9.9030704@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org> <c7be5891891d1eeba540a5a24f07d58514345b2b.1370076477.git.j6t@kdbg.org> <CALkWK0nN2V3Cwi3n+DV7Bcme7jE=B+COFioqPFfHQgxGTWEtiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 17:06:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UinNk-0003MY-MW
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 17:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293Ab3FAPGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 11:06:08 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:43802 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751013Ab3FAPGG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 11:06:06 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C156313004B;
	Sat,  1 Jun 2013 17:06:02 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C186F19F480;
	Sat,  1 Jun 2013 17:06:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CALkWK0nN2V3Cwi3n+DV7Bcme7jE=B+COFioqPFfHQgxGTWEtiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226138>

Am 01.06.2013 13:11, schrieb Ramkumar Ramachandra:
> Johannes Sixt wrote:
>> +test_ln_s () {
>> +       if test_have_prereq SYMLINKS
>> +       then
>> +               ln -s "$1" "$2"
>> +       else
>> +               printf '%s' "$1" >"$2"
>> +       fi
>> +}
> 
> What is this?  We can't test_ln_s something and then 'git add' it, so
> what purpose does this serve?

Sure, we can 'git add' it:

# - Use test_ln_s instead of "ln -s x y" when y has been added as a
#   symbolic link entry earlier.

-- Hannes
