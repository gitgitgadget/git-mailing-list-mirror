From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Fri, 14 Jun 2013 20:38:10 +0530
Message-ID: <CALkWK0n_Jsb46qPojbGL3S+mPunNQWUOmypQOvdaBjcT5wgJBg@mail.gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
 <1371130349-30651-6-git-send-email-artagnon@gmail.com> <7vvc5hubox.fsf@alter.siamese.dyndns.org>
 <CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
 <7vd2rpu3kf.fsf@alter.siamese.dyndns.org> <CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
 <7vppvosstl.fsf@alter.siamese.dyndns.org> <CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
 <7v38sksq14.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 17:09:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnVcc-0006MV-JL
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 17:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198Ab3FNPIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 11:08:53 -0400
Received: from mail-bk0-f52.google.com ([209.85.214.52]:65504 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab3FNPIx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 11:08:53 -0400
Received: by mail-bk0-f52.google.com with SMTP id d7so319768bkh.39
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 08:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cW/yF3AS1BzB8WT479r5pa3zHbUJybT6KheoGEgT5eE=;
        b=cQkMwd2s6h5Raa4M6nB3mfmHKdKKGqP4N7QNhlgeFs2VunY5rCYLjKLqub1lVJS9pE
         3Mnyk9iXBFOBY5Dt5z6hW5P7vlbyvJbjcRUvdIKOJJxm9hEv4ksbxwxry0rDCeMvA7bk
         0YRz6Vhya+pcq3NIf2sfNSS+7DOFdWOre1Uy9zrdsV1ESozG1rkJfaiVMMWQDodQ5K5Q
         q1JyNZcyzRLOYqZNtcwuJCB1a17xY5Osv/I4w4LpYl/h3I092zZ27OBpgmMEDKb+ozBG
         eh0/QrL2tAAT7DSXNx2Owpevc/ZrFxaPz+GBkt5OZJ3DLX+57mNlQvME9dXxnTmRnkm3
         Xwjg==
X-Received: by 10.204.235.197 with SMTP id kh5mr139434bkb.172.1371222531799;
 Fri, 14 Jun 2013 08:08:51 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Fri, 14 Jun 2013 08:08:10 -0700 (PDT)
In-Reply-To: <7v38sksq14.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227880>

Junio C Hamano wrote:
> As I said (twice), you can argue that that particular piece of
> information is not useful (at least to you), but why it is not
> useful has to be justified, against the justification given by
> b397ea4863a1 (status: show more info than "currently not on any
> branch", 2013-03-13) and people who have been using that information
> in the status output, no?

Yes, Junio.  I cannot justify that "detached HEAD from" is completely
useless, because it is not.  I argued for a practical compromise, and
have tried to show the huge negative impact against the marginal gain.
 If you argue that we absolutely must not cause an
information-regression against all odds and are unwilling to
compromise, I cannot improve the reflog messages written by various
scripts (and fix git checkout -).  I don't know any other way forward.
