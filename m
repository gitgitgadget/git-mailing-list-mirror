From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Tue, 18 Mar 2014 05:59:32 +0700
Message-ID: <CACsJy8BgHp=w3RU==9tiebnOPxzCnwurpZbNjxtS5O=q_kDcOA@mail.gmail.com>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
 <1394976904-15395-6-git-send-email-pclouds@gmail.com> <xmqqfvmgbhlb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 00:00:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPgVt-0004AU-HU
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 00:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbaCQXAD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2014 19:00:03 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:52396 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbaCQXAD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 19:00:03 -0400
Received: by mail-qa0-f47.google.com with SMTP id w5so6129415qac.34
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 16:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=iKo4ejQpuFGHCJPaFPEiWbLZxqwXjIs8jhAfA1ELfU4=;
        b=ii92R5jNcIpEXCQS6SzNTx9nFSNoqv6UwdRiG1DRXhdOqm2BGT80GqoPQqcFRSueEm
         JoGEgUKhw4d4c6DJbtA5VSTPOFCAtTSi08TDaGWeSYK4JM5VX71a0HKhGTs7PcbvBG5/
         LdF9PLZQT5HqUwl7FgWeMCg9uFuhHitBwndgOV+TZIEYtCs0rg7/jcEmpZ1Ro/4k5s/v
         ujpSuqfqKiV7N7xNH4sn9NHz7aSgkOpA1YNDET2ix53lB3BdvuR76kToiTC9g8+uFuCQ
         l45WH2UrqcW0NP6O0zCm5bpWCZZd7sGHTO7UWpBdwLLZ2FZhnO5Ga6cM9dAnq/GoClxh
         gJVw==
X-Received: by 10.140.40.5 with SMTP id w5mr29587590qgw.65.1395097202058; Mon,
 17 Mar 2014 16:00:02 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Mon, 17 Mar 2014 15:59:32 -0700 (PDT)
In-Reply-To: <xmqqfvmgbhlb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244306>

On Tue, Mar 18, 2014 at 5:12 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> As explained in the previous commit,...
>
> [PATCH 3/4] becomes a commit with an empty log message for some
> reason.  Have you tried running "am -s" on it?

"am -s" worked fine. "am -s --scissors" did not (because of my use of
scissors in the commit message). Not sure what happened on your side..
--=20
Duy
