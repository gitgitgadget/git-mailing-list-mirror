From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Draft of Git Rev News edition 8
Date: Sun, 11 Oct 2015 11:56:32 +0200
Message-ID: <CAP8UFD0VJhwf1Gkk28nEWnpR3vugeJs3hD459+WPBsG5oNyjaw@mail.gmail.com>
References: <CAP8UFD1a=1c2g9MfeSo1rPL7BFrFQG9RQY6OmdaJQtoL2wZang@mail.gmail.com>
	<CAPig+cQrJFEOSiNQ=Ls0XZJUQWre+_QniKo1RFofg7orj7ts4A@mail.gmail.com>
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
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 11:56:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlDMt-0003zp-41
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 11:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbbJKJ4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 05:56:35 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34939 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbbJKJ4e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 05:56:34 -0400
Received: by lbwr8 with SMTP id r8so116978819lbw.2
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 02:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ok0+ZU/s5yCYnWKEAN8UHTvddYAfOf+oCe+FSA2aBX4=;
        b=QmfCvxwzO7ZIzAwiLOV3/1UAGuMhfRP2thzJywXeJPZhW4uhrNRBXH9DrS2L2nlzuL
         eemmTgn5FbC+q4KQkCVCcOs3TGp3wGjf8W28+qDqp7rX9bKab7FkzUmBA+mTKurH2sOP
         bd13cHdlWYgMQ4vckuGBmO8LiMgxskMTyIgOXZtuycELkpOhiu0AlR1ErHgbwMxioh2V
         8uNOkOVnTD51YDCIQiAyTcGmmqQuH3RQeEcoPoSTaekQyUZNGGcFH6lVfDr2Vllv5gR+
         g9TIlN5/Dxggbftavc0oZYJdZVS0iCrlJeCkUZI6EKF2rF01NfHjRpHY6OVqSFZ4vIVp
         tKSw==
X-Received: by 10.112.63.233 with SMTP id j9mr10053653lbs.113.1444557392666;
 Sun, 11 Oct 2015 02:56:32 -0700 (PDT)
Received: by 10.25.89.130 with HTTP; Sun, 11 Oct 2015 02:56:32 -0700 (PDT)
In-Reply-To: <CAPig+cQrJFEOSiNQ=Ls0XZJUQWre+_QniKo1RFofg7orj7ts4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279333>

On Sun, Oct 11, 2015 at 1:45 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Oct 10, 2015 at 7:36 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> A draft of Git Rev News edition 8 is available here:
>> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-8.md
>
> Does Karsten's comprehensive post[1] about nanosecond-related racy
> detection problems merit mention?

Yeah, probably, would you like to write something which can be very
short, about it.

We would also gladly accept something about Git version 2.6 (hint, hint :-)
