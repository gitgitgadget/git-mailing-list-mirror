From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: jn/svn-fe
Date: Fri, 13 Aug 2010 23:33:58 +0200
Message-ID: <4C65BA46.9010604@kdbg.org>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org> <4C63BD9B.6000608@viscovery.net> <20100813000848.GA8076@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 23:34:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok1tG-0000H5-7o
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 23:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab0HMVeF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 17:34:05 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:21732 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754576Ab0HMVeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 17:34:03 -0400
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 851FCCDF85;
	Fri, 13 Aug 2010 23:33:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <20100813000848.GA8076@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153511>

Am 13.08.2010 02:08, schrieb Jonathan Nieder:
> (pruned Ccs)
>
> Johannes Sixt wrote:
>> Am 8/12/2010 1:35, schrieb Junio C Hamano:
>
>>> * jn/svn-fe (2010-08-09) 10 commits
> [...]
>> This fails to build under MinGW because we don't have strtok_r() and=
 a
>> whole lot of other things that I didn't even look at. Can we have an
>> opt-in or opt-out for this?
>
> How about something like this instead?
>
> -- 8<  --
> Subject: vcs-svn: Port to Windows
>
> MSys #define-s dirent away.  Avoid trouble by avoiding that
> identifier.
>
> Windows does not have strtok_r (and while does have an identical
> strtok_s, but it is not obvious how to use it).  Grab an
> implementation from glibc.
>
> The svn-fe test fails in the =E2=80=9Csvn export=E2=80=9D step becaus=
e of the
> lack of symlink support.  With a less ambitious dump, it passes.
>
> Cc: Johannes Sixt<j6t@kdbg.org>
> Cc: Ramkumar Ramachandra<artagnon@gmail.com>
> Signed-off-by: Jonathan Nieder<jrnieder@gmail.com>

Thanks, it compiles with this patch and passes the test suite.

Acked-by: Johannes Sixt<j6t@kdbg.org>

The license, LGPL 2.1 or later is OK, I assume?

-- Hannes
