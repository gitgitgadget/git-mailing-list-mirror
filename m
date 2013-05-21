From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] sha1_name: fix error message for @{u}
Date: Tue, 21 May 2013 23:34:53 +0530
Message-ID: <CALkWK0nEXKXxercc1mNjyK-QX0pOBeKWAxPZtSPvN_h1eniO5g@mail.gmail.com>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
 <1369132915-25657-2-git-send-email-artagnon@gmail.com> <7vtxlwp9mf.fsf@alter.siamese.dyndns.org>
 <CALkWK0mTWtJ_U1O7ZkNU3aNFwGH456xtmDJhhmS3z1tfwFPNgA@mail.gmail.com> <7vfvxgnrdo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 20:05:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeqwM-0006BN-AV
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 20:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab3EUSFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 14:05:34 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:64720 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240Ab3EUSFe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 14:05:34 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so2587442iej.16
        for <git@vger.kernel.org>; Tue, 21 May 2013 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hvN87e8rZm0jg/eX/aklImt8nJiVV4mfZJ6YoowgATw=;
        b=fn2Z5DBpfNnYD4dig6Mqko8Nkmz3xmkz9Gcq3S6WUU1RSy8zuMZC0RALmwJu8mcfnZ
         GvwlMhVVuoncdpW4G9jk+5+dBB58IMRY2YfqvJFzjxWfmGm+oIS14+0b1skzP4veANKU
         GQF8MghdkHDO0vu6Gx36k3pgek0X5xsqrQcTK5ee5JeMRlyC1/Y6sxUkzyxF0PSwKlJE
         j6eLNZPlxi7ocxLKppZv7Qn0RH0iX35/YRn89UFdIJlIjFDVEXmK/a4wrsXP6WE917B3
         jtoKo/FS0sk5xMPLGbbf9Yur0BEyogb/i092UNHQwE+Q4hyelBn5HFOgTUH3YdCSxvw7
         6yEw==
X-Received: by 10.50.3.38 with SMTP id 6mr2143205igz.44.1369159533605; Tue, 21
 May 2013 11:05:33 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 21 May 2013 11:04:53 -0700 (PDT)
In-Reply-To: <7vfvxgnrdo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225056>

Junio C Hamano wrote:
> So did you or did you not audit the codepath?

No; I was explaining why I didn't in the first place.  Going through it now.
