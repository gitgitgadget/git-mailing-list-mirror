From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/4] cat-file: add a '--literally' option
Date: Thu, 02 Apr 2015 13:35:56 -0700
Message-ID: <xmqq384ijmj7.fsf@gitster.dls.corp.google.com>
References: <551D1F99.5040306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:36:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdlqO-0006EJ-2H
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 22:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbbDBUf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 16:35:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750942AbbDBUf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 16:35:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8796D44ADC;
	Thu,  2 Apr 2015 16:35:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HWxvSdjyHq+yWzdkd4SiQhJf+bA=; b=mhRZ5E
	5Fz/WMtskFR/noh/1UC0H69FWptqTO3SnHpfm983Vr9onu1pIxyUwruQEGT/mdWr
	wXh4yOl3F4pZ/bfvVdta8+tMjPQEc+N4lzA+uJBKiPh9mIn6vpJSrQXCBUZh50Iz
	80u3ITTlAMM386iTuywq0/nYAes0AQbYFdeNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rttdzOzVUgurjxfC0FbtrB/Xl4g6ajlZ
	QjPGUHK1IC01d3kO6iHvOQlkcKuhgx0F55DNSq57QdoyLsjkC2wOJhWUJNDBLBkH
	V+Wyvp/+zvF8oa+F6LgVX3V465T9iXpOLv5zP4v8UGclYDypHBLqLidkhOdfpYqh
	oFH5wuebgz8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F54544ADB;
	Thu,  2 Apr 2015 16:35:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3ADF44AD9;
	Thu,  2 Apr 2015 16:35:57 -0400 (EDT)
In-Reply-To: <551D1F99.5040306@gmail.com> (karthik nayak's message of "Thu, 02
	Apr 2015 16:23:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DE326EB2-D977-11E4-803C-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266673>

When merged to 'pu', this seems to break at least 5309 and 5300
tests (there might be others, but I didn't check).
