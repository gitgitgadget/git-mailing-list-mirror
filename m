From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: forbid --bare --separate-git-dir <dir>
Date: Mon, 7 Jan 2013 08:18:43 +0700
Message-ID: <CACsJy8A6soMEJ3FXY8MyeERAGN483M2UjqRS4muzzD6uj1QWow@mail.gmail.com>
References: <20130106091642.GA10956@elie.Belkin> <1357465670-32766-1-git-send-email-pclouds@gmail.com>
 <20130106101948.GD10956@elie.Belkin> <7v6239nbw0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 02:19:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts1NH-0003Vj-9a
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 02:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab3AGBTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 20:19:16 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59407 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062Ab3AGBTO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 20:19:14 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so16856602obb.33
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 17:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zc5eIgNXbDZJ5OPk3xhPwruf5ev9kqdEc57CLwj3w1A=;
        b=VRnz/AKh1xCA8gNxZdrZtPKQDTsFF/OtHBwFk14Ma8TapV6iMJxmmRatmn+b/fBqOn
         G5QcJXakjPIn3xBqtS/zcU3J8HGZ0usMvVFP/4/yB4UvGhDyHwL5HN/EsPryHEYS7YaZ
         k0FW3qg576HvPanXKlxkOrRx0q4FrI+9A3/eVOph4piCrmDWdSc/UfgViFgA2fwS8mIm
         QHFMt3pTv98jeBSpaxpTB1DvmrYai0jePxDegbrcG7edmoh8PvxQDVrDXH8/aNJ5oqb7
         h9PicyMgLOKB3lH72Ft3fbLsczS5ef08eomCXvQ6+dIoxQ6KnLuMoip7PoMAGcBdSuZ7
         RWBA==
Received: by 10.182.109.101 with SMTP id hr5mr42042318obb.84.1357521554190;
 Sun, 06 Jan 2013 17:19:14 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Sun, 6 Jan 2013 17:18:43 -0800 (PST)
In-Reply-To: <7v6239nbw0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212863>

On Mon, Jan 7, 2013 at 6:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I don't know what would go in the <explanation here> blank above,
>> though.  Is it possible that some people are relying on this option
>> combination?
>
> I do not necessarily think we must say "it happens not to work
> already for such and such reasons, lucky us!", but it is indeed a
> good idea to think things through, justifying why this cannot be a
> regression, and record the fact that we did that thinking, in the
> log message.
>
> Thanks.

I wanted to give a day or two or think about the <explanation here>.
Does "Thanks." mean you have picked up the patch and adjusted the
commit message appropriately, or should I go with my original plan and
resend it later with "explanantion there"?
-- 
Duy
