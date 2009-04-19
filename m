From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3.5 03/12] send-email: Interpret --smtp-server "" as 
	"use a default".
Date: Sat, 18 Apr 2009 19:13:11 -0500
Message-ID: <b4087cc50904181713m49849f89q87a9f5a392085939@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
	 <200904181735.51696.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Sun Apr 19 02:14:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvKgN-00068E-U5
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 02:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbZDSANP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2009 20:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbZDSANO
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 20:13:14 -0400
Received: from mail-qy0-f126.google.com ([209.85.221.126]:45555 "EHLO
	mail-qy0-f126.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbZDSANN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Apr 2009 20:13:13 -0400
Received: by qyk32 with SMTP id 32so778132qyk.33
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 17:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0wmoF8KGpHqCvv/THVJd1SxNt2Ae4bdE7TJSknUP7V8=;
        b=P1YAJQ8ea2Aj4jjwj88KP37Bc2P+tk2pOnOoygz8Bq+wS+aZyPdXHJsyj7L4DNOlVm
         2KrQ0IO04e1iBNxAFcfSVIjBuEgly+ivkTerCDzfNP3dpQvnPSpKS2wC1brVWKpaDXdC
         zd69x37T2xPE/ps0wbtqtSmr7Lc2cgZUXBmeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g0GRKixjB3QEagsCmGYElmR5Nz2q/UNISNpMDmkeaPvRApSXzFSNUZYVK/l2/5/75X
         YiQzBy37HijYJ+Ba9I3T2W81UY2N63CEbvU7BEXeXWDzUJAiEeOZYkdS4OlKbai3lVfg
         KlfyL0Ve/QThC1BYa2u+8x1pnlM2e3/4sVn20=
Received: by 10.224.29.13 with SMTP id o13mr5122669qac.98.1240099991746; Sat, 
	18 Apr 2009 17:13:11 -0700 (PDT)
In-Reply-To: <200904181735.51696.wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116872>

On Sat, Apr 18, 2009 at 18:35, Wesley J. Landaker <wjl@icecavern.net> w=
rote:
> On Saturday 18 April 2009 11:01:59 Michael Witten wrote:
>> =A0 =A0 =A0 `/usr/lib/sendmail` if such a program is available, or
>> - =A0 =A0 `localhost` otherwise.
>> + =A0 =A0 `localhost` otherwise. Also, a built-in default is used if
>
> I think you may have meant:
> + =A0 =A0 =A0 `localhost` otherwise. Also, the built-in default is us=
ed if

Good eye! However, I deliberately chose 'a built-in', because there
are multiple built-in values. However, 'the built-in' is used in the
previous sentence, now that I take a closer look myself.
