From: James Nylen <jnylen@gmail.com>
Subject: Re: [PATCH v2] unblock and unignore SIGPIPE
Date: Thu, 18 Sep 2014 13:39:13 -0500
Message-ID: <CABVa4NieHi8yuqydU10wghgsfig4XG39kS4Hfa+L5-v1gELpEQ@mail.gmail.com>
References: <1411059429-23868-1-git-send-email-patrick.reynolds@github.com>
	<xmqqvbokomqx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Patrick Reynolds <patrick.reynolds@github.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 20:39:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUgbv-0006W6-CG
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 20:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbaIRSjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 14:39:15 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:45831 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932424AbaIRSjO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 14:39:14 -0400
Received: by mail-yk0-f174.google.com with SMTP id q200so254515ykb.33
        for <git@vger.kernel.org>; Thu, 18 Sep 2014 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oWkVRYVV62flus4RjZCrWzu8iXONB7huEOcLDzyw1JU=;
        b=qQn3R8RDxUieVfi8AlWIPyxy6S7VUlAKWMxYVVjKfUgow+f1wyBgg8CtQJo8DHtQT8
         ITYc23QwcjE2FsLJEcOhx2mJeHLANawfSvrMY3a9yJTdSwkWSnK6o5uqx+H3vSkVQy0C
         V07chBVDl3fUWHpKEndTLO96SAbeBCuKGWMlwZaFL9macPLaWjBHUHI0GCpX+xot9JrE
         zFhALYzPGFwqpSNBmBxQ2x+Rc2J7Xkw610MjlCv1iMo/YGynvamtLAWH2nOD7q35kzw8
         2xMZjXMcbfzUZ88KALRD3ycD34SMxCoafufAlee/5fStSDW4Yv8Mf+ztxDg4AhKaE+VF
         N/AA==
X-Received: by 10.236.51.73 with SMTP id a49mr6840489yhc.80.1411065554002;
 Thu, 18 Sep 2014 11:39:14 -0700 (PDT)
Received: by 10.170.65.212 with HTTP; Thu, 18 Sep 2014 11:39:13 -0700 (PDT)
In-Reply-To: <xmqqvbokomqx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257272>

Today I learned that software can be constipated.

On Thu, Sep 18, 2014 at 12:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
