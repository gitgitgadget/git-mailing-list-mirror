From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 4/4] notes: teach git-notes about notes.<ref>.mergestrategy option
Date: Mon, 17 Aug 2015 10:22:47 -0700
Message-ID: <xmqqpp2lesns.fsf@gitster.dls.corp.google.com>
References: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
	<1439586835-15712-5-git-send-email-jacob.e.keller@intel.com>
	<xmqq8u9dh6lq.fsf@gitster.dls.corp.google.com>
	<CA+P7+xqHzE5b7_yEqnCDq_vVJGSnsHPV8qJrXqUAGW=h_5C0mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:22:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRO7a-00048L-5e
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 19:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbbHQRWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 13:22:50 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35305 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbbHQRWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 13:22:49 -0400
Received: by pacgr6 with SMTP id gr6so112628540pac.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 10:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Z6UzI6wPChwO4EF3FwFcB2riN+P95ADyXu6TsgRrk3s=;
        b=OTt2HZAXnpyScReT13IgvL2EuSxtiElYn5vOllc/kRXBwAhalehRSlrgU5nrmI9IPn
         RyXyEWpC3DOzfyDbgfItc6Po9GS+xzcCxsk8OgPq42MmJJ5RMuak/Z0E9Z/B5Jz/tXu5
         /2iY3dgvUHSZe2hcRYefz5/PkNnnWoCJf2P2FjDsUABW256QDis+yzjGkpKf5BIrzGAc
         M+aNveRDEXwAu92ww/VuVDKl+mbAPsX+QuPpTm5q7M/17dswRUPtsf1BfLsSrZhaasDi
         oitgvNuoubwOItLJ/7s6CuPS5cSsYPg9HM9OrCpdv/HQ5X24ETW/mJdXQrBWMmSy+wYC
         /F6A==
X-Received: by 10.68.87.130 with SMTP id ay2mr4572288pbb.73.1439832168747;
        Mon, 17 Aug 2015 10:22:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id pt3sm15270061pbb.38.2015.08.17.10.22.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 10:22:47 -0700 (PDT)
In-Reply-To: <CA+P7+xqHzE5b7_yEqnCDq_vVJGSnsHPV8qJrXqUAGW=h_5C0mQ@mail.gmail.com>
	(Jacob Keller's message of "Fri, 14 Aug 2015 15:48:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276061>

Jacob Keller <jacob.keller@gmail.com> writes:

>> Sorry, but I lost track.
>>
>> Do I understand correctly the consensus on the previous discussion?
>> My understanding is:
>>
>>  (1) We do not currently refuse to merge notes into anywhere outside
>>      of refs/notes/;
>
> We do. I mis understood the original code. We check inside
> "init_notes_check()", which will check if the ref is under refs/notes/

OK, then we are in a much better shape than I thought ;-).  Thanks.
