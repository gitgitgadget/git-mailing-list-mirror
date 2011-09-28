From: Junio C Hamano <gitster@pobox.com>
Subject: Re: error: addinfo_cache failed during merge
Date: Wed, 28 Sep 2011 08:24:10 -0700
Message-ID: <7vehz01yhx.fsf@alter.siamese.dyndns.org>
References: <26411548.33530.1317221043429.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 17:24:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8w0A-0004Cy-Gc
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 17:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab1I1PYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 11:24:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44589 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754827Ab1I1PYO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 11:24:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4204D581C;
	Wed, 28 Sep 2011 11:24:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5ifLUcyO8EQ7NImmbU1PN2HuAUI=; b=hn9VrG
	V7CfwXhnvEIcUj/aCMOz2oZgo5uB3mt/6pv6lfy3Fs0lr7da15D0nmUDITm3LN2D
	1LNHhw/y/tZFcaSNjv4kU8GRf9HuhK7ORy1Rq6shshgl48XoE+U5UUC6njeV663C
	Pkoja4TTKrG6WX8BKqYlCWP3BRdQ/Dc0FLTbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fmR5D4wrhUTk920ITVaK/5QXDUcmQlWa
	tLF0OIq5+3G6W8yJFbyr7ZurhOr3jTOFk+B/GPFuejDbTXReIWOy9tFb1EcNZv9t
	V7EAd4FcwPA1xABQGmNd6C9oXyfQn8TcL7gwrZV1k3x/94apOxyCootD+m569nlj
	PwyJnml9pPo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38B09581B;
	Wed, 28 Sep 2011 11:24:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3710581A; Wed, 28 Sep 2011
 11:24:12 -0400 (EDT)
In-Reply-To: <26411548.33530.1317221043429.JavaMail.root@mail.hq.genarts.com>
 (Stephen Bash's message of "Wed, 28 Sep 2011 10:44:03 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB737CFE-E9E5-11E0-8594-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182333>

Stephen Bash <bash@genarts.com> writes:

> ... I should caveat that my local git/git is a little out of date
> because I haven't repointed it since k.org went down (I use it very
> rarely), so there might be something newer in this area.

Indeed there have been a few fixs in this area and it would be really nice
if you can test this with the latest master branch before 1.7.7 final
ships.
