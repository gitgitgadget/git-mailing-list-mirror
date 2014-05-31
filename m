From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git-multimail: migration: Config is not iterable
Date: Sat, 31 May 2014 16:59:45 +0200
Message-ID: <5389EE61.9060108@alum.mit.edu>
References: <20140529142208.GB27005@azat>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Azat Khuzhin <a3at.mail@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 17:00:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqklF-00029n-5e
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 16:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbaEaO7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2014 10:59:49 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59025 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751001AbaEaO7s (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 May 2014 10:59:48 -0400
X-AuditID: 12074412-f79ba6d000000bc2-f6-5389ee6455ee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id CD.BC.03010.46EE9835; Sat, 31 May 2014 10:59:48 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97BB9.dip0.t-ipconnect.de [79.201.123.185])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4VExk7e003151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 31 May 2014 10:59:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140529142208.GB27005@azat>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqJvyrjPY4M1zTotPXReZLLqudDNZ
	NPReYbaY1/KF2YHFY+esu+weFy8pe3zeJBfAHMVtk5RYUhacmZ6nb5fAnfHnTU3BTZ6KXdeu
	MjUw7ubqYuTgkBAwkTg1TbqLkRPIFJO4cG89WxcjF4eQwGVGiYX/YJwLTBIn9/1iAqniFdCW
	eDd5OpjNIqAq0dvZxQZiswnoSizqaWYCGSoqECTx56wiRLmgxMmZT1hAbBEBa4lDyyHKmQU8
	JNafuMkOYgsL2ErsW3WBFcQWEtCUeLx/P9h4TgEtifuH1jFD3Cku0dMYBNGqI/Gu7wEzhC0v
	sf3tHOYJjIKzkGybhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNK
	NzFCwlpoB+P6k3KHGAU4GJV4eB1mdAQLsSaWFVfmHmKU5GBSEuVNnN4ZLMSXlJ9SmZFYnBFf
	VJqTWnyIUYKDWUmEd8pLoBxvSmJlVWpRPkxKmoNFSZz352J1PyGB9MSS1OzU1ILUIpisDAeH
	kgTvtLdAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGg2I0vBkYvSIoHaK8SSDtv
	cUFiLlAUovUUo6KUOG/3G6CEAEgiozQPbiwsWb1iFAf6Uph3Nkg7DzDRwXW/AhrMBDT4bRXY
	4JJEhJRUA6PlBkXxE184eq9MYXq932WBqG7b5vxzoVsDX2d+v/np4ZMIBb6TASc8xaJabqcl
	HbudIsHSskfOtGiS6Tad6eufO89JTaw5yv1KNWrD/5dMUQ0vkxN5ju3lffq/mcn5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250510>

On 05/29/2014 04:22 PM, Azat Khuzhin wrote:
> Using the latest version of git-multimail there is an issue with
> migration:
> 
> $ ~azat/git-multimail/git-multimail/migrate-mailhook-config --overwrite
> Traceback (most recent call last):
>   File "/home/azat/git-multimail/git-multimail/migrate-mailhook-config", line 271, in <module>
>     main(sys.argv[1:])
>   File "/home/azat/git-multimail/git-multimail/migrate-mailhook-config", line 268, in main
>     migrate_config(strict=options.strict, retain=options.retain, overwrite=options.overwrite)
>   File "/home/azat/git-multimail/git-multimail/migrate-mailhook-config", line 159, in migrate_config
>     if not _check_old_config_exists(old):
>   File "/home/azat/git-multimail/git-multimail/migrate-mailhook-config", line 66, in _check_old_config_exists
>     if name in old:
> TypeError: argument of type 'Config' is not iterable
> 
> Tested on 2.6 and 2.7 python versions.
> 
> If you revert 09d0d5b92203f019763e43cef1e57f76f117d2b4 ("Get Python files to
> pass pep8's tests.") there issue goes away. I understand that this is not the
> right solution and I'm not the guru of python, so just let you know.

Thanks for the bug report and for narrowing it down to the broken
commit.  I just pushed a fix to GitHub.  Let me know if it works for you
now.

Elijah: your fix is also correct, but I didn't see it before I pushed my
own solution.  Sorry about that.

Junio: you don't have to worry about any of this, because the commit
that caused the breakage is not in your tree yet.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
