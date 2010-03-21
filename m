From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v3] git checkout: create unparented branch by --orphan
Date: Sun, 21 Mar 2010 18:15:12 -0300
Message-ID: <55bacdd31003211415k79b7a039n3f19eb95eefcad43@mail.gmail.com>
References: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com> 
	<20100321171431.GE2557@m62s10.vlinux.de> <7vd3yxqxdj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 22:15:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtSUr-0002mW-VD
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 22:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393Ab0CUVPe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 17:15:34 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34335 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab0CUVPd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 17:15:33 -0400
Received: by gwaa18 with SMTP id a18so666164gwa.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=K4RuYX43pUdjNooDcxao1l4my+3xhGE+i0io8cwg6mM=;
        b=qO+24qsM9l85GXtOt0EjEkfuYXfgNP4N8X2dNdaMQ3b9SUB+IkVWdi9vwNr5Q0oKWu
         QcR/WtMzoBz5kn8QiVCo+u1ykZ85mX5xZ8lqWIVX/MI+colXfv48zjuP2T7YTuCxD/+x
         iAGqD6+MbRkAwp583YcbREcRzzzc5F0ZHQ0ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=swXnZfgTixLKyQpGyXJR+ju6/Lo4d1XwGJ42iCU+xQIquprD241J7Ur9Va8iqDKLfW
         bPaa2eiZ8srQ3M4UZHOIxMEpXWcmAGhOzbZIEDfQ8ZoEDQxGD8epq/SExwzsD5VauR5H
         LAFGXW5MEWlynKKrK1DA1g6C57pfRL+5Jhsbg=
Received: by 10.150.250.42 with SMTP id x42mr10590849ybh.193.1269206132081; 
	Sun, 21 Mar 2010 14:15:32 -0700 (PDT)
In-Reply-To: <7vd3yxqxdj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142861>

Hi,

2010/3/21 Junio C Hamano <gitster@pobox.com>:
> I'm not native either, and "orphan" sounded strange in that we've nev=
er
> used that word in any of our use case or workflow description in our
> documents.

I didn't know.  I thought you were American.

> The main point of the feature is not the emptyness of the resulting t=
ree
> (it is merely one possible outcome), but is the lack of parents in th=
e
> resulting commit. =C2=A0So I would recommend against --empty. =C2=A0-=
-root might be
> a good synonym, though, and we _do_ already use that word for that pu=
rpose
> in some commands (e.g. "log --root").

--root could be a synonym but the reason I haven't chosen it was the
fact that it could mislead people to think the functionality will do
something with/based on the first commit of the actual branch,
subjectively thinking "THE ROOT".

IMHO --orphan (no parents) is more obvious.

We should argue one of our native English speaker amidst this
developer community to be sure.

Anyway that is just a word to change or not in the patch... :-)

Regards
