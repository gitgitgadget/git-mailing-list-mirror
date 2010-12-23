From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Thu, 23 Dec 2010 23:32:42 +0700
Message-ID: <AANLkTinH0h5euL=_wMpGirVEEYgoA9hXGhKGja9oPa2j@mail.gmail.com>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 17:33:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVo6n-0007KN-2r
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 17:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab0LWQdQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Dec 2010 11:33:16 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59539 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab0LWQdQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Dec 2010 11:33:16 -0500
Received: by wyb28 with SMTP id 28so6235323wyb.19
        for <git@vger.kernel.org>; Thu, 23 Dec 2010 08:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oCETg76rLsuDjFJP/ojeOVHMYTkEATnKYsPcm8yjiHE=;
        b=i3HRLvBmrGpYyxxmgxB3UHnXuzjwVR0R83JqH7GnnE9C5EDGJTTNSOJyzkLYXdseu/
         iI+pY//MQoVhvmHQU4FCdEz1i3bjY5YThZva4ORnOtN7d5499UiMpNJ616zn4orp4Epn
         oD5Y4V7+eV4ksZx5t77ZQvGsvc9GvTyZfdoNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eVce+Y34j71rgvFcMzt6rfpLVK2r3Uns9AlN+ajHlGg1PD2uiKcM8109HEmllnqPyv
         SGLpgvUqtyzJy5bJhN0W8ICbfqhaiC1WVNlo+RYSl0H8YUZ/FNoZXLvCPCdatJZLLr+i
         CLbwVXqUd4LFqGLlgrc6SDZMX87X3a1gTvpGw=
Received: by 10.216.177.9 with SMTP id c9mr9497901wem.34.1293121994199; Thu,
 23 Dec 2010 08:33:14 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Thu, 23 Dec 2010 08:32:42 -0800 (PST)
In-Reply-To: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164128>

On Wed, Dec 22, 2010 at 8:59 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> * nd/struct-pathspec (2010-12-15) 21 commits
> =C2=A0...
> =C2=A0(this branch is used by en/object-list-with-pathspec.)
>
> Rerolled again. =C2=A0Getting nicer by the round ;-)

With jj/icase-directory merged to master, match_pathspec() and
match_pathspec_depth() now diverse again.

When I wrote match_pathspec_depth(), I assumed that match_pathspec()
would not change much and I would have more time for converting the
rest of git to use match_*_depth(). Looks like I need to add case
insensitive matching to struct pathspec and friends then remove
match_pathspec() in this series too. At least if somebody changes
match_pathspec() again, it would cause a conflict so I can catch it.
--=20
Duy
