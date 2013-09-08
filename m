From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 03:49:32 -0500
Message-ID: <CAMP44s1ZjtVdj1wys_7VkBrmvGAkh9cfOpZ_22aVONMH3GdcRg@mail.gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
	<7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
	<xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
	<20130905080606.GE2582@serenity.lan>
	<CAMP44s1Rb2WKGD-QfNh055099R+9FHv9W8TA8Gfjp=qZh_7p7Q@mail.gmail.com>
	<8B7F235220624B259BB32B293BCB3E96@PhilipOakley>
	<CAMP44s2pw2TZSZ6pL-kx_QQCkjKrprERyvddCT-HTeo7uRNENA@mail.gmail.com>
	<01BEC88E9B724BA4986F2678A4D9F4E6@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Sep 08 10:49:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIagd-0004vG-FU
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 10:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab3IHItf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 04:49:35 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:45138 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab3IHIte (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 04:49:34 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so4081619lab.10
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 01:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DXHqi2tCj6nqgeQAHr5kBLMFovJYjSBNKyK7fEp6lBQ=;
        b=MVIA5sGbH98N0Nt9+TwLCcKM814Yoo3TJmR+S15VzDSkfkTjmZO/uV+ZqAo0OAnHwK
         0tj/OqGuIdXOZP1IYGBYoQtOoRy8ZXheq3ouM7n/Cyvq6ehaK50PC6NCkNJJmYt9615X
         kZBDjwUW4D5FNFcOCtghD318mVjDovHls+2NNhG7o7yQP81penhQFkLEles0M0zYA3jC
         KXefQK36NRtGb+GyUd320CbNNo+VLUN20bIviyTOrjjj3U5IAtr9dfwzYD/KbdzXV0N4
         FPMy4ESMlHkTBI6EIPFz7PqL9FfEapiE+wWieg9GF68UahV3lJii6nrmcF5ScfR0c5I2
         iHAw==
X-Received: by 10.152.178.226 with SMTP id db2mr752451lac.25.1378630172603;
 Sun, 08 Sep 2013 01:49:32 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 01:49:32 -0700 (PDT)
In-Reply-To: <01BEC88E9B724BA4986F2678A4D9F4E6@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234227>

On Sun, Sep 8, 2013 at 3:42 AM, Philip Oakley <philipoakley@iee.org> wrote:

> The 'problem' is (would be) that I don't yet know that I would need the
> --onto pu until I discover (how?) that the default rebase would result in
> conflicts.

I don't see what that has to do with an invocation of 'git rebase'
without arguments, and @{tail}. There's absolutely no way Git can
figure out for you which is the appropriate place for you to rebase
onto.

However, it shouldn't be too difficult to write a tool that checks
multiple commits and tells you on top of which ones a rebase could
work, but I don't think 'git rebase' is the right place.

-- 
Felipe Contreras
