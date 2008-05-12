From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/5] Make mktag a builtin.
Date: Mon, 12 May 2008 12:32:04 -0500
Message-ID: <48287F14.9040105@nrlssc.navy.mil>
References: <1210299589-10448-1-git-send-email-drafnel@example.com> <1210299589-10448-2-git-send-email-drafnel@example.com> <7689656.1210299528037.JavaMail.teamon@b301.teamon.com> <7v63tk6992.fsf@gitster.siamese.dyndns.org> <48285DAB.2040707@nrlssc.navy.mil> <alpine.DEB.1.00.0805121803320.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 12 19:33:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvbtz-0005cT-3G
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 19:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbYELRcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 13:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754679AbYELRcm
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 13:32:42 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45251 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbYELRcl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 13:32:41 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m4CHW4Gd019085;
	Mon, 12 May 2008 12:32:04 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 May 2008 12:32:04 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <alpine.DEB.1.00.0805121803320.30431@racer>
X-OriginalArrivalTime: 12 May 2008 17:32:04.0444 (UTC) FILETIME=[181781C0:01C8B456]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81885>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 12 May 2008, Brandon Casey wrote:
> 
>> Junio C Hamano wrote:
>>> drafnel@gmail.com writes:
>>>
>>>> From: Brandon Casey <drafnel@gmail.com>
>>>>
>>>> Signed-off-by: Brandon Casey <drafnel@gmail.com>
>>>> @@ -306,6 +305,7 @@ BUILT_INS += git-fsck-objects$X
>>>>  BUILT_INS += git-get-tar-commit-id$X
>>>>  BUILT_INS += git-init$X
>>>>  BUILT_INS += git-merge-subtree$X
>>>> +BUILT_INS += git-mktag$X
>>>>  BUILT_INS += git-peek-remote$X
>>>>  BUILT_INS += git-repo-config$X
>>>>  BUILT_INS += git-show$X
>>>> @@ -423,6 +423,7 @@ LIB_OBJS += log-tree.o
>>>>  LIB_OBJS += mailmap.o
>>>>  LIB_OBJS += match-trees.o
>>>>  LIB_OBJS += merge-file.o
>>>> +LIB_OBJS += mktag.o
>>> This is unusual for a builtin.  Why didn't it migrate to builtin-mktag?
>> I didn't know how to do it.
>>
>> I was trying not to do a code move and a code change at the same time.
> 
> Why did you not consult Git's own history for guidance?  See e.g.

I did, but not exhaustively. I found only examples of converting a
shell/perl script to a c version. That is straight-forward.

> 	$ git log next --diff-filter=A builtin-*.c

And indeed the first two results here are examples of converting scripts
to builtin c versions.

The third result is applicable and converts merge-recursive from a
standalone c version to builtin.

If I had known about (or looked for) the --diff-filter option I would
have used the 'R' argument, since I am interested in a rename event,
but it produces no results.

	$ git log next --diff-filter=R builtin-*.c

Adding -M does not help.

-brandon
