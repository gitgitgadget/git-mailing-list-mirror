From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Draft of Git Rev News edition 8
Date: Thu, 12 Nov 2015 20:00:34 -0500
Message-ID: <CAPig+cTEk+hoS91H4HbwNwdJYnZ9bGXbza5UMdLp=YxVFX-9VQ@mail.gmail.com>
References: <CAP8UFD1a=1c2g9MfeSo1rPL7BFrFQG9RQY6OmdaJQtoL2wZang@mail.gmail.com>
	<CAPig+cQrJFEOSiNQ=Ls0XZJUQWre+_QniKo1RFofg7orj7ts4A@mail.gmail.com>
	<CAP8UFD0VJhwf1Gkk28nEWnpR3vugeJs3hD459+WPBsG5oNyjaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Lars Schneider <larsxschneider@gmail.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Stefan Beller <sbeller@google.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Roberto Tyley <robertotyley@gmail.com>,
	=?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Karsten Blees <karsten.blees@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 02:00:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx2jI-0007yV-03
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 02:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbbKMBAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 20:00:36 -0500
Received: from mail-yk0-f195.google.com ([209.85.160.195]:34214 "EHLO
	mail-yk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbbKMBAf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 20:00:35 -0500
Received: by ykay124 with SMTP id y124so11520169yka.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2015 17:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yv/OYkQaNuTndGA2lrkxIYtIZB3PZdcf5CWbRQS/9kM=;
        b=KlfnPx4K1k4QG7d3fEXmQzaCNCZQ9dRc2YObwT5x0igkQSPylyrB8ruCOr36WZx7Vc
         j70SH+7KZm6GbpNrj97L6PVry7YojYUnUUCVxtAd+ZgZt0Kvv0saaIwLzm3joQ/JFJla
         hNmpfwH0D3a5DgXU9V2gFXTYDaxYeb6xLuKFj4zuD4YgJGIee7aXQirap74aeHG7d84Y
         zu5Nor08hBmpBEOOyDKuyJNXoNlZO0uqx46WVqCCx9WvKQtQmNizZ1ojYXGWFqtnvlw0
         YEbVGb/6R0IlxtW69G+B9aOokVbzUHNm6X0A6nI0NRnYalaorZW9KDJ6NlCCKFzw4OOB
         vlzQ==
X-Received: by 10.129.136.69 with SMTP id y66mr19668939ywf.242.1447376434621;
 Thu, 12 Nov 2015 17:00:34 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Thu, 12 Nov 2015 17:00:34 -0800 (PST)
In-Reply-To: <CAP8UFD0VJhwf1Gkk28nEWnpR3vugeJs3hD459+WPBsG5oNyjaw@mail.gmail.com>
X-Google-Sender-Auth: JohVsJM3P6ianf0VWKtl7_811Hs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281223>

On Sun, Oct 11, 2015 at 5:56 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Oct 11, 2015 at 1:45 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Oct 10, 2015 at 7:36 PM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> A draft of Git Rev News edition 8 is available here:
>>> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-8.md
>>
>> Does Karsten's comprehensive post[1] about nanosecond-related racy
>> detection problems merit mention?
>
> Yeah, probably, would you like to write something which can be very
> short, about it.

Thanks for picking up the slack here and writing about Karsten in
edition 9. My git time has been somewhat sparse of late, and this task
kept slipping farther and farther down the list.
