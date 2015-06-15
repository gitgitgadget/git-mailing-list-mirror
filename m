From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "stash: require a clean index to apply"
Date: Mon, 15 Jun 2015 13:11:57 -0700
Message-ID: <xmqqy4jk7muq.fsf@gitster.dls.corp.google.com>
References: <5570F094.10007@quantopian.com> <20150607124001.GA11042@peff.net>
	<CADQvvWWpjZoXt7=8yAEt110pBTNtBfg7XfPOTbJRfPUH=J3OKw@mail.gmail.com>
	<20150610185635.GA22800@peff.net>
	<xmqq616vl6gm.fsf@gitster.dls.corp.google.com>
	<20150610192734.GA23715@peff.net>
	<xmqqsi9samx1.fsf@gitster.dls.corp.google.com>
	<20150615182721.GA4041@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?b=C3=A4r?= <crashcookie@gmail.com>,
	Jonathan Kamens <jkamens@quantopian.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 15 22:12:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4ajl-0002KT-1O
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 22:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbbFOUMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 16:12:01 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:32881 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbbFOUL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 16:11:59 -0400
Received: by igbos3 with SMTP id os3so28045141igb.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 13:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qx9D2mZQmSKJISYlNSUa3LfSs+OfcvdQa1Nean3vU0Q=;
        b=mgTRQvCdu9Ud1yq57g/Gu5SHXVMGAkXqv1EO5TlmPX2aHQrQSIDJidL4p00Pmk1aNT
         8Qwqhm4H0bBOR1pzXc5EmdA9i1O80hPl2AeJ3l2ioQEpIuYMBHZe1bpMT6ImzPriHwmS
         DCYlvF9wCKv8+Mfxdd67wy58sbLo3MOs7Kc7mBUdb6DeU/DaLkyBvdGlq4QfN3fLrfVQ
         H8rCe77kRN3II/IcveFEm84S6cPuzjfRzzZSYbNqqWuS27aUt+SX5snG6rlOn8fb4lSq
         JzSfYLjnwNbSgERI02yLGabwKn2XyMCDKWu/UNyrQphAqhYC9r11V2jiI0YE/rgUb6ow
         WkfQ==
X-Received: by 10.50.61.161 with SMTP id q1mr23161895igr.12.1434399119084;
        Mon, 15 Jun 2015 13:11:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id x4sm9551165iod.26.2015.06.15.13.11.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 13:11:58 -0700 (PDT)
In-Reply-To: <20150615182721.GA4041@peff.net> (Jeff King's message of "Mon, 15
	Jun 2015 14:27:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271721>

Jeff King <peff@peff.net> writes:

> Subject: Revert "stash: require a clean index to apply"
>
> This reverts commit ed178ef13a26136d86ff4e33bb7b1afb5033f908.

Thanks.
