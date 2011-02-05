From: Rafael Kitover <rkitover@io.com>
Subject: Re: ignoring file modes completely
Date: Sat, 05 Feb 2011 11:09:26 -0500
Organization: CPAN
Message-ID: <4D4D7636.7090608@io.com>
References: <4D4D6BC2.90101@io.com> <1296921829.5467.1.camel@localhost.localdomain>
Reply-To: rkitover@io.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 17:10:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plkhz-0005WR-8h
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 17:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab1BEQJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 11:09:51 -0500
Received: from smtp.prismnet.com ([209.198.128.91]:55063 "EHLO
	smtp.prismnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab1BEQJu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 11:09:50 -0500
Received: from [127.0.0.1] (c-76-98-235-160.hsd1.pa.comcast.net [76.98.235.160])
	(authenticated bits=0)
	by smtp.prismnet.com (8.14.4/8.14.4) with ESMTP id p15G9mg7005771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 5 Feb 2011 10:09:49 -0600 (CST)
	(envelope-from rkitover@io.com)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <1296921829.5467.1.camel@localhost.localdomain>
X-Spam-Status: No, score=0.0 required=10.0 tests=RDNS_DYNAMIC
	autolearn=disabled version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on smtp.prismnet.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166100>

On 2/5/2011 11:03 AM, Jared Hance wrote:
> On Sat, 2011-02-05 at 10:24 -0500, Rafael Kitover wrote:
>> Hello,
>>
>> I found the core.filemode option, which ignores executable bits, but I
>> need an option to ignore all mode differences, and such an option does
>> not seem to exist.
>
> The only mode tracked by Git is the executable bit, so this shouldn't
> even be an issue. Are you sure the executable bit isn't the problem?
>
$ git config --global core.filemode
false

Output of "git diff HEAD" :

diff --git a/Makefile.PL b/Makefile.PL
old mode 100755
new mode 100644
diff --git a/t/02ads.t b/t/02ads.t
old mode 100755
new mode 100644
diff --git a/t/02cxn.t b/t/02cxn.t
old mode 100755
new mode 100644
diff --git a/t/04os.t b/t/04os.t
old mode 100755
new mode 100644
...
...
