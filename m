From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v17 05/14] ref-filter: introduce match_atom_name()
Date: Thu, 10 Sep 2015 23:19:49 +0530
Message-ID: <CAOLa=ZS1iVW+=8=TMnOw9Ao_bg0nnhx-4tpyesHjOiYAsTCD4Q@mail.gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
 <1441900110-4015-6-git-send-email-Karthik.188@gmail.com> <xmqq37ym5i2u.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQM77+EzbHbY24nvu=hgNCa9MJ3wyz1XhFjk+3HdDd_Hg@mail.gmail.com>
 <xmqqlhce420b.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQXP-U+dGYYFcvxVmuG2NOSiHYLHEwm2OtvhGQrBW9hdQ@mail.gmail.com>
 <xmqqd1xq419b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 19:50:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za5zM-0006JC-LE
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 19:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbbIJRuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 13:50:21 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34728 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbbIJRuT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 13:50:19 -0400
Received: by obbda8 with SMTP id da8so40964225obb.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8+fSyIMb4daVrZE3EkSM3w4RrYdDrYmgqZllFCmFit8=;
        b=oGh1TpohD1zfoSMRosAkXS2Ph8nCPjFEFy6r0UnSmqt6wrmci+qpRkMsgyQ5n5/mVE
         6nzOUT72O+2wTD+xR0Zba9vfDe9Dqg0k9Qm7Ep3W8Au5sEoRh+uwKr/qjmzE7E/7VHTx
         PGn6/7ygNGSKC1/y5rGwKaoPv58fd8kdBJl19IIOGgypnSj6ppqaofZ1Gw3N/Ik4l6b7
         BDRibanR3df7APFKNmj12Kj6Q9peBpf+/X0Wcn7l53kkFAqjXL/muUubWrMB7a1VMwsJ
         C8ncdOlp/uJIevcgV6BnpGMMTui0cuI78tqSqVz/FbuwYiCtP2qVIZcd0XWren87cwZ+
         2etQ==
X-Received: by 10.60.159.166 with SMTP id xd6mr17079772oeb.1.1441907418833;
 Thu, 10 Sep 2015 10:50:18 -0700 (PDT)
Received: by 10.182.59.15 with HTTP; Thu, 10 Sep 2015 10:49:49 -0700 (PDT)
In-Reply-To: <xmqqd1xq419b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277616>

On Thu, Sep 10, 2015 at 11:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> It is one thing that the user can actually do the check themselves,
>> but doesn't it make more sense that when we're using colon we expect a
>> value after it, and something like %(color:) makes no sense when color
>> specifically needs a value after the colon.
>
> If you imagine the format being built by scripts (we are talking
> about plumbing feature --format here), I think you will realize that
> it perfectly makes sense to allow them to say "%(atom:$modifiation)"
> without having to worry about a special case where $modification
> happened to end up being empty.  So no, I do not agree with your
> statement at all.

Ah! that makes sense, thanks :)

-- 
Regards,
Karthik Nayak
