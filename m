From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] Gitweb caching v8
Date: Thu, 09 Dec 2010 16:39:39 -0800
Message-ID: <7vsjy6ea0k.fsf@alter.siamese.dyndns.org>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 01:40:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQr1v-00062H-LC
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 01:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757596Ab0LJAjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 19:39:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0LJAjq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 19:39:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4A79325E;
	Thu,  9 Dec 2010 19:40:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8cf4jQOkwJ+TnLUR4+VnkSNy3Oc=; b=C58X1V
	2hthkkiJhS81fNnLc6b3LXwjeo+44eJQdqzHLgfy0Nu6PCIBlWO+F9u5H5IKKKZ+
	2YobJLjiIcrVwOS65fVre41C+I/V7xAlPKGCy21tgvYYw1l7RzNb0LoHNm7lxJ+Y
	hJPBijgQnjB2p446Aq8prkICqOAb1djIdYWsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZyKyryGidKlPXRo8MwFv+Dvl4wagqiMV
	7QulGK3GX+pLG8YIb+jSJCMFm8c15E1I+tg7cmkY5BhhsVXY2UdWA2o1xkixoIoE
	uts6JMM+8Vtezdpj+C2c+2pPeC8Nb/Xl5W6VgAc8MrXsdpqUaeoHA3lyJ7WnxzX3
	mN0I+DRMjp8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1077325D;
	Thu,  9 Dec 2010 19:40:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C9D3A325C; Thu,  9 Dec 2010
 19:40:05 -0500 (EST)
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
 (John Hawley's message of "Thu\,  9 Dec 2010 13\:57\:06 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A114E6A-03F6-11E0-8D26-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163369>

It seems that t950X tests do not like me.  I am getting these in gitweb.body:

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www/w3.porg/TR/html4/strict.dtd">
    <!-- git web w/caching interface version current, (C) 2006-2010, John 'Warthog9' Hawley <warthog9@kernel.org> -->
    <!-- git core binaries version 1.7.3.3.494.gcf92e -->
    <head>
    <meta http-equiv="content-type" content="; charset=utf-8"/>
    <meta name="generator" content="gitweb/current git/1.7.3.3.494.gcf92e"/>
    <meta name="robots" content="index, nofollow"/>
    <meta http-equiv="refresh" content="10"/>
    <title></title>
    </head>
    <body>
    &lt;p&gt;&lt;strong&gt;*** Warning ***:&lt;/strong&gt; Caching enabled but cache directory did not exsist.  (cache)&lt;br/&gt;/<span class="cntrl">\n</span>Cache directory created successfully<span class="cntrl">\n</span>&lt;p&gt;
    </body>
    </html>
