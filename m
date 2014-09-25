From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch
 series overview)
Date: Thu, 25 Sep 2014 14:40:49 -0700
Message-ID: <20140925214049.GP1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <xmqqfvff9ydi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 23:41:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXGmZ-0003F5-PV
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 23:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbaIYVkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 17:40:55 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:64570 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbaIYVky (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 17:40:54 -0400
Received: by mail-pd0-f176.google.com with SMTP id z10so10088385pdj.35
        for <git@vger.kernel.org>; Thu, 25 Sep 2014 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=geqhFWiapQG08tYj9+X8efx49zKPYFRE9IPHrk5Q9xk=;
        b=V00pWx3EKpGf5uCX24o7+Si7I+3sKH/Pbk1tJXpIBN7/VNGic9hXkrpu6QY5aA0VKW
         AQJvTTeNNyf16y5YQtvBzdi9qECDtD4hCd5b7CMP1AMH7zeu25xkORwQW18XlZ1VrTsG
         LxKvQCcrRPlUaQi0RGZkWs/JbRtsJZRV0fM9qP0LGoTMqNMwCX4vcv8FaSE/t+K/1de9
         gKI3P572x+Isulp412/kHFpsk2sFD5UwIxwTVP5PWhfoLuKfu4QZ3+nm2/zc7Ej+DynZ
         5qjmVgl3Ol+DMIu4gCm0YGUA8+nsTyJ6rSOUF+UH10codmFgni7zkFELZXx6qlsSCUD+
         uLvg==
X-Received: by 10.68.178.36 with SMTP id cv4mr23496030pbc.136.1411681253654;
        Thu, 25 Sep 2014 14:40:53 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ti8sm3091034pac.20.2014.09.25.14.40.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Sep 2014 14:40:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfvff9ydi.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257498>

Junio C Hamano wrote:

> I know that a review-update cycle is still going in the dark at
>
>   https://code-review.googlesource.com/#/q/topic:ref-transaction
>
> for this series.

Eh, it's at least public and doesn't flood the list with rebased
versions of the series.

Would you prefer if there were some list archived on gmane with the
automated mails from gerrit, to make it easier to look back at later?

>                  Are we almost there for v22 which hopefully be the
> final before we merge it to 'next' and go incremental?

The patch "fix handling of badly named refs"[1] is still undergoing
heavy churn.

I think it's worth getting that one right.

Thanks,
Jonathan

[1] https://code-review.googlesource.com/1070
