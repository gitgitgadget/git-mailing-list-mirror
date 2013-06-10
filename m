From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 13/45] Guard against new pathspec magic in pathspec
 matching code
Date: Sun, 9 Jun 2013 21:53:32 -0400
Message-ID: <CAPig+cSZDMZju0tHVsajvBFrQY_2UJzUzot_ZkiLd8B5LENeCA@mail.gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
	<1370759178-1709-14-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 03:53:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlrIh-00060n-3E
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 03:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200Ab3FJBxf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 21:53:35 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:40333 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab3FJBxe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 21:53:34 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so4936935lab.24
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 18:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aUlJkR+YFTLbvGVb8dXoNAkLO+aMK2JkSrSwwnoIC7Y=;
        b=DEYAMJ5KxJ9Wv4tFEweQzR77N+OITBbWizTArYhy2Wa68EkfABTY3BilmQmCAfw5Rj
         Eo0vJ6bIQl1ITxyZUhSigVxjv/wFBma8eDSwP0ikXMeffd6hTZxjCD37u27x9Hme+wkA
         xvHX1M1reIu6XykxUFifovQw1mErFQ2zzN4h9WbqTzFQvT3J30seqbItzs7LiQvRSUhs
         SHnx0I8KLiJBnAWz0rQUPMJ6zmmkf+zFKWgtlm4VQniLx48CLS7yiXfaf9MWUTXXrMYq
         /Q8gmycQREG+8ope3Sva1BJE+5l2o2iuo5qZ+q1Y02jgc0gKm5gYQ50+g6kKsuhe3QGm
         rR9w==
X-Received: by 10.152.1.230 with SMTP id 6mr3932415lap.21.1370829212814; Sun,
 09 Jun 2013 18:53:32 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 18:53:32 -0700 (PDT)
In-Reply-To: <1370759178-1709-14-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 0f415EVNcrtXxeYDv84AtUuEqls
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227229>

On Sun, Jun 9, 2013 at 2:25 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> GUARD_PATHSPEC() marks pathspec-sensitive code, basically all those
> that touch anything in 'struct pathspec' except fields "nr" and
> "original". GUARD_PATHSPEC() is not supposed to fail. It's mainly to
> help the designers to catch unsupported codepaths.

Redundant "to": s/to//

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
