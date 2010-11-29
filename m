From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 5/6] web--browse: use (x-)www-browser if available
Date: Mon, 29 Nov 2010 20:16:08 +0100
Message-ID: <AANLkTikXSx7WDaWes2nNH0XqP_xJui-k0ewLtrM6GL3g@mail.gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291042075-19983-6-git-send-email-giuseppe.bilotta@gmail.com> <20101129164837.GJ8037@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 20:16:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN9DI-0002xG-7J
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 20:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab0K2TQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 14:16:31 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53589 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab0K2TQa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 14:16:30 -0500
Received: by gwj20 with SMTP id 20so2248600gwj.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=mKQYLN2iql5FnhyNNaiGv2TFppJ+6Krv8eCQKr0VvYM=;
        b=MPIDGdp9FFPc3DZSYRlZt8iIiydtrhnBYDmgzJGuzDk1y3SdhUZ0aqfUVFmonZCSw5
         /Fx8+KLbNng4alEk0yBRDLJa1gwzRQ+nD8JDO48znY2WlHZY6VS2d2h7A957W06+jhgk
         wHeAbqrtsk+Jxs+5kyJGYb7V1IKlA59QtkDAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=s3nYZ5QRKoAfrzv3PtyceIMrU5/yvgeuuwKsv+XedXdYIQlkBuKEbbSB+Bh+lyiOVV
         fGx1Z2Z6l0MCBmVgWTOR/v9J9BXh6bytzHIDmiRrN2+m9QAtwEsnrX085vx/1RAMxTAt
         iiC6Z02qaxGUff4PmH8mb5BIeWUKowh3mXBwQ=
Received: by 10.231.35.75 with SMTP id o11mr6048849ibd.107.1291058189139; Mon,
 29 Nov 2010 11:16:29 -0800 (PST)
Received: by 10.231.17.135 with HTTP; Mon, 29 Nov 2010 11:16:08 -0800 (PST)
In-Reply-To: <20101129164837.GJ8037@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162416>

On Mon, Nov 29, 2010 at 5:48 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Giuseppe Bilotta wrote:
>
>> Debian and derivatives have an alternatives-based default browser
>> configuration that uses the /usr/bin/x-www-browser and
>> /usr/bin/www-browser symlinks.
>
> Mm, maybe it will be time to look into adding xdg-open support
> soon, too.

That's probably a good idea, although I think there is no way with
xdg-open to say "open in a new tab".

-- 
Giuseppe "Oblomov" Bilotta
