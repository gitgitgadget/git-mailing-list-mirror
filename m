From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 02:55:45 -0500
Message-ID: <CAMP44s1OcDT_V_grAiVHH+G_c-UQg_Jv64Uybr+ZbUF7EQiW_w@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<CAMP44s35HcjZ0sMjbOxHZt96v8S8eEFF+Y9JF_K9FKnFe-S9Xg@mail.gmail.com>
	<CACsJy8D6byr+ozGChScMr3rZ7dNGBbYzT5ROnvnTh4AC0x4dNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 09:55:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX5Pj-0002d6-Ri
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 09:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759151Ab3D3Hzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 03:55:48 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:38539 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112Ab3D3Hzr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 03:55:47 -0400
Received: by mail-lb0-f181.google.com with SMTP id 13so266801lba.12
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 00:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=MX8oEG9r7zLdNxlKEntKlmbmCfyeZLoVoocnLNHHMyk=;
        b=UJEH42uzwvk3/RL0ZpFyXDuU3UFGDX6zsSMexb74t7wvC2oAJtbyiPpOWBMAlMgZIb
         w9cJpaun6Imy0REXGkWaGsd7tTZewIJTxyClY2dDjmzVQSkDWH0pu8iy3Is7dAiduJhd
         IgTBnr3dQxGTv9r2oEBhjA5+mgeJt2bJkOdntlDWsYSRZulKeo68qJAqLMmyLHOgze5Z
         i6/KkzjJaaq6CTa18e7p+S1Uj0HNpzBFLybwYKTe1/wSOYmULvOZJRXPpY4bEama0sP4
         S2RcaBsMDL/FwM3pxMLA0Df3SKF+wuz6oJrk5Lbk0KfWeR4/3E3yY21oGP7ObHP3RVxj
         u+eA==
X-Received: by 10.112.17.36 with SMTP id l4mr4292364lbd.103.1367308545788;
 Tue, 30 Apr 2013 00:55:45 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 00:55:45 -0700 (PDT)
In-Reply-To: <CACsJy8D6byr+ozGChScMr3rZ7dNGBbYzT5ROnvnTh4AC0x4dNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222917>

On Tue, Apr 30, 2013 at 1:30 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Apr 30, 2013 at 1:10 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>>> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
>>>> 'master@'.
>>>
>>> I'm a bit reluctant to this. It looks like incomplete syntax to me as
>>> '@' has always been followed by '{'. Can we have the lone '@' candy
>>> but reject master@ and HEAD@? There's no actual gain in writing
>>> master@ vs master@{0}.
>>
>> That's what I tried first, but it just didn't feel elegant to have one
>> check for this case only. foo@ does follow naturally, and it doesn't
>> hurt.
>
> I'd say it's a side effect. This would stop both @{-1}@ and master@.
> Whitespace corruption expected.

Yeah, this is what I did first, but if since there's no relation with
anything else, '@' could be any other character.

-- 
Felipe Contreras
