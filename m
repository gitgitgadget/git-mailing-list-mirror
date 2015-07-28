From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: Bug#793884: git: allows nonsensical command 'git checkout -b HEAD'
Date: Tue, 28 Jul 2015 09:32:39 -0700
Message-ID: <xmqqmvygfdjs.fsf@gitster.dls.corp.google.com>
References: <20150728141858.22342.16605.reportbug@zam581.zam.kfa-juelich.de>
	<CACsJy8Atx7h8LHQ26rTx2jPUxL-+MSLva8njdoUs5+Aq-Eoj4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 18:32:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK7o5-0007pn-RL
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 18:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbbG1Qcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 12:32:41 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34080 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbbG1Qcl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 12:32:41 -0400
Received: by pacan13 with SMTP id an13so73753910pac.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1hMp20z00W8GHzI/nZRAZ3nHQ/ieLobkJrjw999F6cU=;
        b=t5rka5Pm/JZ25h3krNUH3zTDjZQBCqILJ3gQDV/7D6ip94dsEiEtxk4Sap235FSSsT
         F0CgdeI4kLRlLs0coDejCsXlFzSzYi6AT87lHRjox4VMZAqGbEVrODBHQnR6eW7Cg4yw
         ot9p4Ama5LFx+YPFnYfRcaSV1Mc/S/eB9HEKESNt7XNdyjerkg86mA/FzQHgGMnE4uQX
         dKxLHAmCcUn4AK1ElpmwXATmIe3ukRWS79bVv3Cob27PphI+qFr+spqO1PkXSx/eAiDW
         fGCwLEQ46NUIINfdCOIUGHxIH3tBYbsmIrf7blM2CrsmtuMaavnFnedX2RQm3ukUQpaJ
         I7LA==
X-Received: by 10.66.120.201 with SMTP id le9mr81729728pab.142.1438101160821;
        Tue, 28 Jul 2015 09:32:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id un2sm24545746pac.28.2015.07.28.09.32.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 09:32:39 -0700 (PDT)
In-Reply-To: <CACsJy8Atx7h8LHQ26rTx2jPUxL-+MSLva8njdoUs5+Aq-Eoj4Q@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 28 Jul 2015 21:33:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274786>

Duy Nguyen <pclouds@gmail.com> writes:

> This seems like a good thing to fix (i.e. make sure XX is not
> ambiguous before creating it with "git checkout -b XX")

Yeah, sounds like an easy lunch-time hack low-hanging fruit :-).
