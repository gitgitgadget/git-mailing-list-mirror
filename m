From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What should "git submodule summary" give before an initial 
	commit?
Date: Thu, 4 Mar 2010 07:36:20 +0100
Message-ID: <fabb9a1e1003032236x59a781b8ne0266877db25d001@mail.gmail.com>
References: <4B8E5450.3040702@gmail.com> <20100303200239.GA28904@coredump.intra.peff.net> 
	<7vhboxno38.fsf@alter.siamese.dyndns.org> <20100303204257.GA5501@coredump.intra.peff.net> 
	<7v3a0hktga.fsf@alter.siamese.dyndns.org> <7vzl2phz8e.fsf@alter.siamese.dyndns.org> 
	<7vhboxf4nx.fsf_-_@alter.siamese.dyndns.org> <4B8F00AA.5050007@web.de> 
	<fabb9a1e1003032201l38b052ebk4c0061e9d40f68b6@mail.gmail.com> 
	<7vfx4gfvwv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Ping Yin <pkufranky@gmail.com>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 07:36:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn4g1-0007EG-LZ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 07:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580Ab0CDGgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 01:36:41 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50834 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab0CDGgk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 01:36:40 -0500
Received: by pvb32 with SMTP id 32so262772pvb.19
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 22:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=I9vD5hplL2nNdoJQtxsfNMrV82BFKpHeIXmoKYlXQG4=;
        b=pvDuFbEDyOPKYcY+uzkEGBAa5E8CHae8lnmBiYyYDZlC5mWWRNSfmkrFwPMu2gpGKU
         TqKse2xF87Kp8Nvi1ARIcrpvxNTMFi7xquSt3MaO7QgtLVvzPdn8KqwlE6ZMfvMCQxK5
         /awg7SNuRkQiurZlh0K94t16Tb73yCEsXUH/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xV+MnYh5TFDL1+GDw6/ofv+BPhnrBjGFFeeEBGrql7Mw1ci+wmor/bMypfDsi1j7Y1
         7CEZ0LfVjVBlyE2fbuYqy/nmPU4pS+8NSoBFTvL/DSsK3iMeaGGVmrlgY/q0h3w+jU5t
         amoMiIQKAoRyhrhC5xAv30txquEtY/WyBfCnk=
Received: by 10.142.208.12 with SMTP id f12mr1371962wfg.128.1267684600114; 
	Wed, 03 Mar 2010 22:36:40 -0800 (PST)
In-Reply-To: <7vfx4gfvwv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141511>

Heya,

On Thu, Mar 4, 2010 at 07:22, Junio C Hamano <gitster@pobox.com> wrote:
> I think "git reset HEAD" _should_ fail, but on the other hand, "git reset"
> and "git reset paths..." would be Ok before HEAD points at a commit.

Yes, that's what I came up with after sending my email, commands that
_default_ to HEAD as revision should instead default to an empty
commit when there is no HEAD yet. Perhaps something we can add to
parse_opt and then make sure that all commands we care about use that
feature?

-- 
Cheers,

Sverre Rabbelier
