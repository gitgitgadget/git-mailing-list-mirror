From: David Aguilar <davvid@gmail.com>
Subject: Re: git tag's history
Date: Mon, 26 Jul 2010 02:36:13 -0700
Message-ID: <AANLkTikTqJVbohquiNmW0BvP0bXsVFyMw0H4qF2FbhiH@mail.gmail.com>
References: <AANLkTinCTcnr=tyC2+C4u5L0p_mXxTCMfSBm_JzqqMDW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 11:39:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdK9x-0002jQ-PF
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 11:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070Ab0GZJgP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 05:36:15 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48254 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab0GZJgO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 05:36:14 -0400
Received: by qyk8 with SMTP id 8so1782259qyk.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vW85nEwoyVUGYHew67C3zXV4ThZFMwHuahX7CTCBwqQ=;
        b=Rf6pmYYfvhCemVr1mPKOACGvMBjCGl145g1FKr0+wuC9UvOHjgng4bIDX2cx9ScQEX
         jjiT1t8ER0ke5O0mrgdrLJ//HiH0VhREK2VDMvV2QOprqvC43rwpX+Zcnw/3I22UNcT6
         Dgka8w5IQ+VG5J1AH2yXxMFVhYAcNu6nixsAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wi0N4sGBYJLZ9UmMT5xPv171pWSbQZm4Gl8MoZ5Eit36fPMAclOaYIuvBrgrJbbM5V
         f70uo9movv2VLPk1fBshrVBo8I6es/QJL0skFy7vWdAP+782t7SB+CJMq0784ky2rowd
         dm23bcQUygtVGWx4ucDEULlQr12/au66JA2Cc=
Received: by 10.224.3.10 with SMTP id 10mr5804364qal.195.1280136973173; Mon, 
	26 Jul 2010 02:36:13 -0700 (PDT)
Received: by 10.229.51.129 with HTTP; Mon, 26 Jul 2010 02:36:13 -0700 (PDT)
In-Reply-To: <AANLkTinCTcnr=tyC2+C4u5L0p_mXxTCMfSBm_JzqqMDW@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151822>

On Sat, Jul 24, 2010 at 5:12 AM, Mahesh Vaidya <forvaidya@gmail.com> wr=
ote:
> If git tag's history is preserved or I need to implement this in
> pre-receive hook
>
> Scenario
> ^^^^^^^^^^^^
> I create a tag FOO -corresponding to a commit cdf123
>
> FOO->cdf123 and I push this Tag to authoritative repository ; all fin=
e.
>
> Now my buddy creates overwrite my tag (git tag -f) and now this tag
> looks at some other commit
>
> FOO->123aff
>
> He does a push tag FOO; assuming no restriction in pre-receive this
> push will get applied and my earlier cdf123 is lost. Is there any way
> to retrive Tag's history or in need to implement some scheme
>
> Thx/ Mahesh


He won't be able to push the tag unless he forcibly deletes your tag fi=
rst.

Tags do not have history.  This is a non-technical problem.  If s/he's
deleting your tags, it's a social problem.

--=20
=C2=A0 =C2=A0 David
