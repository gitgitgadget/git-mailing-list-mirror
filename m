From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] t1308: do not get fooled by symbolic links to the source
 tree
Date: Fri, 3 Jun 2016 11:19:36 +0200
Message-ID: <57514BA8.7020207@web.de>
References: <xmqqzir53mdc.fsf@gitster.mtv.corp.google.com>
 <712e0755-6008-21f5-0ee6-25ed9d97fd45@web.de>
 <xmqq1t4ftheu.fsf@gitster.mtv.corp.google.com>
 <xmqqwpm7s2ex.fsf@gitster.mtv.corp.google.com>
 <20160602213920.GA13356@sigill.intra.peff.net>
 <xmqqeg8fs0dw.fsf_-_@gitster.mtv.corp.google.com> <57511E44.1090708@kdbg.org>
 <20160603061023.GA7687@sigill.intra.peff.net> <57512980.1070200@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 11:20:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8lGw-0002hl-Ja
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 11:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbcFCJUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 05:20:01 -0400
Received: from mout.web.de ([212.227.15.3]:65404 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbcFCJT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 05:19:58 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MNt4V-1b6qG70pDf-007Wtf; Fri, 03 Jun 2016 11:19:40
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <57512980.1070200@kdbg.org>
X-Provags-ID: V03:K0:6cQDu5N5UV7VUuluMYOt9JlL9LjRsA5yF6bpzEAWc3zD6tX/9Lk
 QfnopgSJGz/XXjq3IQs9NvO4yhZhlR4TTzz5UeIiJHWVbKs12brmESUy9KZxPXtP6d17KMY
 zk/SpxrioCDb5mCYTbPqkMI9XQ65JarOj6fWwEwpF79gX2UVeVqOKcz5NE57G4wsOnMDkdY
 +vRpa0nSCTtojn7T7+08Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ThnEI9eEDhs=:8ZouBQHYS26qb1FsJehEOa
 aquiOV+wLJYohi/YtF5qHMWZ1PokfhCCFg5ZHKRCCcMQWq5XRwsGfEvYYcMiYvYaYzfkOAmdT
 Nq/RA99C2s9EHHmAuMlRKdscPbfVBCb8BIwWY6mH7ZdbzlSH9p6hTbuHKSfMmQojjDiAN2thY
 bArwpQJB/8LzVoQDCj7+b8p6BV22k6spSFJPIhLFjcDanqffWCzNgPUvPIj4cBevWTofUY/rU
 HmYwMbuH1D0fVG9s70mAXS4zsnVz0r1pYKYCUhG7O+BuHcIJvkp3Xjy8ddFYeODI3MNcz2V39
 3UCCmEKEx9sW9YAlvpIyjPmvFHm4kyJljhw3xxoyt8WI1iv1qKo0a0mEMRrxQeBXtfHJz21HD
 3AkJa6C3FLxc1RrhETOcACKPzODcPk3EBjllvW4xZnOZLYb3Q13kQffcgnGNWKkIagAw8Wp1Z
 xJ1US+Fy6HQehO0BRpT8T8dZhOYGwIdtPMFedXbtmmegXXHSK2KnbgWfsutSrBb6l2Nboc1hb
 Md8wg6U+ZcXoZlGgbwesHPXR5Mf3iVFhOAI4aTz3HZUWxxZX6wJp/O8qX0sWGUMnvlHLalf6T
 R1vHtwjJ4ne8NdUq/iFEAom7f2vVUfZ4iO5+jvcJVYqfwMFlwT3sJLKxcI71Tsc3nJbUwRDGR
 2BGu5Fae4hfQcojS4KclwsaM8y0TxCdkF43jfOcGngoykCtJ7KrgPq61T/7pr/A8hqkObBR1q
 qR/4GOCQfogguYhifXhrNWuMhxHCmXPUN/WhIrbz8gMnyqteLbzuF3NVFSFoT+Cdx7h76Tf6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296293>

On 06/03/2016 08:53 AM, Johannes Sixt wrote:
> Am 03.06.2016 um 08:10 schrieb Jeff King:
>> On Fri, Jun 03, 2016 at 08:05:56AM +0200, Johannes Sixt wrote:
>>
>>>> -    name=$(pwd)/.gitconfig
>>>> +    name=$HOME/.gitconfig
>>>
>>> I haven't tested this, yet, but my guess is that this breaks on 
>>> Windows:
>>> test-config will produce C:/foo style path, but the updated test would
>>> expect /c/foo style path. Dscho, do you have an idea how to fix this?
>>
>> Hmm. This should come directly from expand_user_path("~/.gitconfig")
>> which prepends the literal contents of the $HOME variable. It does go
>> through convert_slashes() afterwards, but I don't see any other
>> massaging (but I won't be surprised when you tell me there is some that
>> happens behind the scenes).
>
> Yes, it happens behind the scenes: /c/foo absolute paths are a 
> convention used by the POSIX emulation layer (MSYS). When bash (an 
> MSYS program) runs a non-MSYS program such as git or test-config, it 
> converts the /c/foo paths in the environment (and argument list) to 
> c:/foo style because the non-MSYS programs do not understand the MSYS 
> convention.
>
> -- Hannes
Compiling pu didn't succed:
unix_stream_connect is missing in read_cache.c

(And many more in index-heloer.c)

(I thought that the index-helper is only compiled on systems,
   which are known to have unix-sockets and other stuff ?)

After patching that out,  t1308 fails:
-name=/c/
+name=c:/
