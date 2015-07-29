From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug? git config and --unset are not inverses
Date: Wed, 29 Jul 2015 12:02:29 -0700
Message-ID: <xmqqpp3a948q.fsf@gitster.dls.corp.google.com>
References: <CAD0k6qR0J0ks2mL9TTd4wD7qrzKwadFGC=ecJRCsTcSS0ioo_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 21:02:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKWcj-0002kn-Ml
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 21:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbbG2TCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 15:02:32 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34131 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbbG2TCc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 15:02:32 -0400
Received: by pacan13 with SMTP id an13so10186941pac.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YmdRgFxGhneo+Gbq1KsASJLH6G5WIrtf/5o8NfKcm/U=;
        b=PDLHY6rwA9S3j8XCXBNTNg5BAbOlbq3gDhSzkBUoRXADGUOkcAqQ9hJEnBYgXr3KlK
         xvZalACfhX20SySfOOUKbBCNuwg6za7qWML+YGgXdXDidE26lF2Wp/0pi/EVHRoIIiZS
         RoR2TX8zIxwlhaT4GpA80+yuXUmDen6SmW/WA+B5qPH2Dk6/PHV8ARSQlA4+hEDH7iTJ
         zOXospao+IYLU1A/vj4w8K4acLBfUVXckJqBDlJUy3bzSO+smkF2HT8C0WCFNMvYD/En
         INZxaoAmd7MfV1Gib7Xv/72g2QxLLVRpuEPVWLiCdRF3UzRy+YnK+BK6GVpsfZJPZxyZ
         nLnw==
X-Received: by 10.66.161.232 with SMTP id xv8mr96781659pab.137.1438196551383;
        Wed, 29 Jul 2015 12:02:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id k5sm42115206pdb.53.2015.07.29.12.02.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 12:02:30 -0700 (PDT)
In-Reply-To: <CAD0k6qR0J0ks2mL9TTd4wD7qrzKwadFGC=ecJRCsTcSS0ioo_A@mail.gmail.com>
	(Dave Borowitz's message of "Wed, 29 Jul 2015 11:59:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274938>

Dave Borowitz <dborowitz@google.com> writes:

> It looks like git config --unset may leave an orphaned section, but a
> subsequent set adds a new section:

Old news known for at least several years.  Patches welcome ;-)
