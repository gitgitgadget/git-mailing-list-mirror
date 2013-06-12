From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH 1/2] submodule: handle multibyte characters in name
Date: Thu, 13 Jun 2013 01:10:35 +0200
Message-ID: <20130612231035.GA18022@paksenarrion.iveqy.com>
References: <1370991854-1414-1-git-send-email-iveqy@iveqy.com>
 <1370991854-1414-2-git-send-email-iveqy@iveqy.com>
 <7vppvr11kg.fsf_-_@alter.siamese.dyndns.org>
 <51B8EA67.7040801@web.de>
 <7vk3lzym1b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	hvoigt@hvoigt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 01:07:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umu8k-00085X-PU
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 01:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758055Ab3FLXHj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 19:07:39 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:56826 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756909Ab3FLXHi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 19:07:38 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so7502963lbh.23
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 16:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s8tj7ACnitOBrgLTJNZPBmHhsM//MiRqQZIQuKxspsA=;
        b=p0bayNLipjQ7CBWU3IgnsgvlThtXOlfHhA18thjP+VvKk4IFCsivB2ZcNijAvKqIJ9
         KS+hqOT/PRDxELTFl/JgT4bUE2h7U52PhegZpxsyX8OkW44XcQrVJojL4LYQlFkYLnbk
         Y+iZwsLRyhO7ve0qiDUwRGL6FIUUFyAgNoj7MTCTxxGjOmWzP1En8IjH1UiGSji7gsg/
         vQVSU3bcPCNMCxx3PI2oGXJew1ClNYOhkOcXToDyGo/9EO5PdYzd4N71VT6LzgV/pGjZ
         aHZcw5YO/FvkxbG8t/r1NQnrGsK9DfJPoV/muCuaREJPHE9LLFaT4zwRiF6ATtqEvsYQ
         D3Vg==
X-Received: by 10.152.27.169 with SMTP id u9mr5473131lag.8.1371078456405;
        Wed, 12 Jun 2013 16:07:36 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id a3sm9802261lbg.2.2013.06.12.16.07.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 12 Jun 2013 16:07:35 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UmuBX-0004n4-SE; Thu, 13 Jun 2013 01:10:35 +0200
Content-Disposition: inline
In-Reply-To: <7vk3lzym1b.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227691>

On Wed, Jun 12, 2013 at 03:57:52PM -0700, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>=20
> > Hmm, I just came around to test that patch, and for me the new
> > test even succeeds without the changes to module_list(). So I'm
> > not convinced yet what we are fixing here ;-)
>=20
> My guess is that you have core.quotepaths set to false.

Actually the bug-reporter claimed to see the submodule in .gitmodules
but not when listed with git submodule.

The test is missing one line in the end to check for this. Sorry about
that.

I've a new iteration ready for this but want to test it a bit more
locally so I don't miss anything else first.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
