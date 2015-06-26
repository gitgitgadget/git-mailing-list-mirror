From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/5] setup: add gentle version of read_gitfile
Date: Fri, 26 Jun 2015 09:23:20 -0700
Message-ID: <xmqqy4j6v3pj.fsf@gitster.dls.corp.google.com>
References: <1434397195-1823-1-git-send-email-erik.elfstrom@gmail.com>
	<1434397195-1823-2-git-send-email-erik.elfstrom@gmail.com>
	<20150626090331.GA4196@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Erik =?utf-8?Q?Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 18:23:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8WPX-0005kg-St
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 18:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbbFZQXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 12:23:24 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33895 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbbFZQXW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 12:23:22 -0400
Received: by oigx81 with SMTP id x81so78930158oig.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VfGxOOCxOIAHwPlyulgRTf3gAEs8++GSeJnGyTRl5/w=;
        b=lUTzFQzBxByCpFvSXN5gfFo3JMiJGVrdUHqlipmGoGrgWtVnq1FTzI8XQRKrH7QIcf
         i6L1PbApmuCQ5werSrJLripGgQCsuGmzYU1IcV3u1vYwG2PG+DPrau1iV8Njlqg25N4L
         LJ1klZiyTgtMXaWR+irvHRzIqV5HJ79EYCGMhq2PCkJ9nAfyBE3ECM8gjWgIRspvEQEZ
         MfA6ZEbtlvqMjsVogM8I6+NFCGQ6CYHKqA8wZ9XTWofiOE1Xl286tMGlCEx3oKuxM2n5
         Dxrln9LUEspj55VSHHcvdbdNgHgIdOr3ltbpOS0NzHzqj1sGvaQwl2Fjh8taJ4TNC8mW
         UYRA==
X-Received: by 10.202.208.139 with SMTP id h133mr1954585oig.74.1435335802149;
        Fri, 26 Jun 2015 09:23:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id mo9sm9968099obb.22.2015.06.26.09.23.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 09:23:21 -0700 (PDT)
In-Reply-To: <20150626090331.GA4196@peff.net> (Jeff King's message of "Fri, 26
	Jun 2015 05:03:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272786>

Thanks; will queue.
