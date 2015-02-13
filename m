From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] nd/multiple-work-trees updates
Date: Fri, 13 Feb 2015 17:14:43 +0700
Message-ID: <CACsJy8C+mSzwnEDvW4orMp-oyKX9_592r0Ed-UTfrH4Z1a6koA@mail.gmail.com>
References: <1420278087-14613-1-git-send-email-pclouds@gmail.com> <xmqqlhk2pwle.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 11:15:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMDHT-0005FD-35
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 11:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbbBMKPQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Feb 2015 05:15:16 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:63478 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbbBMKPO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Feb 2015 05:15:14 -0500
Received: by mail-ig0-f175.google.com with SMTP id hn18so9589795igb.2
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 02:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PlvTyikbOMqWuE+6r8kToRZ6MjxWozkCCt3lltOUW5M=;
        b=GedSMzMxoGchsi02rqg3I8kWo/VKicOfPPykCHCNjs9WxcV97TlAD60dubYqzx6pS1
         5Ab/z0fcybdZDZXj/vz95LgpBjqQ0Gm5JV2/dXCK4w2CA3aek4zpfajject7jSkEdc+O
         Jt2holHIAnKsdxDQZZIUZYjqRAmny4UPLzs/o0gY1xVMu8OIPAJxKGw5utTQ4m1zC9lO
         20aHmpnlcubk+I2Q0xC7Tn8PMaoafeMwcJx2HIg6ezXkBCegrrMrdBJaXCxqXHeESf9C
         nqfpO7CmooQdnBTaWc3nFMRCgf7AyZYWAnwhiUWbAPrAZmvxvBwPP/KceVsHLvHHu3Iu
         LgcA==
X-Received: by 10.50.62.110 with SMTP id x14mr2646887igr.2.1423822514017; Fri,
 13 Feb 2015 02:15:14 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Fri, 13 Feb 2015 02:14:43 -0800 (PST)
In-Reply-To: <xmqqlhk2pwle.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263805>

On Fri, Feb 13, 2015 at 5:57 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> These patches are on top of what's in 'pu'. They add
>> --ignore-other-worktrees and make a note about current submodule
>> support status. I don't think submodule support is ready yet even
>> with Max Kirillov's series [1]. His 03/03 is already fixed in 'pu'
>> though, so only 01/03 and 02/03 are new.
>>
>> [1] http://thread.gmane.org/gmane.comp.version-control.git/261107
>
> With the understanding (perhaps a strongly-worded paragraph in the
> release notes) that this is not suitable for submodule users yet,
> is this in a good enough shape to go to 'next'?

I'm not aware of any problems on this series (except submodules). So, y=
es.
--=20
Duy
