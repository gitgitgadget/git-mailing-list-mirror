From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sat, 9 Feb 2013 19:59:41 +0700
Message-ID: <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com> <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 14:00:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4A37-0002wz-87
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 14:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506Ab3BINAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 08:00:16 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:56636 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048Ab3BINAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 08:00:14 -0500
Received: by mail-ob0-f180.google.com with SMTP id ef5so4661726obb.25
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 05:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jJLaZeGWsNpXttukm5kQhgDnc6StGRLAUPRi48PUA5c=;
        b=HsnZAJ/13599c0q3X0t1yRnVQG1tofIT4eICxnqNUQ0z2O8SpZgbD5puppjwnlipOQ
         ZJNYczQ52P+lOZnkic3pI9EyeAuB6NG/weBRD7Ab1P5ke2IpAlO6HRsPKb6hBmMeo39O
         i+NKRvuwHr18pM+HSwbYVQ4vyEtRFEgHd0eyWSnN1AoEzDPF57WRA4FfLw06/wiQTXFh
         JjJh9dCir0zGaEcevmt1N4/kMXcbeRqEZas5ucDchjgCfFHsljn72qSi8jtZxq+D4EvQ
         NU1KTPm3BEvQRO90+B/pzDd8zNT+p8UUscrH0TGePKnd8DYR5kUiqtNWfqEDZvwvGVUk
         XbsQ==
X-Received: by 10.182.127.115 with SMTP id nf19mr6522502obb.49.1360414811643;
 Sat, 09 Feb 2013 05:00:11 -0800 (PST)
Received: by 10.182.129.46 with HTTP; Sat, 9 Feb 2013 04:59:41 -0800 (PST)
In-Reply-To: <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215864>

On Sat, Feb 9, 2013 at 7:53 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
>> What about getting systemd to watch everything for us?
>
> systemd is the perfect candidate!

How about this as a start? I did not really check what it does, but it
does not look complicate enough to pull systemd in.

http://article.gmane.org/gmane.comp.version-control.git/151934

Youo may want to search the mail archive. This topic has come up a few
times before, there may be other similar patches.
-- 
Duy
