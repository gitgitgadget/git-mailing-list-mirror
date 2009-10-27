From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCHv3 0/3] git-gui: more robust handling of fancy repos
Date: Tue, 27 Oct 2009 12:35:23 +0100
Message-ID: <36ca99e90910270435h69c1e983j78ff9ec49e7e8eae@mail.gmail.com>
References: <1250467128-29839-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 12:35:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2kKp-0000Xv-59
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 12:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbZJ0LfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2009 07:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753802AbZJ0LfU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 07:35:20 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:37048 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbZJ0LfT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 07:35:19 -0400
Received: by bwz19 with SMTP id 19so50846bwz.28
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 04:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=adKUHWGhVnq1y1f0PI0TafOc5m7H9EPHXrCmLeQwZw4=;
        b=HMog/fCJcVPeeVAwH5d8oDuMae5kVOlT80Y3CF/J5m8zVhS06fWZisGOs5vgFUNHPu
         f4Ef48SoVr8IFCih/lwp/PbA8zdE/U7zDDd5PwzGZKrjsyYmWpt+AYcoDtUL8E5clah0
         q7jmf1yoxWQpDi81ie0H9qBVJXYTiALwLcSM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CqDjgMJsdQ5mivYKQvbkabpylghc47zgc9vxXNtGDzPJVnBTz5t2oKdOU9ABicjKNn
         qgV59HKN0sypGtqLQGkHE125uqBgvcgvNgA/3Jjts3++08VFme05PRNfH+NqSScY3mw9
         y+T6kR0x4toWSieBrrY0GpUtwxbMFgZqi2to4=
Received: by 10.223.161.212 with SMTP id s20mr537698fax.2.1256643323671; Tue, 
	27 Oct 2009 04:35:23 -0700 (PDT)
In-Reply-To: <1250467128-29839-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131326>

On Mon, Aug 17, 2009 at 00:58, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> As promised a long time ago (March 30), version 3 of the small patchs=
et
> to improve handling of repositories in git gui. The most significant
> change is the addition of the third patch.
>
> The first patch allows git gui to work with respotiories for which
> the worktree is not the parent of the gitdir.
>
> The second patch refactors bare repository detection, improves the er=
ror
> message if the bare support feature is disabled, and disabled
> inapplicable menu entries.
>
> The third patch allows git-gui to work properly when launched from th=
e
> .git directory itself, solving the issue Markus Heidelberg was having=
 in
> http://thread.gmane.org/gmane.comp.version-control.git/115044
>
> Giuseppe Bilotta (3):
> =C2=A0git-gui: handle non-standard worktree locations
> =C2=A0git-gui: handle bare repos correctly
> =C2=A0git-gui: work from the .git dir
What is the state of this patch, I can't find it applied.

I would also suggest to always export GIT_DIR into the environment, so
that guitools can relay on this.

Regards,
Bert
