From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv2 2/3] git-p4 tests: work with python3 as well as python2
Date: Tue, 26 Apr 2016 21:03:55 +0100
Message-ID: <CAE5ih79Ot8QBDcRatxxxoQdGKFXNtoQ-=j4uWqQ2g=KjLBNiHQ@mail.gmail.com>
References: <1461657061-7984-1-git-send-email-luke@diamand.org>
	<1461657061-7984-3-git-send-email-luke@diamand.org>
	<xmqqpotcgt2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Sam Hocevar <sam@hocevar.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 22:04:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9DF-00036I-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbcDZUD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:03:57 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36220 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbcDZUD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:03:57 -0400
Received: by mail-oi0-f65.google.com with SMTP id i2so3495190oib.3
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=e4MpP+xC62F416ujYDRZTAML4bkrT0UPsl8NYIPN8W0=;
        b=PnlWhQGftPR2gwl75jqtfUdhN2T+XFaM3uMbekrX+C3p1VZvJQxT3QFcUfhIYdbU4s
         uORV444P5GORbv6L/AzycgQzuhMSOUZMax3fF9PVpEbjrscPMakWIDShiCiJU5xxPNdI
         B3YMoPdoXbEql3eHJPIPsX0gwiRXGK4qRc9wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=e4MpP+xC62F416ujYDRZTAML4bkrT0UPsl8NYIPN8W0=;
        b=LUk5C5MzU3IuGyzCbpfzuCodpF/5bTHwLPFLqpkBvNw3d2DLnXkTzXvS8mM6R8KdYp
         UlCB57RkS/hTh+d/YHDInYPERQplUxHCA9ygbittGbhVJLbrpfgY80zTLDuaoNxcX5QB
         G9pB/noOIzEf5fYTEMX9K9JfxdUOhTLDocQdp/RAC/dpMBK/sytpMITbC4948NJ0dqox
         ABp9jSNB+LZ6y9zOEE/kl8qXG2HQ619Yx9Yz6go+wBE3pJ6itRQurXolMnyOuhStZP/C
         +r8dmhhU41C/LitQMUHGUVRCVT3GYFHQjyTifZZhVntnaFabBOrLwt2iuKgXZaLHMy5C
         +gAw==
X-Gm-Message-State: AOPr4FWhtjzWQ/72IBgup3FEMGJobEPF4+WD5HLbbU1CSaXn/pQTyQnGMUjOXkRJlAmqWfGks5KH9+wBlm5ilw==
X-Received: by 10.202.104.213 with SMTP id o82mr1657662oik.165.1461701035912;
 Tue, 26 Apr 2016 13:03:55 -0700 (PDT)
Received: by 10.202.75.210 with HTTP; Tue, 26 Apr 2016 13:03:55 -0700 (PDT)
In-Reply-To: <xmqqpotcgt2l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292657>

On 26 April 2016 at 18:48, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> Update the git-p4 tests so that they work with both
>> Python2 and Python3.
>>
>> We have to be explicit about the difference between
>> Unicode text strings (Python3 default) and raw binary
>> strings which will be exchanged with Perforce.
>>
>> Additionally, print always takes braces in Python3.
>
> s/braces/parentheses/, I think (can locally tweak if you say so--in
> which case no need to resend).

Please do so, thanks!

Luke
