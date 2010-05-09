From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI 
	script
Date: Sun, 9 May 2010 11:48:30 +0000
Message-ID: <AANLkTimq1d3xNota6XkpTv-bFxCIW1Jk-l6n5vcmV95R@mail.gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com>
	 <201005090041.11864.jnareb@gmail.com>
	 <20100509093100.GA7641@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	Peter Vereshagin <peter@vereshagin.org>,
	John Goerzen <jgoerzen@complete.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 09 13:51:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB52p-0008R2-OM
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 13:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232Ab0EILsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 May 2010 07:48:32 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:65020 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab0EILsb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 07:48:31 -0400
Received: by yxe1 with SMTP id 1so1875067yxe.33
        for <git@vger.kernel.org>; Sun, 09 May 2010 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L8LaIscbth9AyWBKoOgC9U0IwKdeEHQ/FMKKMAOcauk=;
        b=DDAbzzQI8245mBzuu1IxBn2i+EjLX3bTlW/lKoqAOAD+LX/sBQEiRxDZtXZhhimtg8
         7cN9DjcUNE6OPP8frhftnaiepNFGclC0IH++k9l3pSLcV3kwFeEPRkSyi3GJC4/cl7kt
         QuegK0bnQ5NSDfrY6/UPN3/M+/VKa1LH8x85A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E5sz7VXqmQbDcQ4SlxDm8jhPCDfOJUMDOa+xRC+KGBBghF32vY4r0ATj9NA9NjUa49
         rTyJdi+j2EDtTWewuc8IfLMWf3WbbBL+i6bvCgEgkxNKR4FVdKkNXdX3Pu+qvBj5HcAm
         ij6ctzFjW5R7TFwLeZKx4/e1nycIbM8NvEoCo=
Received: by 10.231.183.140 with SMTP id cg12mr1414620ibb.35.1273405710586; 
	Sun, 09 May 2010 04:48:30 -0700 (PDT)
Received: by 10.231.160.11 with HTTP; Sun, 9 May 2010 04:48:30 -0700 (PDT)
In-Reply-To: <20100509093100.GA7641@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146722>

On Sun, May 9, 2010 at 09:31, Eric Wong <normalperson@yhbt.net> wrote:
> I just use Ruby WEBrick nowadays for any instaweb instances I run to
> share with a few cow-orkers. =C2=A0I do a reasonable amount of develo=
pment in
> Ruby, so it's always installed and ready for me. =C2=A0It would be ni=
ce if
> there were something standalone and as ubiquitous as WEBrick in the P=
erl
> world.

There is: http://search.cpan.org/perldoc?Plack

You can run applications under everything from stand-alone webservers
to cgi, fastcgi and mod_perl if you interface with Plack.
