From: Mike Linck <mgl@absolute-performance.com>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 14:38:14 -0700
Message-ID: <69b754db1001281338l58eb4b84t5a5725de294b6cc5@mail.gmail.com>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
	 <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com>
	 <69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com>
	 <4B6201BC.9030800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 22:38:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nac4C-0001BT-I8
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 22:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154Ab0A1ViP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 16:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917Ab0A1ViP
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 16:38:15 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:59785 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab0A1ViO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 16:38:14 -0500
Received: by pxi12 with SMTP id 12so921368pxi.33
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 13:38:14 -0800 (PST)
Received: by 10.142.119.9 with SMTP id r9mr1640316wfc.201.1264714694076; Thu, 
	28 Jan 2010 13:38:14 -0800 (PST)
In-Reply-To: <4B6201BC.9030800@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138275>

On Thu, Jan 28, 2010 at 2:29 PM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 28.01.2010 22:17, schrieb Mike Linck:
>> Well, even gitk can't show me the information I'm looking for if the
>> parent branch ended up fast-forwarding to include the changes made i=
n
>> the topic branch. =A0As far as I can tell there is *no way* to tell =
what
>> changes were made in a particular branch after a fast-forward has
>> taken place, which seems to make it hard to organize fixes for
>> specific topics/bugs/tickets.
>
> You could disable fast forward merges using the --no-ff option. Then
> git will always create a merge commit even if it could have done a
> fast forward. This can be enabled permanently for a branch with
> 'git config branch.master.mergeoptions =A0"--no-ff"'. We use that at =
my
> dayjob to preserve the branches after merging.
>

OK, so what I'm getting is that if a developer forgot to disable
fast-forward when they created a topic branch, and if the parent
branch has been fast forwarded to include it, then you might as well
just throw away the topic branch, is that correct?

Could anyone point me to a good book that actually describes the style
of code management that git was intended to support?  Because I'm
finding this a bit baffling, to be honest.  I thought it was intended
to make the developers' side of code management easier to do, but it
seems to me that they have to think a lot harder about what they're
trying to accomplish, at least in this sort of case.  I'm not trying
to be rude, but I just feel that if I want to keep working with this
tool, I have to rethink how the code is organized in a pretty
fundamental way and I'd like to get as comprehensive of a guide as
possible from someone who has adopted their tactics to it.

Thanks

Michael Linck
