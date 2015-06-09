From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-rebase--interactive.sh: add config option for custom instruction format
Date: Tue, 09 Jun 2015 12:23:27 -0700
Message-ID: <xmqqmw0865zk.fsf@gitster.dls.corp.google.com>
References: <1433797202-97425-1-git-send-email-rappazzo@gmail.com>
	<1433797202-97425-2-git-send-email-rappazzo@gmail.com>
	<9a61f06b14f58a0bd2b687e2aef2b805@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Rappazzo <rappazzo@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 09 21:23:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2P7W-0004fL-KD
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 21:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbbFITXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 15:23:31 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:34984 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbbFITX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 15:23:29 -0400
Received: by igdj8 with SMTP id j8so3186733igd.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yL45BxXAlACviqBwH6ghZOLgkGPhfm5GnmYscicn4+s=;
        b=Ks1E9S1Sqm4b0U+3c7j0OAMImXBfJpvUw8Lx5Mc17Lh0RSYINnrZiS1nU/oVDyF1OC
         ELdxBENoFWY/in+dFqj7xedRVqORf7o64cMKPwoLtJ3otyXmnV83dRWfxiKe/hN9ZJte
         pEFhMWVhhIUc1G0H9g0NLYr3TwYdb1nJo/ip8SuQLQk+7xv4czXQobXq4hldrvR+0iJJ
         D3MizNvBT8U5mDGsj3/Iw22dagVXyN8mVRD42RomC5NpEPc5sWGrSkiVARfKt2oznVHv
         YUy71jop74E6VuIrs3ON0D+xAXT0c0Bkemtkxuy2ODkucjzJCjgtXGruIy2IyqJGpPpG
         ghtg==
X-Received: by 10.42.30.208 with SMTP id w16mr446217icc.88.1433877809050;
        Tue, 09 Jun 2015 12:23:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id s5sm1742823igh.6.2015.06.09.12.23.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 12:23:28 -0700 (PDT)
In-Reply-To: <9a61f06b14f58a0bd2b687e2aef2b805@www.dscho.org> (Johannes
	Schindelin's message of "Tue, 09 Jun 2015 11:36:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271235>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Besides, are you sure you don't want to substitute an empty
> rebase.instructionFormat' by '%s'? I would have expected to read
> ${format:-%s}` (note the colon), but then, this was Junio's
> suggestion...

That was me simply being sloppy myself, expecting people not to copy
and paste literally without thinking.  Thanks for noticing.
