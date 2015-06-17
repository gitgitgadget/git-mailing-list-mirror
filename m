From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] rebase -i: Fix left-behind CHERRY_PICK_HEAD
Date: Wed, 17 Jun 2015 09:43:39 -0700
Message-ID: <xmqqvbem2slg.fsf@gitster.dls.corp.google.com>
References: <20150616140612.Horde.a1irZQmh2o42SqDfxAytHg1@webmail.informatik.kit.edu>
	<cover.1434528725.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:43:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5GRH-0005lW-D5
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 18:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041AbbFQQnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 12:43:43 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35628 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864AbbFQQnm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 12:43:42 -0400
Received: by iesa3 with SMTP id a3so37771410ies.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dHZJxb3xHi6bM2UT7rD4eBKdqI6/EQl/akntLNXLkas=;
        b=BdFMxOrjBOL/DnSKxr+VELohUKPHBE3d77BlD7hHMNz3iA3xWKzlEEepMlUKcTr4Dy
         O8aUSGgwJKpGcdJqzlRpfJzCJ5s/6LYyHieRGEAHqA2fjEx2BJPjelLvm1tK5xBH/t9e
         OiQtFXgjlyNNOcGDGj9QuKZtGEXyU2UEIEOLQNJskywLak8rGM3cqOehpSPbwphnwj4n
         Uko2a4iqqUbIa4gGARKJTARGRqslduxi2/Nm3EKYVNgM38y4/ZONNZmI3mKxPpCtIBF/
         JpscRCv4gGd4xLIR7XI4xztK2tqQe0NQMyBYwSv30kElXQ8BHLdvPBrhtdD9bl42S1I/
         jOFQ==
X-Received: by 10.43.14.65 with SMTP id pp1mr1171768icb.40.1434559421791;
        Wed, 17 Jun 2015 09:43:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id o9sm2911090ioe.35.2015.06.17.09.43.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 09:43:40 -0700 (PDT)
In-Reply-To: <cover.1434528725.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Wed, 17 Jun 2015 10:15:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271869>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The symptom is that .git/CHERRY_PICK_HEAD is left behind after
> skipping an already-merged patch with `git rebase --continue`
> instead of `git rebase --skip`. I always prefer the former
> invocation because the latter would also skip legitimate patches
> if there were merge conflicts, while the former would not allow
> that.

Makes sense; will queue.  Thanks.
