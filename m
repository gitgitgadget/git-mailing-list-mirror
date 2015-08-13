From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] config: add '--names-only' option to list only variable names
Date: Wed, 12 Aug 2015 18:39:07 -0700
Message-ID: <xmqqa8twj7b8.fsf@gitster.dls.corp.google.com>
References: <1439199967-9655-1-git-send-email-szeder@ira.uka.de>
	<1439199967-9655-2-git-send-email-szeder@ira.uka.de>
	<xmqqvbcnuko6.fsf@gitster.dls.corp.google.com>
	<20150813014736.Horde.GbbN2TpIOFaNM_MPXUzZ4Q2@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Aug 13 03:39:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPhUK-0000Vl-BW
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 03:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbbHMBjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2015 21:39:10 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36575 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbbHMBjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 21:39:09 -0400
Received: by pacrr5 with SMTP id rr5so26089933pac.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 18:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=0dPzjwT+Zw5Evqp7XXM/7ZG/+/kx+JCUgJIL2Yjn0pY=;
        b=yflEuNKufyARJtBE/Yq3Pp8MwvLoAwuWu5NWl7oTYOpfGm5XTDkfQz1tQICYRnKvtm
         D977Q8/CTxcPw/CG8OFPSDwVK1YNFhD+kll9xvrD8tWioXTJCVJtb6wccJO8sN3SJaR+
         9f+rDqN6DjsAaxzqLxxjJxVDHkqsu18nzIi/q36Ql0mMVTjZ1UJTRfScQ3uKBBrrECiD
         QdNNz6m+XidgDWEoi9amw5f3tqQVKbl0KDZ7irEkLlrpSiIjkHtN1V3fV78V6Dk68/HO
         ja04tITX7ddosrBSLmHeW8gfDCkxjZT1eAuIcyI6ub8e37rrCZFSsv8+UUqHMQMF8aGc
         sB/A==
X-Received: by 10.68.134.169 with SMTP id pl9mr73481720pbb.164.1439429948889;
        Wed, 12 Aug 2015 18:39:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id bd5sm441013pdb.41.2015.08.12.18.39.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 18:39:08 -0700 (PDT)
In-Reply-To: <20150813014736.Horde.GbbN2TpIOFaNM_MPXUzZ4Q2@webmail.informatik.kit.edu>
	("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Thu, 13 Aug 2015 01:47:36
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275831>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>>
>> s/becase/because/;
>
> OK.
> ...
>> I agree with Peff that "--names-only" has a subtle difference with
>> an existing and well known subcommand option and it would be a bit
>> irritating to remember which options is for which command.
>
> OK.
> ...

The topic is now in 'next'; I think I've locally fixed it up for
these when I originally queued them a few days ago, so if there are
any remaining issues, please throw incremental polishing patches.

Thanks.
