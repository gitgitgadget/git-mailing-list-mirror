From: fREW Schmidt <frioux@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.9.rc2
Date: Wed, 25 Jan 2012 15:38:52 -0600
Message-ID: <CADVrmKSk3N1yqYrkp5UUtWmbSYK7cECUDnex4w1FjuMMd+w4OQ@mail.gmail.com>
References: <7vpqegjxu3.fsf@alter.siamese.dyndns.org> <CADVrmKT2RAOC-n_-h4pGJw91imj28h0-HqwGH-NOu-m3XtqiJg@mail.gmail.com>
 <7v39b53r8w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 22:39:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqAYq-00007x-LS
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 22:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab2AYVjP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jan 2012 16:39:15 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42848 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab2AYVjP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jan 2012 16:39:15 -0500
Received: by vbbfc26 with SMTP id fc26so2462079vbb.19
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 13:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mbNMoFKglta53JlGnlxvBAhrHRcwko2nIVLQp9ewGIY=;
        b=QHbZLHXqGzlHn+ChJODjuzWCmDN/UlZb9wlowYaP/bbV+HjQhgAzU0vGFI+hRgzxlP
         QmFDonR1aMkf9ScP478mTMA/IadGF0xBA5T9D1NZNwpKusW/dQBJPEJ7QAYJ07YyVnix
         wSB7D+gPSwD9xSflSP+3Q0/g4ub2mszAOFwvU=
Received: by 10.52.94.73 with SMTP id da9mr10202103vdb.6.1327527554263; Wed,
 25 Jan 2012 13:39:14 -0800 (PST)
Received: by 10.220.0.144 with HTTP; Wed, 25 Jan 2012 13:38:52 -0800 (PST)
In-Reply-To: <7v39b53r8w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189126>

On Tue, Jan 24, 2012 at 12:11 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> fREW Schmidt <frioux@gmail.com> writes:
>
>> On Wed, Jan 18, 2012 at 7:16 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> =A0* gitk updates accumulated since early 2011.
>>
>> Where might one go to find more detail on this one?
>
> Hmm, http://git.kernel.org/?p=3Dgit/git.git;a=3Dshortlog, perhaps?

Ah, I actually looked there before but for some reason didn't see the
latest merge.  If anyone else cares:

 $ git log v1.7.9-rc2 ^v1.7.8 -- gitk-git/
commit 09bb4eb4f14c0b92baa649b2b97cda2390b84b84
Merge: 10f4eb6 811c70f
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Dec 16 22:18:42 2011 -0800

    Merge git://ozlabs.org/~paulus/gitk

    * git://ozlabs.org/~paulus/gitk:
      gitk: Make vi-style keybindings more vi-like
      gitk: Make "touching paths" search support backslashes
      gitk: Show modified files with separate work tree
      gitk: Simplify calculation of gitdir
      gitk: Run 'git rev-parse --git-dir' only once
      gitk: Put temporary directory inside .git
      gitk: Fix "External diff" with separate work tree
      gitk: Fix "blame parent commit" with separate work tree
      gitk: Fix "show origin of this line" with separate work tree
      gitk: Fix file highlight when run in subdirectory
      gitk: Update copyright
      gitk: When a commit contains a note, mark it with a yellow box
      gitk: Remember time zones from author and commit timestamps
      gitk: Remove unused $cdate array

--=20
fREW Schmidt
http://blog.afoolishmanifesto.com
