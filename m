From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] gitweb: introduce localtime feature
Date: Fri, 18 Mar 2011 15:42:04 -0700
Message-ID: <7voc58rqyr.fsf@alter.siamese.dyndns.org>
References: <c8621826e0576e3e31240b0205e7e3d0@localhost>
 <201103181540.03431.jnareb@gmail.com>
 <7vy64cwal7.fsf@alter.siamese.dyndns.org>
 <201103182258.43368.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Kevin Cernekee <cernekee@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 23:42:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0iNC-0005ai-L6
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 23:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483Ab1CRWmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 18:42:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932135Ab1CRWmR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 18:42:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9CCE84E14;
	Fri, 18 Mar 2011 18:43:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BrfGWia7oVAucQo9xCXAQB2Zk6c=; b=S2mXUv
	DGTolrC7PDzSMYgNx2EfB7haF5TOTjHNcFVHH53HbO6n3h6MI57cXPdLpb01UvVH
	THlGXkqxYuCkYbCvynObRBU1WdtTl1eiiCyWI0LiEjHY/fTES0z7YfbyXDhFpkxN
	vshhnMlPAyCcsxyiZ/t2Kovo3p2UlKpofF3T8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EkUFXE7dBrA06zSWYE4qb98atzQJ8V/q
	/6+cmaCV2AfET4LRgZyL72Tnwiat0TZjGe7Y7XhzinMXpSlUbUa5f2J2PTYjfUUU
	qmYVlGoTi750JfYTTUBSxVPiTaOM1U/QfAqnYErjZxsYMORptBLjmQws8AEDD9aD
	einfCEckuZc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6BE064E13;
	Fri, 18 Mar 2011 18:43:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2D30B4E0E; Fri, 18 Mar 2011
 18:43:39 -0400 (EDT)
In-Reply-To: <201103182258.43368.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 18 Mar 2011 22:58:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E929AF6-51B1-11E0-9A6E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169375>

Jakub Narebski <jnareb@gmail.com> writes:

> This would not be needed with proposed by you refactoring that makes
> parse_date do only parsing of timestamp + timezone.

I didn't mean to propose any such thing.  I just pointed out that the
function whose name says "parse" does not just parse but does more useful
things; I meant to hint that it might want to get renamed, not butchered
into smaller pieces
