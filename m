From: Michael Witten <mfwitten@gmail.com>
Subject: Re: In favor of "git commit --no-parent"
Date: Thu, 29 Sep 2011 22:07:28 +0000
Message-ID: <CAMOZ1BsZROF_CRwA+AgnAUSnAOjxNDBTA5Ehb8WkvZukOoZd-w@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr> <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr> <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com> <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com> <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
 <CABURp0q8YhTS-GDYOANEa19P-V2wf_EUTo=RHqnhDB619w=y-w@mail.gmail.com>
 <7vd3ejrqin.fsf@alter.siamese.dyndns.org> <7v4nzvrp3k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 00:08:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Olw-0002vg-0n
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 00:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab1I2WH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 18:07:59 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64573 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab1I2WH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 18:07:58 -0400
Received: by iaqq3 with SMTP id q3so1133502iaq.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 15:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6yezz3qii4L7UbM3XwxmVaG+LPJ9vSxvFBeW3cqNw70=;
        b=SidMK95InOPot1hshprLJit5IlA6vxF5fbeUXLPuhZqtNMmbep4LbicLw+TGdGXxCW
         Os0XPiF/0ycU973+ry+Yzt6OFmiqnY9wzz1TclMKS9HjJcsT3IV4IWsJv5+Skyzr2nAe
         Q0QPHZMxy9iCY+69L1KypC5xowwHNWIz+RC9c=
Received: by 10.42.154.132 with SMTP id q4mr1553864icw.106.1317334078033; Thu,
 29 Sep 2011 15:07:58 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Thu, 29 Sep 2011 15:07:28 -0700 (PDT)
In-Reply-To: <7v4nzvrp3k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182450>

On Thu, Sep 29, 2011 at 21:54, Junio C Hamano <gitster@pobox.com> wrote:

> I am saying that "separate history" has no place in git workflow, if these
> multiple roots _originate_ in the same single repository with a working
> tree. And all of "git checkout --orphan", "git commit --root" and your
> "git init --root" are solutions to make multiple roots _originate_ in the
> same single repository with a working tree.

Why do you keep repeating this?

The "git commit --no-parent" is the CORRECT solution for
"HIDDEN history", NOT the "separate history" that you so loathe.

The existing "git checkout --orphan" is the CORRECT solution for
the "SEPARATE history" that you so loathe, NOT the "hidden history".
