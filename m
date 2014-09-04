From: =?UTF-8?B?TmlrbGFzIEhhbWLDvGNoZW4=?= <mail@nh2.me>
Subject: Re: git format-patch --in-reply-to allows header injection. Intended?
Date: Thu, 04 Sep 2014 23:42:29 +0200
Message-ID: <5408DCC5.8000607@nh2.me>
References: <5408D7ED.9010203@nh2.me> <xmqqppfbqd9x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, petr.mvd@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 23:42:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPenw-0006oO-I1
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 23:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873AbaIDVmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 17:42:52 -0400
Received: from mail.grenz-bonn.de ([178.33.37.38]:48228 "EHLO
	mail.grenz-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198AbaIDVmv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 17:42:51 -0400
Received: from [192.168.157.39] (unknown [74.125.61.156])
	by ks357529.kimsufi.com (Postfix) with ESMTPSA id 338CF7CAE3;
	Thu,  4 Sep 2014 23:42:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqppfbqd9x.fsf@gitster.dls.corp.google.com>
X-Spam-Status: No, score=1.3 required=8.0 tests=RDNS_NONE autolearn=no
	version=3.3.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on ks357529.kimsufi.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256487>

On 04/09/14 23:36, Junio C Hamano wrote:
> While I do not think of a reason to specify such a string to the
> in-reply-to option (I'd rather edit the output in the editor if I
> wanted to do anything fancy [*1*]), I do not think there is a reason
> why you want to add a code to forbid such use, either.

My question was to find out whether I can pass untrusted user input to
--in-reply-to and expect that no header beyond "In-Reply-To" and
"References" is modified, but your answer makes clear that I cannot.

A possible alternative might have been that git verifies that the input
to --in-reply-to matches the format specified RFC2822 (section 3.6.4.).

Thanks!
