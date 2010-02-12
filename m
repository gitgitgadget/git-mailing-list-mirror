From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 20:30:06 +0100
Message-ID: <fabb9a1e1002121130uf16efeeyea6f763be18d27d@mail.gmail.com>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com> 
	<20100212080620.GA31719@dcvr.yhbt.net> <alpine.DEB.1.00.1002121000290.20986@pacific.mpi-cbg.de> 
	<fabb9a1e1002120103j3f37d417ka5b7b7ca3ae8edd@mail.gmail.com> 
	<20100212091635.GA22942@glandium.org> <alpine.DEB.1.00.1002121034320.20986@pacific.mpi-cbg.de> 
	<fabb9a1e1002120132q157d2d4dqd7c81d766bd933f6@mail.gmail.com> 
	<alpine.LNX.2.00.1002120923060.14365@iabervon.org> <fabb9a1e1002120841o71651f82h782eab46206df402@mail.gmail.com> 
	<alpine.LNX.2.00.1002121158430.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Eric Wong <normalperson@yhbt.net>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 20:30:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng1Dl-0005Em-H5
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 20:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757518Ab0BLTa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 14:30:28 -0500
Received: from mail-pz0-f197.google.com ([209.85.222.197]:34508 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757421Ab0BLTa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 14:30:27 -0500
Received: by pzk35 with SMTP id 35so464577pzk.33
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 11:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=27xfo6+SxsjIBqyFXqWNW3h7/WJKJA5p9/hsFNv+rAQ=;
        b=At2KUpJpwd3nt9RmIIC4iQAGqG9X2qYjBS3a/uSn0dUBJmSiJumwdZZ0g/jzFh9/Qp
         FqSNHPK6hF/hCKWwN5TaPHPbfR5iVSBKNTjs2U6AM+vc0GINOkSifXlSjxkciFHSx8KF
         MBhT5gwbp9gmWmvvUCFwjpr+HwtTSrlLsm/9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=SV8VSM5C3JtFC9s0OSICD/J4fU8KPRPsG86XszEys6O5+VaXnosBnopGTRsOJ3jJv0
         VMB1EhXdsOKA1Q6sVzGMdxr+hqmXzrXXnWMf8SkPde0A4/y1CTFBUlJnh2eBPmYRTkTe
         FGT24meG0bpiFKohE++PPWyjN6M3bPgAYtOvA=
Received: by 10.143.25.38 with SMTP id c38mr1218560wfj.130.1266003026237; Fri, 
	12 Feb 2010 11:30:26 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1002121158430.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139740>

Heya,

On Fri, Feb 12, 2010 at 20:16, Daniel Barkalow <barkalow@iabervon.org> wrote:
> I think that 'export' will always have this effect, because the
> export/reimport roundtrip is practically never going to be exact with a
> remote system that isn't actually git (and the state that you see the
> remote as having after a successful push should match what you see if you
> were to clone again).

Not so, currently round-trips to Mercurial using hg-git result in
identical commits.

-- 
Cheers,

Sverre Rabbelier
