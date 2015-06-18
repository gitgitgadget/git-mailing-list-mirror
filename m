From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Visualizing merge conflicts after the fact (using kdiff3)
Date: Thu, 18 Jun 2015 08:57:57 -0700
Message-ID: <xmqqsi9pf1q2.fsf@gitster.dls.corp.google.com>
References: <557F791D.3080003@nextest.com>
	<87b840d8c73fd7e4e7597e2fd835c703@www.dscho.org>
	<5582B8EC.1060205@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Eric Raible <raible@nextest.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Jun 18 17:58:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5cCb-0006ln-9E
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 17:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbbFRP6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 11:58:01 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36041 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932277AbbFRP57 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 11:57:59 -0400
Received: by iecrd14 with SMTP id rd14so57709326iec.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xSdmHhobf2CrD5KpbAQUdKc9SypHrGw86rHpQNWm0L0=;
        b=C99lZbHhMxR0gW9M6U98LAJWsM8ZZK7x8BpbwaPldyMjHYZO2TfN/diTs2Gd9mzho6
         6uwItLSuRlygn0gXeVkyJj7MhA3RNJNNThZGnzIp0x6E5t4VghmefFrwq27eBcLUYOjg
         kiVFa07FhOaB0WUGQv5pr3lDAVlqnC46lEsFdKg5+gSH92zg6zpy/lUwI7azCnr6zCEq
         VkeS3mOY1ibglEylRl+U/hlvmdl8TlWwhTIqW0xdLWq+0h91o1oegPP4+8swY7Khsx10
         vuvBUsyydkxaNKlesiKNt7CKAZXe839GfKvZl3kGJkZjgeqWhtqr40zbtT/12kTUMnve
         XEJA==
X-Received: by 10.50.64.244 with SMTP id r20mr42502364igs.33.1434643078911;
        Thu, 18 Jun 2015 08:57:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id c12sm3421741ioj.39.2015.06.18.08.57.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 08:57:58 -0700 (PDT)
In-Reply-To: <5582B8EC.1060205@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 18 Jun 2015 14:26:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272019>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This type of request comes up often (for a reason). I'm wondering
> whether we could support it more systematically, either by exposing the
> steps above as a command, or by storing the unresolved merge somewhere
> (leveraging stash or rerere).

Perhaps 'tr/remerge-diff' (on 'pu') is of interest?
