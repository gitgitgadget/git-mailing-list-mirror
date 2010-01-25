From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH not-for-mainline] Implement git-vcs-p4
Date: Mon, 25 Jan 2010 23:28:10 +0100
Message-ID: <fabb9a1e1001251428q123aa473x2fb448cfa33f5168@mail.gmail.com>
References: <alpine.LNX.2.00.1001251628431.14365@iabervon.org> 
	<fabb9a1e1001251353q3739a5efq38606ca0b63ce10@mail.gmail.com> 
	<alpine.LNX.2.00.1001251708530.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 25 23:28:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZXQC-0006cS-NE
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 23:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624Ab0AYW2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 17:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144Ab0AYW2d
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 17:28:33 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:40178 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab0AYW2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 17:28:32 -0500
Received: by pwi21 with SMTP id 21so2574582pwi.21
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 14:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=woml0BR6EkiDERfmR18dqk5y2gxsR5Dox92LpqiYw2Y=;
        b=P5uxvRuOgENIcu7nWYkHAXwov5jKUG843CJ0ODtpyQXljAoObp9Cw1VmR/qDN00KQE
         8wBFO71Zn5DNz3BPXwtOCZ9eyMzJw25e4+9KSJ84PCXRaIM1CIssAfeAazYgyApgANVv
         qYj8FQqkr/OIgA7Y97hUsggWxXvb5uc9BGxPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=BdKZEsl2i43cePrCYztBGk3IFuhX5zdkfk5vVGVaobcK/RLS+z2OJasH+NwH0+Y5qs
         FLa8akQVa7t8Z/zGuHPKhcW2pCphvtruP9t5FPDkRtwj30JE5bg2Z/zmoocsvbMqYzL+
         Kwfx0EaYFymJ6pBS16cOPRWwmLx/FWRbIOqko=
Received: by 10.142.2.10 with SMTP id 10mr3570659wfb.297.1264458511632; Mon, 
	25 Jan 2010 14:28:31 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1001251708530.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138001>

Heya,

On Mon, Jan 25, 2010 at 23:26, Daniel Barkalow <barkalow@iabervon.org> wrote:

> That's the right thing to do. However, you might notice that there's no
> code around to actually do it (or anything else, presently).

Check, I reckon I can look at how the 'import' command is implemented,
and turn the logic around (tie fast-export's stdout to the helpers
stdin or such).

> I've been working primarily on non-git-related stuff lately, and that's
> been keeping me pretty busy.

I know the problem :).

> I can definitely review and discuss design
> issues, but I'm not sure I'll manage writing anything any time soon.

Ok, fair enough, hopefully I'll have some code to show soon :).

-- 
Cheers,

Sverre Rabbelier
