From: =?UTF-8?B?TWF0dGhpYXMgS3LDvGdlcg==?= <matthias.krueger@famsik.de>
Subject: Re: gitdiffbinstat  -  git diff --shortstat -like output for changes
 in binary files
Date: Fri, 29 Mar 2013 20:22:48 +0100
Message-ID: <5155EA08.60005@famsik.de>
References: <5155D864.8040007@famsik.de> <20130329184922.GB13506@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 29 20:25:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULevQ-000455-4u
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 20:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583Ab3C2TYv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Mar 2013 15:24:51 -0400
Received: from www.hamsked.org ([109.75.188.246]:56661 "EHLO www.hamsked.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756235Ab3C2TYv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 15:24:51 -0400
Received: from www.hamsked.org ([109.75.188.246] helo=[172.30.13.11])
	by www.hamsked.org with esmtp (Exim 4.72)
	(envelope-from <matthias.krueger@famsik.de>)
	id 1ULesx-00046S-SY; Fri, 29 Mar 2013 20:22:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
In-Reply-To: <20130329184922.GB13506@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219522>

On 03/29/2013 07:49 PM, Jeff King wrote:
> On Fri, Mar 29, 2013 at 07:07:32PM +0100, Matthias Kr=C3=BCger wrote:
>
>> I use git mostly for game-development which means I have to deal wit=
h
>> a lot of binary files (images, sound files etc).
>>
>> When I came to a point where I had run image optimization on a
>> branch, I wanted to know of course how much smaller the new branch
>> was in comparison to master.
>> Problem was that 'git diff --stat' would only summerize
>> per-binary-file size changes and 'git diff --shortstat' did skip the
>> binary files entirely.
> Have you tried "--summary"? Combined with --stat (or --shortstat) I
> wonder if it would get you closer to what you want.
>
> -Peff
No it doesnt.
It appears to append stuff like

  delete mode 100644 sound/music/NewTutorialStage.ogg
  delete mode 100644 src/pngfuncs.c
  delete mode 100644 src/pngfuncs.h
  delete mode 100644 src/widgets/widget_text_list.c
  delete mode 100644 src/widgets/widget_text_list.h

to the stat but does not summarize the binary file size changes.
