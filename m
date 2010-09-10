From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] read-tree: deprecate syntax without tree-ish args
Date: Fri, 10 Sep 2010 08:53:28 -0500
Message-ID: <AANLkTimiT7eV2XHMEjbp6cOqTTQ6OH8vrbMoDCLxneJC@mail.gmail.com>
References: <20100910120604.50aa1e94@jk.gs> <4C8A168F.1030502@viscovery.net> <20100910152859.778636d4@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Fri Sep 10 15:54:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou43E-0000vN-8J
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 15:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125Ab0IJNxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 09:53:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57960 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab0IJNxy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 09:53:54 -0400
Received: by ywh1 with SMTP id 1so1119646ywh.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tJK5X+GSpz4qRGww9vm0qtyMlyHrlqU1QjsuWtk0cuk=;
        b=vhyH6yT0dInz6Vhq7GoAcZbjMhUPvNkL7xSI5QzpiGtHd+Ic1qGr7DiVlAbZD+UToF
         2MPHuYqG/+BuTC50gSrc1vzK//wLoQCaWpYDsJHiQM/o7a//eln0YXyC4CMc4T2GxWTC
         hYlW341Wop8nJMbBUS+ZJKGylT6L91GiBunN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DiCAu9xUZAS70T41ZEyzu2MlIaOS5SSbSPPrqYbfdVmRjIy+tn+mCHGt1CkSpa5WEQ
         zsVynMzZFjmpxlH1pAwfOw4ZIvPnPri62hlbFzz6qEBjiN4YlSw7G+/EuixpQCxX5uJ7
         8YQMTz2tMYWlhRxJekMP1xddGdKRRuTuyx9fY=
Received: by 10.151.45.8 with SMTP id x8mr187131ybj.11.1284126828333; Fri, 10
 Sep 2010 06:53:48 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Fri, 10 Sep 2010 06:53:28 -0700 (PDT)
In-Reply-To: <20100910152859.778636d4@jk.gs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155928>

Heya,

On Fri, Sep 10, 2010 at 08:28, Jan Kr=C3=BCger <jk@jk.gs> wrote:
> Currently, read-tree can be run without tree-ish arguments, in which
> case it will empty the index. Since this behavior is undocumented and
> perhaps a bit too invasive to be the "default" action for read-tree,
> deprecate it in favor of a new --empty option that does the same thin=
g.

=46WIW, I still like it.

--=20
Cheers,

Sverre Rabbelier
