From: Scott Chacon <schacon@gmail.com>
Subject: Re: [1.8.0] (v2) default "git merge" without argument to "git merge @{u}"
Date: Tue, 1 Feb 2011 10:34:24 -0800
Message-ID: <AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<7vwrll57ha.fsf@alter.siamese.dyndns.org>
	<7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
	<7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
	<20110131225529.GC14419@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Miles Bader <miles@gnu.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 19:34:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkL3g-0007ql-26
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 19:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab1BASe0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 13:34:26 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33598 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab1BASe0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 13:34:26 -0500
Received: by wyb28 with SMTP id 28so6986360wyb.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 10:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yabWEbunf3sgV1zuex+aTVPfd0ywpS9WdFJLpi4KySc=;
        b=GVfjjSBsoUrTwbMe0VRQutqJN7nbejEJp37PLffTwpZbyR1iJbhF0aP2knhmmihb6y
         BhBp+LcNTecQoFQGrOwFUdBEkeZg9bpZJMWFTBLopV+p4hB0ZXk4mzI96MgmqPRHwFoe
         gx4WGxyGIbBfhqqV9xpoclm6zz2EwI/KrXJzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E0ntyjFzmf8CC+FEyCjvz4PN+xLjrpZnoiBaKfDub5fYpIZCcRhUwsoxImCCMQ6Mry
         sVVtaP+Wl5nDSBicpnXmVMyTVLqkPxM2mQiowp7VqLysORsV1wKgO3ji84ugkvB0uVOS
         Xi1WhquZrcU4WR1rHXR/WXNRQeM+QFVJh7+eI=
Received: by 10.216.150.134 with SMTP id z6mr7687361wej.27.1296585264733; Tue,
 01 Feb 2011 10:34:24 -0800 (PST)
Received: by 10.216.239.135 with HTTP; Tue, 1 Feb 2011 10:34:24 -0800 (PST)
In-Reply-To: <20110131225529.GC14419@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165841>

Hey,

On Mon, Jan 31, 2011 at 2:55 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 31, 2011 at 12:50:30PM -0800, Junio C Hamano wrote:
>
>> Perhaps I should start a new directory in todo branch (say, 1.8.0), =
accept
>> patches from people? =C2=A0I'd grudgingly admit that using Wiki on k=
=2Eorg may be
>> less burdensome (I hate editing inside the browser myself), but I'd =
want
>> to keep the mailing list the center of discussion and am afraid that
>> forcing people to go to Wiki would fragment the discussion.
>
> I really wish we had a git-backed wiki. I also hate using the browser
> for such things (though browser extensions to edit textareas in a Rea=
l
> Editor at least make it tolerable, it still ends up clunky).
>
> GitHub's wiki gets this right. I'm not saying we should host our wiki
> there (well, it _would_ make setting it up pretty damn easy). But the=
ir
> wiki system (gollum) is open-source, albeit in ruby. And surely there
> are other git-backed alternatives (it's been a while since I've looke=
d).

If you want to use the wiki on the git/git repo on GitHub that is
being mirrored from the canonical repository, I've added Junio and
peff to the account.  If you want to use that wiki, anyone with a
github account can edit wiki pages on the site or clone and edit it
locally and push changes up.  You can also turn off site edits so
people have to send Junio a patch instead.  It's up to you guys, but
the access is there now if you want.

Scott
