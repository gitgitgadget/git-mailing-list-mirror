From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: diffstat witdth with one changed file
Date: Tue, 22 May 2012 18:47:14 +0200
Message-ID: <4FBBC312.5000402@in.waw.pl>
References: <CACsJy8BrqaLbtVp5uF3q2Jo63DPwtFACYw3_rPy8eyNK7VSWMw@mail.gmail.com> <4FBB2B4B.6030402@in.waw.pl> <CACsJy8D1eMhyPm8b5D6vSuMDvebfX1hB2GUz82E8LeVhnWsqCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 18:47:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWsF5-0006Tx-R6
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 18:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882Ab2EVQrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 12:47:23 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:37233 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758Ab2EVQrW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 12:47:22 -0400
Received: from zopt1.fuw.edu.pl ([193.0.81.24] helo=[10.33.8.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SWsEz-0006Hb-2Q; Tue, 22 May 2012 18:47:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <CACsJy8D1eMhyPm8b5D6vSuMDvebfX1hB2GUz82E8LeVhnWsqCQ@mail.gmail.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198204>

On 05/22/2012 02:50 PM, Nguyen Thai Ngoc Duy wrote:
>> On 05/21/2012 05:52 PM, Nguyen Thai Ngoc Duy wrote:
>>> Hi,
>>>
>>> With recent git, "git log --stat 90e6ef5", the first commit's diffstat
>>> uses full terminal width while the next one uses less than 80 chars.
>>> Both changes one file. Is it intentional? I tend to think it's a bug
>>> because with one-file changes, diffstat width is not important as we
>>> have no other files to compare with.
> It just looks weird that while most of the commits fill half of my
> screen (200 char width), some diffstats strike a line through the
> right edge. And I did not see the reason for that in the beginning
> because I thought long lines only makes sense when compare to other
> lines.

A side note: 'git diff --stat-graph-width=N' or 'git config
diff.statGraphWidth N' can be used to limit the width of the graph part.
I don't use it myself, but it could be useful if you have a really wide
terminal.

Zbyszek
