From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 04/19] for-each-ref: add '--points-at' option
Date: Tue, 23 Jun 2015 00:33:40 +0530
Message-ID: <CAOLa=ZSd8KftLrRHBXY7Ch2KpVuFSb2DzCq0eLibAx1+bR9M1Q@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com> <1434919705-4884-4-git-send-email-karthik.188@gmail.com>
 <CAPc5daVNapbjAHwiUq5PXfCnWii4Cs1v6dvDAGFfnVkAJhFZnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 21:04:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z771H-0006qc-4Y
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 21:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbbFVTES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 15:04:18 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:32975 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbFVTEK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 15:04:10 -0400
Received: by obpn3 with SMTP id n3so36534405obp.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 12:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mdSY9GfjuY4uIwi+f8lAn/NrX/KQd6m8bSC39cGpRkE=;
        b=zV2QjQHpE2bU39VEI5443HzSnSZpYg5F19VldTgV6d+c5j2h9Q5CmcQtiljWOpu0w3
         n+WO03qs+C5HTrXykio9SxjoDAo6U+aVKvwe7DrpiUH11A71+CZDRkvw0f7YfoAI104v
         MHBKBKskkGYw9cE5NQVhMctql5CgoE0Q2QizFoKJoyG2VBkRsiGfq9UNsmY8KnRuKJml
         fz8w1QpjtV2LcYoOwbqOULawqICOmz4jBYgVr7T6p+/WEPsKixAcNx4bjKXEALfd+R4W
         x0ZSy10RblbriXyAEB7ZUYT9ergPaOW1LPfgRvQLuMCMi+PXGoSitPnn/ytru8FLsf4N
         94Fw==
X-Received: by 10.202.190.134 with SMTP id o128mr24916203oif.111.1434999849510;
 Mon, 22 Jun 2015 12:04:09 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Mon, 22 Jun 2015 12:03:40 -0700 (PDT)
In-Reply-To: <CAPc5daVNapbjAHwiUq5PXfCnWii4Cs1v6dvDAGFfnVkAJhFZnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272403>

On Mon, Jun 22, 2015 at 6:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  3 & 4 as a single patch may make more sense, if we were to tolerate the
> "let's copy & paste first and then later remove the duplicate" as a way to
> postpone touching "tag.c" side in order to first concentrate on for-each-ref.
>
> I have not formed a firm opinion on what the right split of the series is, but
> so far (assuming that the temporary duplication is the best we can do) what
> I am seeing in this series makes sense to me.
>
> Thanks.

That would mean squashing 3&4, 6&7 and 10&11 also on similar lines.

-- 
Regards,
Karthik Nayak
