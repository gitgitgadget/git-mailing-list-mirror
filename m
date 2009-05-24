From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: hg2git error
Date: Sun, 24 May 2009 19:38:18 +0200
Message-ID: <fabb9a1e0905241038x7ea22622k930f50b9c7598c6e@mail.gmail.com>
References: <alpine.DEB.1.00.0905241932301.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Rocco Rutte <pdmef@gmx.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 24 19:38:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Hep-0002is-Rz
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 19:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbZEXRij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 13:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754440AbZEXRii
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 13:38:38 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:43808 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439AbZEXRih (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 13:38:37 -0400
Received: by ewy24 with SMTP id 24so2701799ewy.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=yvQnUBusQLq4cFqkwXsegWyU4YLlqt9S0xQFOwnvPhM=;
        b=UWfE5e8gcDQyy4d8tpOY9EcruNZb+zCB7URW/wALtub9VvmBdxoVxlvvDvn0BQGi4G
         60/e0ELe8HpTg6sseHyMKiAYG+2dzpSXv6jTmD3QCozDeQPVzELsCB61rZYkebMkCUtI
         709eRM/EJTvthE+/AKzQFX+l9ota8qWnTMTjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ngSva6QgX4jwwSnCAiyBbUUa2h54eok7b+zVlkTNHfK3DX78TG0AvAF6lL4Ol0q3P4
         M5R3Btlb2kJ75rdNggws5grPFX8Wy/DEpb8YaK8Qa0d0077y/ZW7WIGuTyRkuSR5GUvv
         vg+dhzTM04iF2uXuK77SYdmOSWbovgbXvI9mo=
Received: by 10.216.8.78 with SMTP id 56mr1243473weq.210.1243186718139; Sun, 
	24 May 2009 10:38:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0905241932301.26154@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119845>

Heya,

On Sun, May 24, 2009 at 19:33, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> How to cope with that?

I've been working on making hg-git [0] usable as a two-way bridge
(that is, use it to interact with a hg repository using git). It is
coping just fine with unnamed heads so far :).

</shameless plug>

[0] http://hg-git.github.com/

-- 
Cheers,

Sverre Rabbelier
