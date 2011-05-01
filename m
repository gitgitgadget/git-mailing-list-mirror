From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Add --info-path and --man-path options to git.
Date: Mon, 2 May 2011 08:47:22 +1000
Message-ID: <BANLkTim1SKiD5va_2TBLkrn6-N9oJuSEug@mail.gmail.com>
References: <1304237785-56101-1-git-send-email-jon.seymour@gmail.com>
	<7vbozmthhy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 00:47:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGfQU-0005tL-Nw
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 00:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757Ab1EAWrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 18:47:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49701 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab1EAWrY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 18:47:24 -0400
Received: by vws1 with SMTP id 1so3886985vws.19
        for <git@vger.kernel.org>; Sun, 01 May 2011 15:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tUF5aJ6jhgnaOvcKJJBJ632oi1/Or3MY+Bz7dli+MiY=;
        b=oAio5eEbhSDd3c6INebmBsWeEaYYls9XvmrRyXSLd4j5vMrtfwxv9oVLpNiGnLxD/I
         NY/y55VHx7zZ5P7l5qgfrssg9lzX6If0L+oc4OKKmNYQ8CzvACvk7A75g9r3iiXfck3V
         3LwO+zi9SlT3SIFwW/dgw83AmV10W90o0vEc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DH0UuDRwiw78DweOQVJ0PCEoW8nvt+xppQFOlg0l+qRLcUWh2VAQLuRl4DKSPjmM3T
         9Uus+cpffEhQSAUeMu/Ff8p97oIg8R5Gm9DWhntz2gdEemqS4d+UySHBX6adGhLzDeky
         GXKBWOv7Db98ggXAkUVWpJx60h31UwQRgNjW0=
Received: by 10.52.110.133 with SMTP id ia5mr5681609vdb.239.1304290042407;
 Sun, 01 May 2011 15:47:22 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Sun, 1 May 2011 15:47:22 -0700 (PDT)
In-Reply-To: <7vbozmthhy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172550>

On Mon, May 2, 2011 at 4:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> To better support git extensions provided by 3rd parties
>> which would like to install their own man pages and Info files
>> in the same place as git's own man pages and Info files
>> add support for --man-path and --info-path options.
>>
>> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
>> ---
>
> This an improvement that is pretty much independent from the issue of
> third party extensions. In fact, even people who would oppose to the idea
> of any third party crap [*1*] contaminating the install directories owned
> by git may want to this patch.
>

Thanks.

I agree the sentiment that suggests that we don't want to pollute
git's own directories with 3rd party contributions.

This, indeed, is part of the motivation for a --plugins-path option
which would provide a physically separate location for 3rd party
contributions, per the earlier discussions between yourself and
Jonathan Nieder. I'll put together a suggested patch for how this
might work in the next week or so.

jon.
