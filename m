From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [Tagging Commits] feedback / discussion request
Date: Thu, 5 May 2011 20:49:39 +0200
Message-ID: <BANLkTinKLnsVp50+d_7U_vSUiaMNtZ-NCA@mail.gmail.com>
References: <BANLkTik5-Ygh0YwN=j+ibLhP6==ots_MXQ@mail.gmail.com>
 <20110504084212.GB8512@sigill.intra.peff.net> <BANLkTinCxzXCmmtxXSM7=+yeve2hhLSYNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Richard Peterson <richard@rcpeterson.com>
X-From: git-owner@vger.kernel.org Thu May 05 20:50:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3dB-000676-Hc
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158Ab1EESuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:50:24 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62005 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab1EESuU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 14:50:20 -0400
Received: by qwk3 with SMTP id 3so1679315qwk.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 11:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=NQMyU+c2u36SIsedDEzz+nJPfCUuf3K0S367w8S1Ct0=;
        b=ZjD1joF8DKhZAPvxcuZ5SzsyyCiWfaWP7SUliKMiUZ3bmoEzgjEwTKNqFZ3z6U5W9h
         mlXt5K1h+Ep8U2OP1u34oGFgCzsRimgLJAaBsR1Bo6fWft7RgA3rWRPs04Yu+qkvl4Xt
         Hvd2edZDvpvswT5qa9sVaQhfxL1LFeRybTzVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ptPVrBk8SXSPtoFF7IBuik7JTWwlKhDsYAFx+pc91W7AZDVAH12p2Zw3+bYJQHtMtG
         EwOpV5WPXJz4qfdDZzkqlbdQrv5LVX+juVo9Ow5MjodIfrsE+ol+oZmCUJW5Urvd4Nyk
         JHZmZC2f6W4dA4UhkeTeJXym80FkiRQNZC+kk=
Received: by 10.229.17.130 with SMTP id s2mr1840756qca.22.1304621419162; Thu,
 05 May 2011 11:50:19 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Thu, 5 May 2011 11:49:39 -0700 (PDT)
In-Reply-To: <BANLkTinCxzXCmmtxXSM7=+yeve2hhLSYNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172874>

Heya,

On Thu, May 5, 2011 at 17:39, Richard Peterson <richard@rcpeterson.com> wrote:
> Now my big question to ponder: what do do when the CA expires a cert? Hmm...

You could re-sign the commits with the new cert, notes are mutable,
and they keep history too. So you could just create a commit on the
notes history ref "re-sign commits for expired cert", optionally
removing the old signature. The hook verifying that no-one is
tampering with the notes might get complex if you do that kind of
stuff though (might be easier to just append the new signature and
keep the old one in place).

-- 
Cheers,

Sverre Rabbelier
