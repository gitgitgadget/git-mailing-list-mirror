From: David Turner <dturner@twopensource.com>
Subject: Re: Re* [PATCH v2 1/2] refs: refs/worktree/* become per-worktree
Date: Tue, 11 Aug 2015 17:43:55 -0400
Organization: Twitter
Message-ID: <1439329435.5283.35.camel@twopensource.com>
References: <1439268979-10456-1-git-send-email-dturner@twopensource.com>
	 <xmqqvbclpm3h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com, mhagger@alum.mit.edu,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 23:44:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPHL0-0006Ah-45
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 23:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbbHKVn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 17:43:58 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33549 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbbHKVn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 17:43:57 -0400
Received: by qged69 with SMTP id d69so149290331qge.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 14:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=aJUB5zSHma6DHb3W+QzOeFylYuv6krRczmaONalgxoY=;
        b=Ls+S2GIxJxp+gRzX82lXylACdjW6zrkEbg81aL6ePdJSxt5Ubq8q3V0zwfpv+ltcGn
         Z+CKqUKEahycMr6jLsSP15Vl5L8YqSJCNRr7LVYnigWdgz/31QKyLF2k4NlHgEel4krK
         2TYWwJjDl7ULSsOiAI2y3MtpyxgHx3+4kugLbPNCt3ezIzqozBpSsc5nxhDeIc/uvUum
         Ea/CiXwald7Cg8UDTHp4tksAReHTdZ/C9F+MhXwuL2JlCS34HH8g4nzHQp/OQMyFxhhv
         C3qqTztY/K6TxPJbEhc1UkPnUec1PQW+L8VQNaVFj6rLhyWmxx4rnbINNaK+T5JJIl8a
         FD8w==
X-Gm-Message-State: ALoCoQkQsko2/YLJdDPBYjDQnGK40AfpbsOgB7xKhzxlEzzZyJyMsSpNCWh80CKjNNQkIjEFRag9
X-Received: by 10.140.84.163 with SMTP id l32mr53042714qgd.94.1439329436912;
        Tue, 11 Aug 2015 14:43:56 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n94sm1993493qkh.31.2015.08.11.14.43.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 14:43:56 -0700 (PDT)
In-Reply-To: <xmqqvbclpm3h.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275733>

On Tue, 2015-08-11 at 14:10 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:

P.S. I noticed an issue with patch 2/2; I had reverted a now-unnecessary
hack, but accidentally reverted the whole file.  So I'll need to re-roll
anyway.
