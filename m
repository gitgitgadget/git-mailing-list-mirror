From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Tue, 12 Mar 2013 20:56:11 -0400
Message-ID: <CAJELnLHGNit90LWMtqY_oFZPScKA2+xx4+2MfJxoZs3kYD1G6w@mail.gmail.com>
References: <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
	<CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
	<20130312190956.GC2317@serenity.lan>
	<CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
	<20130312194306.GE2317@serenity.lan>
	<7vfw0073pm.fsf@alter.siamese.dyndns.org>
	<20130312210630.GF2317@serenity.lan>
	<CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
	<7vehfk5kn2.fsf@alter.siamese.dyndns.org>
	<3222724986386016520@unknownmsgid>
	<20130313001758.GH2317@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 13 01:56:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFZzj-00078X-PN
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 01:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab3CMA4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 20:56:12 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:48890 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab3CMA4M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 20:56:12 -0400
Received: by mail-pb0-f49.google.com with SMTP id xa12so429222pbc.8
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 17:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=WHfKVRS1A/q+jpgVAtwzYaOQ28KnOb1SAqnuQVLVle0=;
        b=IbwXZP80Ngjhf3qZMZAvu3c7r38duBd1qNEDXqLNeRjpAW+HqK7Z3Paax1nI+YI3gl
         9FCGNpJ9SUlhVqE0petyvMg0lNPzY/36ebKEp59imiX4LI7SXEPt/vr6Oz+LX9aZobqj
         SyO8wPeV5uqiKRZAP5X2A5Cxlx0iNfx54FxldWu9poqleY5n59ot3VFD6dzvyNyU4Is+
         vIOQCCOlJeQcyif/Th9g8uWWV4Ck4tnw29ZQSXFP5RXkpbCTA4ZZRn46hauBPr8kfgJA
         /5AHUlTuebk6y1armmkEOeZM9ea3tCxpjuaMJq/99WU6Q/jzk9dcnUG84wN0/6U1fCnT
         gIGQ==
X-Received: by 10.68.176.68 with SMTP id cg4mr9575931pbc.49.1363136171627;
 Tue, 12 Mar 2013 17:56:11 -0700 (PDT)
Received: by 10.68.49.65 with HTTP; Tue, 12 Mar 2013 17:56:11 -0700 (PDT)
In-Reply-To: <20130313001758.GH2317@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218016>

On Tue, Mar 12, 2013 at 8:17 PM, John Keeping <john@keeping.me.uk> wrote:
> Does this work for your original scenario?

Yes. Thanks!

-- 
Matt McClure
http://www.matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
