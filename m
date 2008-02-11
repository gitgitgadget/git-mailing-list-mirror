From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 2/2] Emacs mode: delete patches
Date: Mon, 11 Feb 2008 11:12:12 +0100
Message-ID: <87tzkfssxv.fsf@lysator.liu.se>
References: <20080210204628.17886.27365.stgit@yoghurt>
	<20080210204851.17886.69638.stgit@yoghurt>
	<87wspbsubl.fsf@lysator.liu.se>
	<20080211095118.GB28140@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:12:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOVee-0002v2-Ha
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbYBKKMM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 05:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbYBKKMK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:12:10 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:47647 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbYBKKMJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 05:12:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id E18E4200A218;
	Mon, 11 Feb 2008 11:12:07 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28491-01-84; Mon, 11 Feb 2008 11:12:07 +0100 (CET)
Received: from krank (78.156.200.233.bredband.tre.se [78.156.200.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 3126A200A21C;
	Mon, 11 Feb 2008 11:12:07 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 6C21F7B4077; Mon, 11 Feb 2008 11:12:12 +0100 (CET)
In-Reply-To: <20080211095118.GB28140@diana.vm.bytemark.co.uk> ("Karl
 =?utf-8?Q?Hasselstr=C3=B6m=22's?= message of "Mon\, 11 Feb 2008 10\:51\:18
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73500>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-02-11 10:42:22 +0100, David K=C3=A5gedal wrote:
>
>> Karl Hasselstr=C3=B6m <kha@treskal.com> writes:
>>
>> > David, could you have a look at this as well? In addition to me
>> > being elisp challenged, there are the following issues:
>> >
>> >   * Is "d" a reasonable binding? Any better suggestion?
>>
>> We could reserve "d" for moving a patch "down", maybe. The more
>> destructive commands could be on less accessible keys. Maybe "D" or
>> "C-d".
>
> I'll take "D" then, since control bindings are more likely to collide
> with existing bindings (as is already the case with C-r for stg
> repair).

True, maybe we should move the repair binding as well.

>> >   * Currently, this command requires you to mark one or more
>> >     patches before deleting. This is convenient when deleting more
>> >     than one patch, but one could argue that it should be possible
>> >     to delete the patch at point without having to select it.
>>
>> You need something like this:
>
> OK, thanks. I'll whip up a proper patch tonight -- unless you prefer
> to do it yourself?

Be my guest.

--=20
David K=C3=A5gedal
