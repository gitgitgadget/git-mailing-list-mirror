From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: add blame.showemail config option
Date: Fri, 29 May 2015 12:40:09 -0700
Message-ID: <xmqq617bcgva.fsf@gitster.dls.corp.google.com>
References: <1429841612-5131-1-git-send-email-qneill@quicinc.com>
	<CAPig+cQrUPHOaKjNhsmLho+bFdAOQxb0NK2YK2QsFmdDBF6h4g@mail.gmail.com>
	<CACfD1vvaAGkx2P3yMfZPOZrRvG3-H96zQVOCevnd-O0rBJ7wjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Quentin Neill <quentin.neill@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 21:40:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyQ8g-0005CF-KH
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 21:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888AbbE2TkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 15:40:14 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38404 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756654AbbE2TkM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 15:40:12 -0400
Received: by igbjd9 with SMTP id jd9so22419380igb.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=g0OPhxRNap0Lb+jaJwBMwDq588hY38+TG5B/B73Q1qc=;
        b=xtKB8bhEmWScWq1BEO5QJKQiim9sAx3bUmRbt2spbae0sD1kZn5EhnKPtNcQJoVCXb
         B2MyFA5F20k40JPjBZARHkTqg8jiSiYuVPaeXNTDm0WQVIz4a902tX7dIuxPGZOYxpb2
         W2Ajnles53kdtKP6sJ68/CGCB0k3WYJorT6NLPquspguuEQ1SiNmrdE8mZqJT92Le15y
         DMYuCjBd/3rsUOo5uez8inQF/wD2q0iDskJcIKWMToHDfxcoFS+TJaDEJDBcTKxbfCTj
         GX5Vqx2Mt+UDZ0b01rHqX9pmHwq7TcKfOe5qisO6b5r81/6m8apTe/nqlAab1+I3ZH0i
         uAtA==
X-Received: by 10.50.64.147 with SMTP id o19mr5982684igs.33.1432928411765;
        Fri, 29 May 2015 12:40:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d9c8:419b:acd5:cf1d])
        by mx.google.com with ESMTPSA id j3sm2179040igx.21.2015.05.29.12.40.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 12:40:10 -0700 (PDT)
In-Reply-To: <CACfD1vvaAGkx2P3yMfZPOZrRvG3-H96zQVOCevnd-O0rBJ7wjw@mail.gmail.com>
	(Quentin Neill's message of "Mon, 27 Apr 2015 08:46:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270268>

Quentin Neill <quentin.neill@gmail.com> writes:

> Thanks for the thorough review!
> I have adjusted the commit messages and updated the documentation changes.
> I'm in trying to add tests, I'll probably have some issues but will
> post something that works soon.

Hi, I was sweeping my old mailbox for leftover bits, and noticed
that this thread ended without seeing the final step.

Has anything further happened to this topic, did you got too busy,
or you lost interest?
