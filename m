From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] am: format is in $patch_format, not parse_patch
Date: Mon, 29 Aug 2011 18:46:42 +0200
Message-ID: <CAOxFTcwcBgCNpwNNdsQXwE92w6948cfjwMTum03D+SJ0Rq-Yuw@mail.gmail.com>
References: <1314631326-11796-1-git-send-email-giuseppe.bilotta@gmail.com> <7vaaas6vtt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 18:47:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy4zN-0001Gz-Pr
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 18:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab1H2QrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 12:47:05 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37068 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab1H2QrD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 12:47:03 -0400
Received: by iabu26 with SMTP id u26so635623iab.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Radsd0VLTIQPX9zRpXwqu1d2LYSSX4+qUAVagiP+YJ8=;
        b=UYS7j+lyb4gIwO0YkEENrJ0K9tnRYCIcp/p9q0ucX+tkRBITRBJ1EkgjMD+rQ8+QYy
         OB4RWBM0k1g2I2DlLu+/ZzAtABROME7dV9ruW1SkfSLJqqtZualncyXcva2dKU5icxmd
         9XSDIpxiAqmSGUTTEU7ZmWJRsRlmDf7xm8vvY=
Received: by 10.231.29.101 with SMTP id p37mr10926695ibc.81.1314636422108;
 Mon, 29 Aug 2011 09:47:02 -0700 (PDT)
Received: by 10.231.14.131 with HTTP; Mon, 29 Aug 2011 09:46:42 -0700 (PDT)
In-Reply-To: <7vaaas6vtt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180319>

On Mon, Aug 29, 2011 at 6:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> The error message given when the patch format was not recognized was
>> wrong, since the variable checked was $parse_patch rather than
>> $patch_format. Fix by checking the non-emptyness of the correct
>> variable.
>
> Thanks for a fix to a problem that is from more than two years ago ;-)

You're welcome. I'm actually surprised that wasn't something _I_ did
by mistake ;-)

That part of the code isn't being stressed too much. I've just found
another issue. Patch coming, plus another enhancement.

-- 
Giuseppe "Oblomov" Bilotta
