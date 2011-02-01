From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [1.8.0] make two-argument fetch update remote branches
Date: Tue, 1 Feb 2011 02:04:47 -0500
Message-ID: <AANLkTi=Y9PBs_jXyCiAL9YLA8Y_jzWwqxw63hKm7fVBO@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <201101312244.10047.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 01 08:09:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkAMd-0001e9-Po
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 08:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297Ab1BAHFT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 02:05:19 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57613 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab1BAHFS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 02:05:18 -0500
Received: by iyj18 with SMTP id 18so5659964iyj.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 23:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=j286jCYXhMv0CyBqL/PPGAeWrD5M1ug/WPi9eiQdCoU=;
        b=RjE2TIapSoui6DJGUhzfqTj0/VYHgLAIcZkupkkHViqfkD2/U/cw6xIY12x+tMljDn
         3NA++o0sCkrRCstLhlJBgbBjKbucn2cqmi2s2vPi/AGPqif038/MkW3jNtjzJTwTKbLj
         Z0vQo64L50lNBebdFoVF8cwi0fGH1PGwS5r2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KCDmurDtEIM8v++O3y+Md5w5zAgk4eWozUxi+JC4b4Vr4bVW/7lczr30r0MvB8Cugc
         /5KNtkBgMhvcap4V6AONWVCeNnK7L42TDmW3JMaXRvhxhsT7izXAmgPq4uGN2Kdx60Ht
         DODYWuYrSCbRuWeQg8ZEI8fIwnHvmBxCkdsPg=
Received: by 10.231.156.1 with SMTP id u1mr7788372ibw.52.1296543917586; Mon,
 31 Jan 2011 23:05:17 -0800 (PST)
Received: by 10.231.30.65 with HTTP; Mon, 31 Jan 2011 23:04:47 -0800 (PST)
In-Reply-To: <201101312244.10047.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165795>

On Mon, Jan 31, 2011 at 4:44 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Add a fetch.updateRemoteNamespace (or so) configuration variable that
> defaults to false. =C2=A0When enabled, it turns on the auto-updating
> behaviour.

Would it make sense to group the pre-1.8 compatibility switches
together in some way, if there will be several of them? Maybe

[compat]
   fetchUpdateRemoteNamespace =3D false
   ...

(Thinking out loud.)

j.
