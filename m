From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 22:32:41 +0100
Message-ID: <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com> 
	<fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com> 
	<7veil8iqnj.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001291614550.1681@xanadu.home> 
	<fabb9a1e1001291321v708c7cb4sec8e944f336d04fd@mail.gmail.com> 
	<alpine.LFD.2.00.1001291628510.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ron1 <ron1@flownet.com>, Jacob Helwig <jacob.helwig@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:33:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaySj-00016X-L8
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab0A2VdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 16:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754863Ab0A2VdE
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:33:04 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:59920 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab0A2VdB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:33:01 -0500
Received: by pxi12 with SMTP id 12so1997815pxi.33
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 13:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=2Uvr1IVZQQ8VGoyVbHCR8nhF1+vuxv/JgakUUenKn60=;
        b=eaM3O8oEmJSy2B8X2Xlf8jxYtEVflKqaMO+KV/CYBZPXHK5IYt6tBCXhoTvqtlw0Fc
         s0qAhMgnM4rCKT2esR0N68s19US3Pqb8Sxd6fr/27/9wEMmz84sQ1cSW87ysg32xKj6D
         f+nLYXYJb/Moj1zEZxb+uI/BeqDtquCqDtSzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sGnPFk8OPkwgB4TmjwE0TbDtykOfjry1GeYGq284HqArD/VJtg0F+XeeUrHJGNEOMv
         bNGL2R7Ecmj66E5Vb1pe2Q4LnSvPBYqueoFXgOBH6J9DXIG7E96Mk3trxSNHoiN1orSA
         OJlrdBJB/I7KoEScGFCCjcI49rGPBgT/3p95k=
Received: by 10.142.117.25 with SMTP id p25mr897886wfc.301.1264800781100; Fri, 
	29 Jan 2010 13:33:01 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001291628510.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138367>

Heya,

On Fri, Jan 29, 2010 at 22:29, Nicolas Pitre <nico@fluxnic.net> wrote:
> Then who was arguing about making Git more user friendly rather
> then less?

Using a detached head is a more advanced feature than wanting to
checkout a remote branch locally, creating a local tracking branch. As
such, 'git checkout origin/topic' now means the same as 'git checkout
-t origin/topic', and you can get the old behavior back by doing 'git
checkout origin/topic^0'. I don't see what the problem is, if you're
using a detached head you're an advanced enough git user that you can
remember that you can use '^0' to detach your head. It's not all that
uncommon to do 'git checkout HEAD^0' to detach your head to the
current branch, no?

-- 
Cheers,

Sverre Rabbelier
