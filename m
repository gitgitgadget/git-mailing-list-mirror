From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Question
Date: Tue, 11 Aug 2015 15:30:32 +0200
Organization: gmx
Message-ID: <0c185469267ab3d1945852647aef59db@www.dscho.org>
References: <CABqaoS17HSAuDZwZKdRiTdgH58p=2DXXoDFsTVNNDt=Vxgk11g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jet Rey Maza <jet.cpi.tmp@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 15:31:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP9eM-0007bR-8C
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 15:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbbHKNai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 09:30:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:63492 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbbHKNag (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 09:30:36 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LaG7C-1Yy20k20uk-00m6tc; Tue, 11 Aug 2015 15:30:32
 +0200
In-Reply-To: <CABqaoS17HSAuDZwZKdRiTdgH58p=2DXXoDFsTVNNDt=Vxgk11g@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:fqw/G4iFpuHwFu+pqb3OAUT/0T43UZhh9t4SHuRIIMdFLQV5GWO
 aIYaZr9h8bQLPdT3ih+KBZJV0bzOiPyYkEfFKD/SZfR/XUYTHcw1U9/h1PI8XnjFiDvS6bw
 VOVwCJELQDO9Qom4MXsx6rJRcOH++2mHH2Nsd2xuTrnorVX9x0/BBrU7W7+SMgiw2a9C0jn
 5UjPbQQ1SM8eZnJd9vqYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K6OsZ9s89fg=:ncxe1rkz7dQQY5KLE0wOYq
 GiKjJ1so3cReow7XSb4niBbif2leduvRzhWOW6v6GE+fcEt/iSoY3wEaUZm9tgfaI3R3iH6j1
 SQrGlQp0ScLGmOawbH+4vdE0t+zyfNzXSEpXyWJn7Kk3I/MOqRwOSNq1HtJ3ODe1va9IirtHU
 Tdtlub7esb/vJ/wdXIszBPB8SH5dE2rPDs0I/TZUblku8rD1cLuR+1BMfZk34tvut4+82t5SW
 6cu/QcVwMkVWewlCSeSKIIWy/n3UUgWpYJ6gzG054TpzvJ/qf3UuNkPFL/dJN3B8knih27x2k
 ZrPVsr28IWRKAHauh8MsD1YOlNVePk177IUPmfnx19zmQNxT3KE5F5HpJbskReudfSQ74Gtq4
 xZNsnfDjrxzqKP3aISXrEfpwblttk+mwsfP2JGO/sm+oJ9dNwQBK3leJOLmbZjkJ4JNkwk8m2
 /p5I8PW6VC9pRhhncOjRyPWFps5RTQG9GmSdBQhn4PbfTnLY9ANs5vnl0o9/6nUXJ78BWsMMr
 3x6XQ0UekC2U2zDwf50rOIuYamswCwhGfa6lUjB4x8kbaPzzkD/KWEEt/mWO7IPO5b/DwkkRm
 PbJXId5OnJ0gDeQJW1wYYTHHK6iwKYBKWqAzTfFzkaw2YYnopqQuSlN0TgUGWdqNFYHKGVQ0F
 eh6LMHY9Wdor7QLz9xLqqR50xSOc/uxyxqlKeLZ9WRl+X/goZNbkSfcCEjVa196+j33SA2hA7
 jwPryzG3CpvYFmqj6u7+6DTRQzPWnlE/Ql1o6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275691>

Hi,

On 2015-08-11 10:28, Jet Rey Maza wrote:

> I'm wondering why gitbash dont have wget?

Please take the time to write coherent questions in the future, giving enough context for others to understand what you are talking about. We are not dogs that you throw some bones, you know? We are highly skilled software developers and you might want to express some respect for that by crafting a pleasant email.

As to your question, I have to guess here because you are so parsimonious with context: are you referring to Git for Windows' "Git Bash" entry in the start menu?

Assuming that this is what you meant, the explanation is simple: Git does not require wget to work. So we do not ship it with Git for Windows.

Side note: Git for Windows *does* ship with curl.exe, for historical reasons. You can probably use curl instead of wget for your use case.

Second side note: you obviously seek more than just Git for Windows, so why not use MSys2 (https://msys2.github.io/) which comes with a wget package you can install via pacman?

Ciao,
Johannes
