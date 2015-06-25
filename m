From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 01/11] t6301: for-each-ref tests for ref-filter APIs
Date: Thu, 25 Jun 2015 14:10:06 +0530
Message-ID: <CAOLa=ZQpLJWPVQK3X+UdShf2bVFxQ2riVVqcAHgevp5KqKPPLQ@mail.gmail.com>
References: <CAOLa=ZTbXCRFx6xEv+cB7DQhu92=ePb_MJ5zeEjsr_-=HPAU6g@mail.gmail.com>
 <1435175632-27803-1-git-send-email-karthik.188@gmail.com> <xmqqoak48wwc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 10:40:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z82iD-0003HF-AX
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 10:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbbFYIkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 04:40:40 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35918 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbbFYIki (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 04:40:38 -0400
Received: by obctg8 with SMTP id tg8so42714976obc.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 01:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NWo1VqeGcJWbzs6MlPS+C6JuMRrPqeCuBpXtfoYc7t0=;
        b=gmASKrGRxPGOnXLG9RqXZY+QcCaWRYzVN11PDKvoaxUzoyvA6k6VKebc2bA5gWDHul
         hEzlxvonIqgTsyIuNiX3kN9pF7AOYVZzCucBFDntSuSIbvJzt/osqLJvEIgjpmWLmlH3
         nDp49p4zta6F7tpnK3Yox4zERPmnFuiu4VwJeM2g4+xHNVP3VGjrSUYP9XBPTXoSaftF
         7sMlAphDs9IvtCvrTk3WvAKwxaYn7OekxP4v1HrRsFKJHAW6QMT1uJcoR2/cwaEjWmvZ
         J3tFkBOADaTW60LOAgZwUZpCK4tP8BMjvAhmnMcT+BNWDfFbniYcq4bwN+f2YLPw3u3y
         xtWQ==
X-Received: by 10.182.153.161 with SMTP id vh1mr12357083obb.34.1435221635951;
 Thu, 25 Jun 2015 01:40:35 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Thu, 25 Jun 2015 01:40:06 -0700 (PDT)
In-Reply-To: <xmqqoak48wwc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272639>

On Thu, Jun 25, 2015 at 5:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>  t/t6301-for-each-ref-filter.sh | 19 +++++++++++++++++++
>
> t6301 is already used in mh/reporting-broken-refs-from-for-each-ref
> topic.  Please renumber.
>

Will do :) Thanks

-- 
Regards,
Karthik Nayak
