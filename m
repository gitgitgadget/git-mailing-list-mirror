From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 17:24:04 -0700
Message-ID: <CA+55aFzpT8b1E9PxJmCmfEg3k7yMX7iRcQQebV_6ZmwCwgqb9w@mail.gmail.com>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7vppwhb52f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 02:24:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uffnm-0007ny-4i
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 02:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758075Ab3EXAYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 20:24:06 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:53253 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915Ab3EXAYE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 20:24:04 -0400
Received: by mail-ve0-f171.google.com with SMTP id m1so2999199ves.30
        for <git@vger.kernel.org>; Thu, 23 May 2013 17:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=2G+JFX5gpDCVOraT4JUy7A6+CHOJZNM/2cPiphZtQ6U=;
        b=KXVYXNmEBPn6WUHKm6hQsg4KUu/93A8dJiuF2Mdg3Uz7mUdozmtxi+VAedD+cLmntd
         ILCB7pIfyy2xvTJlYJC8WUTDkxgL2r+ftAYgzdMKjXhhv/dcdlsFz9mvZjvKr+JUjAwY
         fAbEnZKQGqxkm94ZBbCQvBmITWnarSBpzSYmgM3DUJhIHQWfVZ8GFlR7BOtZJlxD3DxJ
         bS/mnv/8sU0DrxvzVZhjpT2cD38cnsqA5Wy7Eup0xyOOxfVzlxx73QvuiiphhvvVq3+B
         TWrIAEnK5k9SIwsHP1z+rnVyVnvHWhgMWEAsSDL8WKegqvX8fSk+cNpByznvo9qHwMTT
         eLqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=2G+JFX5gpDCVOraT4JUy7A6+CHOJZNM/2cPiphZtQ6U=;
        b=Hlj1RURrAAvSXVhoQbf4r/0HKKLt69YdQ4kG52II8sPC/f9v08r0J5wu8jKluCX5OP
         cVnfR+xDWoo9BjSOlKdCDEbbUy6kFXsInXvFXQk+S3sEhf9QtNek0ycx/L+koJbQjtNe
         emqDT6OcIrImS95ZvvtsmT/5fxoPft1fykLIk=
X-Received: by 10.220.104.135 with SMTP id p7mr6991548vco.10.1369355044080;
 Thu, 23 May 2013 17:24:04 -0700 (PDT)
Received: by 10.220.125.7 with HTTP; Thu, 23 May 2013 17:24:03 -0700 (PDT)
In-Reply-To: <7vppwhb52f.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 7RGKq_tlcrMsz6Zvuu4kfNUmsaQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225326>

On Thu, May 23, 2013 at 5:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I would assume that "no-ff" above was meant to be "--ff-only" from
> the first part of the message.

Yeah, I may need more coffee..

> I also would assume that I can rephrase that setting pull.merge
> (which does not exist) as setting pull.rebase explicitly to false
> instead (i.e. missing pull.rebase and pull.rebase that is explicitly
> set to false would mean two different things).

Yeah, sounds good to me, and doesn't really sound like it would
confuse/annoy anybody as long as it was clearly documented.

              Linus
