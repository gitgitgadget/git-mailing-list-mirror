From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv3 4/4] t7500: add tests of commit --squash
Date: Thu, 23 Sep 2010 16:34:11 +0000
Message-ID: <AANLkTim=i3UqVTo7_OTr+qCW3JdMLugVBG84M6h9ZXM5@mail.gmail.com>
References: <1285258997-12497-1-git-send-email-patnotz@gmail.com>
	<1285258997-12497-5-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 18:34:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyokV-00083z-KK
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 18:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646Ab0IWQeN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 12:34:13 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57737 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab0IWQeM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 12:34:12 -0400
Received: by gwj17 with SMTP id 17so632023gwj.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZyZJUNU7YXnFxk+LqmRYOYyAAOHnHyyUTeHKDTykqjw=;
        b=DX0dLMP6Cw9fWnf9Dd+XoSJHkuXPly9kcnf8tYNpttj7Iq7NNDkv4bJL7WPTgrNGwC
         6zEN/Sc+lZOyd5xjGQKkqPiUb/7vQqBgj8ftsfA6t7/WK8UUNt5VtnR5+FY+vYbCiZOg
         alJ8/OfBS9OqWl4brn+F+zO84qFb+CpohfQQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dCee5GwolBk5UbhGfHkDfJDF1/oIgCALEhUdyVll57LG4QpD89WpuJ0pOZsqeKlvfW
         tKmTg7+9TkdA3hDY7aJ8c+3dPvsbhHCIe5jgMCpdX2SIPWGAIc9x5b2ZwSGXZK6/9OIz
         ACpO7BYry1gXmz9UcoV7XDby/DhimmyFfp0Hs=
Received: by 10.150.216.7 with SMTP id o7mr3028440ybg.199.1285259651846; Thu,
 23 Sep 2010 09:34:11 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 23 Sep 2010 09:34:11 -0700 (PDT)
In-Reply-To: <1285258997-12497-5-git-send-email-patnotz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156878>

On Thu, Sep 23, 2010 at 16:23, Pat Notz <patnotz@gmail.com> wrote:

> +test_expect_success 'commit --squash works with -F' '
> + =C2=A0 =C2=A0 =C2=A0 commit_for_rebase_autosquash_setup &&
> + =C2=A0 =C2=A0 =C2=A0 echo "log message from file" >msgfile

Missing &&
