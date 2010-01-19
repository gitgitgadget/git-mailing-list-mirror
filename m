From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Push to origin failed
Date: Tue, 19 Jan 2010 16:05:40 +0100
Message-ID: <fabb9a1e1001190705o5698e675med65ec8618befa8e@mail.gmail.com>
References: <4B55C48F.2090005@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Johannes Schneider <mailings@cedarsoft.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 16:07:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXFgA-0002MG-Ke
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 16:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab0ASPGE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jan 2010 10:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216Ab0ASPGD
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 10:06:03 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:53025 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581Ab0ASPGA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2010 10:06:00 -0500
Received: by pwj9 with SMTP id 9so2436965pwj.21
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 07:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BygPnHLPKXmC4ez0Oiu5suNLhqpi0RNvTSaOhlI+iJ8=;
        b=Wc0rfZClco5W6rWISzxdlJgpsUC++xF7p//D/CNQNdYJ0OHSF7cKCl+pLhDTXGHpkt
         Lty9YfxePYT949S1yVjDoJol4Yi6kL3ctV9AX1+TjRI+nR1jc9cQlci0AnaRmfUcOkwp
         SqeftV2rZlvdNcrNGcNbIlF4zvjwPNisWa58I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=inaw9UsyWravEr+qhi4CYQnGrc3i1cnxmtFRd9HWZIObnCulJJzMwNBLuti37bvTsS
         LNvEQUKwPMRM8jOw9Mm9cdFD3bEn4Y7kBMA8HDjSvwxCI0TwEbzLJpMVSn8el2MJs9OG
         J9T9MDihlEh/7HSTa2HKHurwbQ9P+46bp3cXY=
Received: by 10.142.9.11 with SMTP id 11mr5223755wfi.101.1263913560143; Tue, 
	19 Jan 2010 07:06:00 -0800 (PST)
In-Reply-To: <4B55C48F.2090005@cedarsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137463>

Heya,

On Tue, Jan 19, 2010 at 15:41, Johannes Schneider
<mailings@cedarsoft.com> wrote:
> =A0! [rejected] =A0 =A0 =A0 =A0master -> master (non-fast forward)

There's your problem. You could solve it by instead doing 'git push
-f' (telling it to push even though it's not a fast-forward), but that
would make it hard for those downstream of that repository. So, read
up on 'fast-forwards' and why it's bad to push if it's not a
fast-forward, but mainly figure out why you have a fast-forward in the
first place. It could very well be that you need to fetch and merge
(or fetch and rebase) first.

--=20
Cheers,

Sverre Rabbelier
