From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 20:18:03 -0300
Message-ID: <465A11AB.6060906@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <46592CFE.40303@xs4all.nl> <4659318B.20801@midwinter.com> <200705271109.11942.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 01:20:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsS2I-0002iQ-27
	for gcvg-git@gmane.org; Mon, 28 May 2007 01:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbXE0XUV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 19:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbXE0XUV
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 19:20:21 -0400
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:1435 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbXE0XUU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 19:20:20 -0400
Received: from [192.168.1.100] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4RNK4ba028299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2007 01:20:06 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <200705271109.11942.jnareb@gmail.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48596>

Jakub Narebski escreveu:
> On Sun, 27 May 2007, Steven Grimm wrote:
>> Han-Wen Nienhuys wrote:
>>> Shawn O. Pearce escreveu:
>>>> On systems like Cygwin the fork+exec overheads are very high
>>> A well written configure script is able to detect presence
>>> of a linkable libcurl.
>> IMO the reasons configure is so unwieldy, at least as it's set up in 
>> most open source projects, are that a) it spends 95% of its time 
>> checking for things that basically never vary (yes, I have stdlib.h, 
>> thank you) and that b) it doesn't remember the results from previous 
>> runs on the same host (I'm just changing the install path; my ints won't 
>> have stopped being 32 bits as a result.)
> 
> ./configure _can_ cache tests results:
> 
> $ ./configure --help
> [...]
>       --cache-file=FILE   cache test results in FILE [disabled]
>   -C, --config-cache      alias for `--cache-file=config.cache'
> 
> but it does not do this, and does not check chache by default. Of course
> tests have to be written to make use of cache, IIRC...

Slowness is a misguided argument as well.  Yes, configure is slow, but you
only have to run it if configure.in , config.h.in or config.make.in chagnes.
And that doesn't happen very often during development.


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
