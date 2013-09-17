From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] stop storing trailing slash in dir-hash
Date: Tue, 17 Sep 2013 10:11:25 -0700
Message-ID: <xmqqk3ifz83m.fsf@gitster.dls.corp.google.com>
References: <1379401577-36799-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 19:11:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLyoG-0004xv-GG
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 19:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801Ab3IQRL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 13:11:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60292 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539Ab3IQRL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 13:11:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9300441273;
	Tue, 17 Sep 2013 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VCG01+Sv+wy3jC0KxlAyDB359Is=; b=d93gOa
	bToNQ/7CWzxYku5gQ32CE3a206zeu2Z5ji3drEWp6YO98NVUBdVIQsrJYOX2XquI
	bvtP37M1lnBZqvXck+gwTxHggA9ktiawEIZ39XmOi+JaJmshV+TaE814ZigegUYb
	Sp1cEAcbwnpfPIYSewWwG0ACOI/tqS3eU022k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AvRl8eHA1fxVk0NiHYCg0LTEiBMizu9W
	yYw9ol71GVfbGvz33gBFyKh9PZzCMoioeDYx3Rw38bKUMiNUNVDa9KCHETBWbbP5
	MD2Mgq5qqKZP2NLiMriVrzDE182k9pMbqamAQwhNN5Z4jZ3PeVnNsFVEli6C8Yh6
	k5XhL21JaoY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88F9C41272;
	Tue, 17 Sep 2013 17:11:27 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A59141270;
	Tue, 17 Sep 2013 17:11:26 +0000 (UTC)
In-Reply-To: <1379401577-36799-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Tue, 17 Sep 2013 03:06:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2FFA92B4-1FBC-11E3-9E6C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234891>

Eric Sunshine <sunshine@sunshineco.com> writes:

> * Split v1 patch 1 into v2 patches 1 & 2 to ease review. (This is
>   possible now that index_name_exists() retains its original behavior.)

It really shows in [PATCH 2/4] that illustrates which callers were
depending on the old calling convention; I like it.

Thanks.
