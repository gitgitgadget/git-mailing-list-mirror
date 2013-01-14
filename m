From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH] rebase --preserve-merges keeps empty merge commits
Date: Mon, 14 Jan 2013 12:50:17 -0500
Message-ID: <50F44559.6040102@cisco.com>
References: <1358023561-26773-1-git-send-email-hordp@cisco.com> <vpqpq17zwdl.fsf@grenoble-inp.fr> <7vwqvfele2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	phil.hord@gmail.com, Neil Horman <nhorman@tuxdriver.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 18:50:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuoBF-00077u-Ew
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 18:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540Ab3ANRuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 12:50:20 -0500
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:59003 "EHLO
	rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756297Ab3ANRuT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 12:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=718; q=dns/txt; s=iport;
  t=1358185819; x=1359395419;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=UztU302BWGV5MnR9zGuWEBtrLWy0Bp486f0vZHDXvLA=;
  b=PKPCBKRPQXW0r5vHV6llaZDQ439gQDzFf/83TCZrzOO02+E6dD7pZa2q
   GtBl9WmXVgXI12DFcgwhk98ZU8GBfTQCOpTDJbsdIhQsXKC14Hk7qx8i8
   JN5VfEslAWuNIRt13/rZOKpzlXBlgzHl1kRGhLouCdtbGodZU/0D0mG29
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsgGAEVE9FCtJV2a/2dsb2JhbABEgy6CRbRRgzUWc4IeAQEBBHgBEAsXAQkWDwkDAgECAT0IBg0BBQIBAYgVtHWRLgOIYY0qhWuKXoMT
X-IronPort-AV: E=Sophos;i="4.84,468,1355097600"; 
   d="scan'208";a="162213669"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-2.cisco.com with ESMTP; 14 Jan 2013 17:50:18 +0000
Received: from [10.117.80.101] (rtp-hordp-8914.cisco.com [10.117.80.101])
	by rcdn-core-3.cisco.com (8.14.5/8.14.5) with ESMTP id r0EHoHbV012415;
	Mon, 14 Jan 2013 17:50:17 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <7vwqvfele2.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-TagToolbar-Keys: D20130114125017216
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213507>


Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Phil Hord <hordp@cisco.com> writes:
>>
>>> Subject: [PATCH] rebase --preserve-merges keeps empty merge commits
>> I would rephrase it as
>>
>>   rebase --preserve-merges: keep empty merge commits
>>
>> we usually give orders in commit messages, not state facts (it's not
>> clear from the existing subject line whether keeping merge commit is the
>> new behavior or a bug that the commit tries to fix).
> Thanks for giving a concise rationale on our use of imperative mood.
>
> Phil, I think you meant to and forgot to sign-off; here is what I'll
> queue.
>
> Thanks.
>

Looks good.  Thanks for the help.

Phil
