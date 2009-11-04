From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH bg/format-patch-p-noop] log-tree: always add --- marker 
	when options are patch and a stat
Date: Wed, 4 Nov 2009 08:49:48 +0100
Message-ID: <6672d0160911032349k2e67a4betd04e311dfdcf2c28@mail.gmail.com>
References: <1257283456-7007-1-git-send-email-bebarino@gmail.com>
	 <7vy6mmltz9.fsf@alter.siamese.dyndns.org>
	 <20091104063612.GA24263@coredump.intra.peff.net>
	 <20091104071053.GB24263@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 08:50:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5acs-0000Yn-UL
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 08:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbZKDHto convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 02:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbZKDHto
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 02:49:44 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:35850 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbZKDHtn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 02:49:43 -0500
Received: by bwz27 with SMTP id 27so8518955bwz.21
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 23:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=11jNHK2a/+4kbno0h+s4JzJ+fNNNWmeB1rbp3PJwOD0=;
        b=SSGtDsy7LsBceyf/twuclNnvXkOeg63yt5nh+Z/MJIvm8tX+BnjhZfjUPktcXeFiYx
         kbs2VX+7vTnqy10+KdHnICE2gY8ygSO4CZPU5bpf+vLpkcl4789cy+bNGUvryPNq5MAI
         pqHD+EOdfA/Cu/HJMpqzGFwb8hAtS8/5vMa8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TrqMzkWIK1oJi8XUgKLHODeXENY3LPBqMvQS6IjdhGh7lSBLrQBjbMoZZ/2/k70D/N
         ALAL/+KYxgr4OxDtsQVWZXbuLw752h139vb5zDWYt6wgGpKEnLHaVfEAMeJ4HhTVYOIR
         3FOdH8O6dJBrvsAJdAlm8oO/XcQ75VUt6Fen8=
Received: by 10.204.156.212 with SMTP id y20mr1064216bkw.126.1257320988131; 
	Tue, 03 Nov 2009 23:49:48 -0800 (PST)
In-Reply-To: <20091104071053.GB24263@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132059>

On Wed, Nov 4, 2009 at 8:10 AM, Jeff King <peff@peff.net> wrote:

> This patch goes on top of master, and terribly conflicts with Bj=C3=B6=
rn's
> changes in the area. But I had the impression you wanted to revert th=
ose
> changes for now anyway, so probably this should go in as a bug fix an=
d
> everything else should be built on top. It actually would be an even
> smaller change on top of his "always show patch, even when other form=
ats
> are given" change, but I didn't want to depend on it.

No problem. I can re-implement my patch series on top of your patch.

/Bj=C3=B6rn
--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
