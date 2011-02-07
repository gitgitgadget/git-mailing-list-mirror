From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Mon, 07 Feb 2011 12:48:24 -0800
Message-ID: <7v1v3jvaef.fsf@alter.siamese.dyndns.org>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
 <1296914835-808-1-git-send-email-pclouds@gmail.com>
 <20110207091740.GA5391@elie> <20110207095713.GA19653@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 21:48:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmY0w-0001pL-Ew
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499Ab1BGUsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:48:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab1BGUso (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:48:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E1A6340E1;
	Mon,  7 Feb 2011 15:49:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EoMasV0WP4yHKEOawSoN9GAW+jQ=; b=xZgcXD
	BUZpkn290y3j3779EwXJU5hI6hcGQc+YXdZFjiDIcoVax3GyVQ9BBdZuWiGcihYk
	yHq7gwFPfNuU6y2pioePt9r/0t6vg3usmH/zA4e3ZJ8HqVVBu/aXSQ4ydyu9afkG
	mkBoxOQ21S3iI96jnwvNGw6UIW3W3W7brMmqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lxhfOv4cFRIxH3/RMW1xRAqG8ciiWsBe
	K0a8xwPNGs5ocKCUrTpl7c73kQ7zonqwEzAreeI1MKgYgYGU/ynU9oimp57S1Y3h
	EMW5bx/QEg6gV8a+ocU13vFzvi56nHeIn4boZUvabPcp+OEmPkORyATBhMfJOw0h
	BfwZ8FAApFQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 576CA40D3;
	Mon,  7 Feb 2011 15:49:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D810B40CF; Mon,  7 Feb 2011
 15:49:23 -0500 (EST)
In-Reply-To: <20110207095713.GA19653@do> (Nguyen Thai Ngoc Duy's message of
 "Mon\, 7 Feb 2011 16\:57\:13 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C4536C20-32FB-11E0-936B-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166282>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Perhaps it's not a good approach after all. What I wanted was to make
> pre-1.8.0 tolerate empty trees created by 1.8.0. Perhaps it's better
> to just let pre-1.8.0 refuse to work with empty trees, forcing users
> to upgrade to 1.8.0?

I don't think we saw even something remotely resembles an agreement that
empty tree is a good thing to have yet.  Why are you rushing things?
