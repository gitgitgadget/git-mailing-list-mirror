From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] commit: introduce a config key to allow as-is commit
 with i-t-a entries
Date: Tue, 7 Feb 2012 13:26:50 +0700
Message-ID: <CACsJy8CaFhyzgh6N4ov49Tf0mA8qV5uQESFP2u8U7AduOd59PA@mail.gmail.com>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-3-git-send-email-pclouds@gmail.com> <7vwr7z653f.fsf@alter.siamese.dyndns.org>
 <7v1uq741ip.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 07:27:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RueWU-0005WD-6K
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 07:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab2BGG1W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 01:27:22 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55942 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab2BGG1V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 01:27:21 -0500
Received: by wgbdt10 with SMTP id dt10so6982995wgb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 22:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MYNTNdOyjs4+JB8Y7EdZgLq0w1x2B/0RHO2YeEhAA98=;
        b=oO1mDjPxNgYAd0C75lpSCPxwcrogxdUwd1XsapCdy0H5PdGgaPSHxWK8PpbG+YrOOu
         53q3VS4JpFUy578KEcF0L12/sYwHveiHAFRLtXlY4M9EbBL5otDHeDHIVq4DxQiid/h6
         sQeSOW8C0mEJ95xNrUV0CXfA+G9kuIjBJM3cE=
Received: by 10.181.13.113 with SMTP id ex17mr32037825wid.15.1328596040356;
 Mon, 06 Feb 2012 22:27:20 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Mon, 6 Feb 2012 22:26:50 -0800 (PST)
In-Reply-To: <7v1uq741ip.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190145>

2012/2/7 Junio C Hamano <gitster@pobox.com>:
> Unless you are doing "commit -a" or "commit pathspec", you are respon=
sible
> for adding all contents you want to have in the commit before you run=
 the
> "git commit" command (and for the purpose of this statement, "add -N"=
 to
> tell Git to keey an eye on a path does _not_ add contents). A change =
to
> the file in the working tree that is left unadded is what you decided=
 to
> deliberately leave out of the commit, be it a change to a path alread=
y in
> HEAD, or a path marked with "add -N". =C2=A0Forgetting to add modifie=
d file and
> forgetting to add a file you earlier used "add -N" amount to the same=
 kind
> of risk, and "git status" is the way to make sure your partial commit=
 has
> exactly what you want (if you are not worried about partial commit, y=
ou
> would be doing "commit -a", so the "safety" is a moot point).

We need something in the commit message so that 5 years from now, when
someone raises the issue again, (s)he does not have to search the mail
archive. May I steal the above paragraph, maybe rephrase a little bit,
for commit message?
--=20
Duy
