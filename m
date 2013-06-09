From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 09/45] sequencer: remove useless indentation
Date: Sun, 9 Jun 2013 13:19:03 -0500
Message-ID: <CAMP44s3VL-uDPcsUyaYX3ESFbdj7h0XGuVZD+y8J_KewHcPC5g@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-10-git-send-email-felipe.contreras@gmail.com>
	<20130609181724.GA11516@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:19:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlkCs-0005wb-UK
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab3FISTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:19:06 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:62496 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab3FISTE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:19:04 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so1162958lbc.3
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mEHASWAKqv4C9PPt9U4bvIC7Ba2nedkyFSyOnlPV0A4=;
        b=ROFhVd0gmVhkQfNHY+Xlh4mFm0wyAPwcJMu7QFlH5PTvkCJRNvle72nfMt91DjVRpN
         tq+3hJAumssuMKOZ5wZKIsIfgTna86DPdLGPOrcUWwzIZTrZ1IBmC9tzL67ShIOOKGJP
         QY9b1wdJWm1xKID/WjAYqPg/Qrpe6zJipYa3MO6GwFJJ13y3rcW4GLV5aXogBZvT+hK+
         dF7jP0crJYZCTwVM5WOhQ2ZaZsZ6TtkRbqoa8NVAoutBFh6GU2rqdsGc5fxERUIhljyg
         lhEvELK6xaQIUI1GA4piWAF/69YQgdPsxYEglgXP4U+ogcOFpOpcYGAZP3UQnTKrQOgl
         7P5A==
X-Received: by 10.152.27.170 with SMTP id u10mr3367098lag.45.1370801943155;
 Sun, 09 Jun 2013 11:19:03 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 11:19:03 -0700 (PDT)
In-Reply-To: <20130609181724.GA11516@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227083>

On Sun, Jun 9, 2013 at 1:17 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Sun, Jun 09, 2013 at 11:40:21AM -0500, Felipe Contreras wrote:
>> By using good ol' goto.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> I don't see this as an indentation change but as a restructing of the
> code. I would prefer something more like
> "Replace early return with goto cleanup" (but better phrased).

The explains what the patch is doing, but not why. Why is more important.

> The same goes for the next patch in this serie, I would prefer if the
> shortlog tells what have been done, not how hard it was to do.

It explains what it is, and why it makes sense.

-- 
Felipe Contreras
