From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sat, 7 Sep 2013 21:41:00 -0500
Message-ID: <CAMP44s0kMbXvcJbWvJDu=8A5iOeH4fsMGUdT-ehXKNXiV1FQ1Q@mail.gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
	<7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
	<xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 04:41:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIUw0-0001Qp-0X
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 04:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761Ab3IHClD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 22:41:03 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:45787 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563Ab3IHClC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 22:41:02 -0400
Received: by mail-lb0-f177.google.com with SMTP id p5so3948388lbi.36
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 19:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/5uzKyHOLzbcXkwLWcnEHzD6RbvB3sZ8o22kHfMSA/U=;
        b=nAshziBnO0c6Q4eZ5O5DcMV4JA58dR1jPO5n4JifJwTTkQRNuO1PalXwdQuWyhg6iH
         OsVrWCsYrkR10nScOHUqYepcG0ClUeqeb6go3w/ZE5AFdIskXIc7VIe0hoFm43Mg2CKK
         fzCFaSZg/oMal0ExqF4Slka6rprfUklHmVqeHndkEeAHbatqBLtezb+jayKFwTUUNJ4U
         onnoMbqeaGkTuLojPwQpvYArnqOEZrykLhRBRjrN0Qg/xUsLj5NyY8eEngNPpDqdaB0F
         KknwEfvNmwT7r1A1Azi4Vc2grHp5FGevK+pPu53aEQZmWT9RL4jx7i3ZBdTqofLzCZht
         Qhgw==
X-Received: by 10.112.42.103 with SMTP id n7mr9933400lbl.6.1378608060885; Sat,
 07 Sep 2013 19:41:00 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 19:41:00 -0700 (PDT)
In-Reply-To: <xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234164>

On Wed, Sep 4, 2013 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Which can be solved by adding the above "fail" option, and then
> renaming them to "pull.integrate" and "branch.<name>.integrate" to
> clarify what these variables are about (it is no longer "do you
> rebase or not---if you choose not to rebase, by definition you are
> going to merge", as there is a third choice to "fail"), while
> retaining "pull.rebase" and "branch.<name>.rebase" as a deprecated
> synonym.

All these names are completely unintuitive. First of all, why
"integrate"? Integrate what to what? And then, why "fail"? Fail on
what circumstances? Always?

My proposal that does:

  pull.mode = merge/rebase/merge-ff-only

Is way more intuitive.

-- 
Felipe Contreras
