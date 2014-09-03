From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 00/11] Add interpret-trailers builtin
Date: Wed, 03 Sep 2014 14:30:57 -0700
Message-ID: <xmqqk35kwfvy.fsf@gitster.dls.corp.google.com>
References: <20140816153440.18221.29179.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 23:31:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPI8w-0008Dr-8O
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 23:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbaICVbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 17:31:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56103 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756472AbaICVbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 17:31:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7872F386C9;
	Wed,  3 Sep 2014 17:30:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nCCGbqv1pwKVacqKX0FsKSN5Z6A=; b=OuwfbI
	Z/cTx1vEjhoSBK7FvWywf8jsCeR+Zepyg5No8GAvaOp1BkoxAKdyZCqWYsmuYxAU
	b55K6MVq1tVzolj+35hMtn2oX4dUKqWyI1SY/03dOzs971zqJTLiiVzdlU7kN+TF
	IbP9yUUKx5v25WqqOg5WU3t15qjrUj1aFPo/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TYlLjbDPJLGgmt71TCAUrUpzPjS4a2ju
	ZN8WAjztunqkTZnZOZFK25G6GdcKq4GIkOlr9OLw4WYV2mt3TkZaaNp809N62ond
	rW2nVGMBx912JwdLIPIZqn6CipVr9PfPfVCA8AbOp+1vpVn5nE5uCYEoloc0dHk+
	evIFGbiLy2Y=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E2A7386C8;
	Wed,  3 Sep 2014 17:30:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CC618386C4;
	Wed,  3 Sep 2014 17:30:58 -0400 (EDT)
In-Reply-To: <20140816153440.18221.29179.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 16 Aug 2014 18:06:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9886C26C-33B1-11E4-B405-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256417>

Christian Couder <chriscool@tuxfamily.org> writes:

>   '=' is always accepted as separator when parsing
>   "--trailer '<token><sep><value>'" command line arguments, for
>   compatibility with other git commands

Hmph.  Which of other commands take "--option foo=bar"?

Puzzled...
