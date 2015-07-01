From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Wed, 01 Jul 2015 10:32:07 -0700
Message-ID: <xmqqk2ujainc.fsf@gitster.dls.corp.google.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<xmqqr3orakex.fsf@gitster.dls.corp.google.com>
	<CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 19:34:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZALu7-0003zY-Em
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 19:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbbGARe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 13:34:29 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33734 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbbGAReX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 13:34:23 -0400
Received: by igcur8 with SMTP id ur8so97517852igc.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ni3PxTYLVQjIuRiwq1d7YcyGKI0WHMw9wjgKTGwS2+M=;
        b=yRNrr/Skz66B5Pxxdmoppnq+CoLVnAyxBhY53RF3Cup5PXu7aSUzgvh716QJOVYAjj
         GY8lgOzIbUyUn5HVnL0D6pN5LomM8BVlzb/Z+hDY1oeeU3bVD+ZvfWKCdkpEsJ4fNiHS
         UDsfMixEt5+271VejDRJy78MZAoOLWa58DShNCYQ1OXZeuyYE3sby4NmoZMC0ZYoxcFu
         ldAnCNSp/lwayNIjjE+UxRvtgHckQkOY5K74og8O+a5aJlZgcbF3jj2+6VR5zCdaqdfa
         wHcCgcIbk++I9kRy4BoSR3JA6HSQQTX58D7ep+H+OCt0u1AvIVGRBrxfi+pK5BGfZQYh
         fK9Q==
X-Received: by 10.107.138.87 with SMTP id m84mr37305493iod.80.1435772057290;
        Wed, 01 Jul 2015 10:34:17 -0700 (PDT)
Received: from localhost ([172.25.228.236])
        by smtp.gmail.com with ESMTPSA id h2sm2714523igv.2.2015.07.01.10.34.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 10:34:16 -0700 (PDT)
In-Reply-To: <CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 1 Jul 2015 13:13:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273167>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Thanks. I was planning on re-rolling to use the new name ...
> ...
> For the re-roll, I was planning on renaming it to
> GIT_NEW_WORKTREE_MODE or something (or add a private command-line
> option to checkout, but that may be overkill).

OK, thanks, then I'll stop worrying about this and instead will wait
an update from you ;-)
