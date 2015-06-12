From: Paul Tan <pyokagan@gmail.com>
Subject: Re: Bug when doing make test using root user
Date: Fri, 12 Jun 2015 21:17:13 +0800
Message-ID: <CACRoPnSeVWpj0-=Ei39UsKfe7m7UwkRFChkb7KAGoZRoZs23rw@mail.gmail.com>
References: <28c940a4a806c8da130403068cf4c0ef@lenhof.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jean-Yves LENHOF <jean-yves@lenhof.eu.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 15:17:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3Opn-00065b-Rt
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 15:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbbFLNRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 09:17:19 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34494 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250AbbFLNRO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 09:17:14 -0400
Received: by lbcmx3 with SMTP id mx3so19907461lbc.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HLPKrdzzEb6O2jGkWlT00eDo7zVaN+RFZdTNkzCCA3o=;
        b=h1prEHHmuBiYf166ZmfONvwlSh1Xs2lg7i6muNQk7Adjei8BAUz+Jml4mj8KMeH1lg
         azPXdSXxb7j3ovmz0YPEvCvnq4QwWbwv/jI2OmPz3+1ZKqXyJb51bgQfSzSteQSdl5kI
         a41VSXkyNrNsLRQESH2EQdQji/U9HzMSjLqiAw/wVn/zIOGkW8bQv4PzMEONrpLpvom1
         K8P6TbFXOZ4sotHLnBZvLhFYYbSJn8TIpRSjywqaG067K6SHl5rlHknY4Zh/2ywaZNpc
         kWqx5uLstOLFEX18Q/N8uGSchNp8HC4rq1bZ8KREEFzovc0tsBVg1/wmXPoIk1jsUqrF
         OClQ==
X-Received: by 10.112.142.232 with SMTP id rz8mr14633621lbb.74.1434115033312;
 Fri, 12 Jun 2015 06:17:13 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 12 Jun 2015 06:17:13 -0700 (PDT)
In-Reply-To: <28c940a4a806c8da130403068cf4c0ef@lenhof.eu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271485>

On Fri, Jun 12, 2015 at 5:43 PM, Jean-Yves LENHOF
<jean-yves@lenhof.eu.org> wrote:
> Hi,
>
> I tried to compile git 2.4.3 using root on a server. It failed on test 41 of
> t0302-credential-store.sh
> In fact even if we remove read access on a directory, root still can acces
> this directory.
> Using a not privilegied user make the test work.
> Perhaps the test should be adapted to this corner case.
> Trace below.

Right, the test should have the SANITY prereq.

Thanks for reporting.

Regards,
Paul
