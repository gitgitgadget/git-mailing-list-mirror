From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Makefile: implement help target
Date: Tue, 28 Sep 2010 16:48:40 +0200
Message-ID: <AANLkTin9JZ1CErBaZjyLXBuBaX4Da7-2dgzotex+bu8X@mail.gmail.com>
References: <4CA1E10F.4080906@op5.se> <c16e8df7c8e9b562ce0e6cd6e543a83779cd2b25.1285684868.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 28 16:52:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0bXJ-0006ZV-H5
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 16:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab0I1OtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 10:49:03 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33232 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab0I1OtC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 10:49:02 -0400
Received: by ywh1 with SMTP id 1so1934947ywh.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=IfacIvm7dpzk30FCfT8ufMQVb4vu3HUosyxj/haMZVw=;
        b=vRx93NR4aaGAVhKGviiTh3wSoaEDEWugXxDUmvfdTD3y8ivx12JgICVbXFntJlR66f
         hN3MpoY3nB/8X0fUGlko3+ulCiIze2sssJI4Hsp8Pav2dlcSDSOpN1CRak7zlnG3nSd9
         Qut2vK5dgDZ8cuW6RDUlRyZ3/TD0x4jHN3O4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=LSKZpn4uUcOoA+jFU4Igt+R55jUS+QamSqBF62takvDaB2ha6t/zxdGFcGCY0g3Xxh
         QlUMFIsCnrhOaduQxK1Xzro8r+AO9kcHlGpU2zn+wDVDjj4gyItB2RqjBsC27JVam6y8
         1pCTpb4VO2WiyFoRme+BEbmFFWaI/2ReahGdk=
Received: by 10.150.11.20 with SMTP id 20mr120355ybk.407.1285685341177; Tue,
 28 Sep 2010 07:49:01 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Tue, 28 Sep 2010 07:48:40 -0700 (PDT)
In-Reply-To: <c16e8df7c8e9b562ce0e6cd6e543a83779cd2b25.1285684868.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157429>

Heya,

On Tue, Sep 28, 2010 at 16:44, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> with automatic help text collection from lines starting with "#H# " and
> preceding a make target.

I don't know about the "#H#" in particular, but documenting what each
target does is a Good Thing (tm) in the first place, re-using that
documentation for 'make help' is even better.

> We could sort differently, of course, or at a category key (build, doc, etc.)

I think just sorting alphabetically would be a good start. Maybe pipe
the whole thing through sort?

-- 
Cheers,

Sverre Rabbelier
