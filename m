From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/6] Introduce pathspec struct
Date: Tue, 21 Sep 2010 08:15:20 +1000
Message-ID: <AANLkTikYpt75f7yGgzTwKj9fMUAytxkN+jHPRY=8W9hE@mail.gmail.com>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
	<AANLkTimR=mgjFYwdzqUF7_0j33ha4AJcrJbuL7VJunPK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 00:15:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxodz-0007eD-PQ
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 00:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719Ab0ITWPW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 18:15:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40986 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab0ITWPV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 18:15:21 -0400
Received: by wyf22 with SMTP id 22so4823607wyf.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BzbyytJfXytqwJsrx9Dlv7nbwmNyJZc7n/DBfEjuhGw=;
        b=r/hRegw9Ioq5gjDX3YL/+pHyp8ZOzqsmImFTjkdoIzzzp/P2vFZT/vZlXruucQ1KPu
         cAeBjn3LoSaQiwoODF4uSaIDEbqZRM8i7ES5NmZbhnwLlkSC73Y+kJh2+erAQ+2X6V5M
         5BnOX8DXqlEWLSQVBWt9L9GVo4s3OBieSnIJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YgDr6YTmuxJbt6STMvWj2BNmUdTcp2v6VJ9UeTH7Lun2xqRmZPOMva88XG2wfLq7ur
         3XBT4Pb7D/ntDTuZ1TQ6ZK1j81u/qh020wxl4EjkmzKUz0ictencZ0w6JnwJC3fp3RV3
         wYPq6g8p79LYF2K4sjuy/evzTXnBUPiZsckxM=
Received: by 10.216.12.139 with SMTP id 11mr8388094wez.63.1285020920739; Mon,
 20 Sep 2010 15:15:20 -0700 (PDT)
Received: by 10.216.171.134 with HTTP; Mon, 20 Sep 2010 15:15:20 -0700 (PDT)
In-Reply-To: <AANLkTimR=mgjFYwdzqUF7_0j33ha4AJcrJbuL7VJunPK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156672>

2010/9/20 Elijah Newren <newren@gmail.com>:
> 2010/9/19 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>:
>> This is base series for en/object-list-with-pathspec, the upcoming
>> wildcard support in diff family (i.e. tree_entry_interesting()) and
>> negative pathspec farther in future.
>
> I briefly looked over the series. =C2=A0If I understand correctly, it=
's
> pretty much the same as your previous series, except that it uses a
> new data structure instead of exclude_list, and doesn't include my
> two-patch series anymore or negated pathspecs. =C2=A0Is that correct?=
 =C2=A0If
> so, it looks good to me.

Correct. The globbing series is in place of negated pathspecs now.
Your two patch series are also resent elsewhere.
--=20
Duy
