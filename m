From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: How to apply patches
Date: Wed, 17 Nov 2010 22:13:34 +0800
Message-ID: <AANLkTinR5Z60u5DYzgzuB0x7CmA8kVR04nLDJ4csDZJK@mail.gmail.com>
References: <1289988042359-5747036.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ananth <smilewithani@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 15:13:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIila-0002se-4N
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 15:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581Ab0KQONh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 09:13:37 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59528 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab0KQONg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 09:13:36 -0500
Received: by ewy8 with SMTP id 8so1172372ewy.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 06:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ZVnCm37uvUNTR0Wj7gLgetiyENgKkxNXel3Z39i2PuQ=;
        b=kW8cMszcHgg5LRImpgTlTXJcDsGf2wXuuJMkPFybkYilk2/YbzymNr5bUz27IVQ6C4
         T6GJR/4uLFeLN3BVOXQF0OCfi5y+STOCQUREhHoc1x1aXFxkx0jyEmF5b1N7aSoJJ8qN
         RkZreIA3sPmIjV3Yu6hMvg3q2OHDk3pHVFE+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Kbw15kcW3HQWUpD7M7KIgx81oXqg9IyxMI4caUs2/Xb5Ww6J6Udsxz1YSAB5rZ+mjN
         MGvo6ARJCLddt35CpFYHlPXTdbQ4kA0HfmAD+5pvi/wwk1AULwYDCys6b4on8PsyHI3+
         b3m6A9Gyu+MqrupW/qrySYaOeD25tPUSxJKp4=
Received: by 10.213.8.196 with SMTP id i4mr7785320ebi.2.1290003214926; Wed, 17
 Nov 2010 06:13:34 -0800 (PST)
Received: by 10.213.112.195 with HTTP; Wed, 17 Nov 2010 06:13:34 -0800 (PST)
In-Reply-To: <1289988042359-5747036.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161614>

Hi,

On Wed, Nov 17, 2010 at 6:00 PM, Ananth <smilewithani@gmail.com> wrote:
> I have copied the files for the base version using which I had
> created the patch.

Did you

  $ git add . # note the <dot>

and

  $ git commit

the destination ("base version") repo before applying?

-- 
Cheers,
Ray Chuan
