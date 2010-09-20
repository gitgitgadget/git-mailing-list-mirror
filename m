From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/6] Introduce pathspec struct
Date: Mon, 20 Sep 2010 02:31:51 -0600
Message-ID: <AANLkTimR=mgjFYwdzqUF7_0j33ha4AJcrJbuL7VJunPK@mail.gmail.com>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 10:32:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxbn5-0007Pi-0r
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584Ab0ITIbx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 04:31:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62558 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab0ITIbw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 04:31:52 -0400
Received: by fxm3 with SMTP id 3so488275fxm.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M1IJC3uR5kZCQHp42hAveIbLt94fvukKddrd0BerSQ4=;
        b=kxDCgHQ4ruYXxBuihGDlWt8MArZ02mKbcNSv182ZOS83fap6/EBrhiIfMbEIzoWykv
         FJvCWDJPF6vO+DmgHi5lQKX8e7qJTSlgcO7FjGl5aycVbrawt3bGaaAjSv1cRgxPJktr
         OoF5/g7WzXWhKcDt3Jh1o8oLjiF8UA++DthX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iz69sJcaCJaw/DVSRV/w3e51EjGDInn7+tNP7dakEy1KJrjraMWhellG0guET6Sed7
         KaI/W/jb5NifpPx2lsQ1Ntud+stkMOqdic/C64X+lBmuDj25b8UCUjAjN0eNYCvYb5iv
         ot1EtePOHqcn86DPpcFnoD+uSK2au5gAhwLMI=
Received: by 10.223.121.134 with SMTP id h6mr4192848far.74.1284971511477; Mon,
 20 Sep 2010 01:31:51 -0700 (PDT)
Received: by 10.223.120.131 with HTTP; Mon, 20 Sep 2010 01:31:51 -0700 (PDT)
In-Reply-To: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156598>

2010/9/19 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> This is base series for en/object-list-with-pathspec, the upcoming
> wildcard support in diff family (i.e. tree_entry_interesting()) and
> negative pathspec farther in future.

I briefly looked over the series.  If I understand correctly, it's
pretty much the same as your previous series, except that it uses a
new data structure instead of exclude_list, and doesn't include my
two-patch series anymore or negated pathspecs.  Is that correct?  If
so, it looks good to me.

I'll try to test it soon, and resubmit my "Nuke match_tree_entry()"
(which duplicates code from tree_entry_interesting()) patch on top of
it.


Thanks,
Elijah
