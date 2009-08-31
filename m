From: Ian Clatworthy <ian.clatworthy@canonical.com>
Subject: Re: [Vcs-fast-import-devs] bzr to git syncing
Date: Mon, 31 Aug 2009 17:49:43 +1000
Message-ID: <4A9B8097.4050702@canonical.com>
References: <F84D4C0F-1CEF-4853-84DB-B7927CBE62B3@gmail.com> 	<b2cdc9f30908280902m22d594bam3c70259d4c296e52@mail.gmail.com> 	<fabb9a1e0908280919o412baeb1ka69968a93297ca59@mail.gmail.com> 	<b2cdc9f30908281047p76c12029u21b100ae6d88fe93@mail.gmail.com> <fabb9a1e0908281049t64f06a2r5efa114c7bcdc468@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Reitter <david.reitter@gmail.com>,
	vcs-fast-import-devs@lists.launchpad.net, git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 10:05:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi1tP-0006Ms-D6
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 10:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbZHaIFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 04:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbZHaIFV
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 04:05:21 -0400
Received: from bld-mail13.adl6.internode.on.net ([150.101.137.98]:47171 "EHLO
	mail.internode.on.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750778AbZHaIFU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 04:05:20 -0400
X-Greylist: delayed 936 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Aug 2009 04:05:19 EDT
Received: from [192.168.1.102] (unverified [118.208.115.177]) 
	by mail.internode.on.net (SurgeMail 3.8f2) with ESMTP id 4538541-1927428 
	for multiple; Mon, 31 Aug 2009 17:19:45 +0930 (CST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <fabb9a1e0908281049t64f06a2r5efa114c7bcdc468@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127468>

Sverre Rabbelier wrote:
> Heya,
> 
> [+vcs-fast-import-devs]
> 
> On Fri, Aug 28, 2009 at 10:47, Alex Bennee<kernel-hacker@bennee.com> wrote:
>> 2009/8/28 Sverre Rabbelier <srabbelier@gmail.com>:
>>> On Fri, Aug 28, 2009 at 09:02, Alex Bennee<kernel-hacker@bennee.com> wrote:
>>>> I've attached the fast-import crash I'm seeing. Are you seeing the
>>>> same sort of failure?
>>> The program you used to generate the stream (I assume git-bzr?) is
>>> generating an invalid mode, git understands '100644', '100755',
>>> '120000', and '160000'; the mode in the stream, '040000', is not
>>> something we understand.
>> Yeah, it seems in bzr land it mean new directory which we don't care
>> about.

> This seems like a fine case for the new 'feature' command on bzr's export side.

Hmm - I only added that 040000 stuff late last week and it *should* only
be output if you explicitly ask for extended metadata from bzr
fast-export via the --no-plain option? If that's not the case, please
raise a bug here: https://bugs.launchpad.net/bzr-fastimport.

Ian C.
