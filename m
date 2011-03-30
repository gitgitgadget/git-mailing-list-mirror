From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL svn-fe] Re: Portability: returning void
Date: Wed, 30 Mar 2011 12:31:30 -0700
Message-ID: <7vwrjgmmlp.fsf@alter.siamese.dyndns.org>
References: <71372d7d-dd08-4945-a8bc-c7b981c09fb2-mfwitten@gmail.com>
 <20110329200230.GA377@elie> <20110329221652.GB23510@sigill.intra.peff.net>
 <20110329234955.GB14578@elie> <20110330001653.GA1161@sigill.intra.peff.net>
 <20110330002921.GC14578@elie> <20110330033017.GA18157@sigill.intra.peff.net>
 <20110330044116.GB2793@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 21:31:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q517N-0005Ra-MF
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 21:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747Ab1C3Tbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 15:31:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080Ab1C3Tbn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 15:31:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 55FBB487C;
	Wed, 30 Mar 2011 15:33:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rnbgd9xwIS4SnIDzLWkyVNS164g=; b=vVyqwz
	XYG+j0mJOyNoVqHdT9HbY4xC9ny9KIi8GQ7oVKpR0aSLgIms2fsFnuwvGIRSCyX/
	uttCvgKm85MUV/bCBuubYBdAtkCf13nWmgLbUE2wFORHQlMga9HoWT9uASiJtd+m
	fb+K6ahnhnNUZ0Uj+b2iJxdVvhu1N9Wv8Ns+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uj1zK+wC4XUR1Nkt4yEnC7riq74ad7Ei
	6qX2B7NJKzHtGjhZC3n/1uwWVLuCeyE85kdywhdf6cy6HU7Ef5Z9WVPn5psYip9q
	Z5cCiFci7X2QTy+zigijMXeROLKSYAIpRkcHoBczg6hoiyWMPAaTr36Db1FDrRLz
	xbkA2NFHKyg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0208B4878;
	Wed, 30 Mar 2011 15:33:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AF1624872; Wed, 30 Mar 2011
 15:33:19 -0400 (EDT)
In-Reply-To: <20110330044116.GB2793@elie> (Jonathan Nieder's message of "Tue,
 29 Mar 2011 23:41:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 946D1DD6-5B04-11E0-9C90-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170412>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I really do want to address your "while at it".  I'm pretty
> uncomfortable with the "sleep 100" --- it might be better to do "exec
> perl -e sleep" so there is no chance that some incredibly slow system
> won't make the race.  Or a failure mode that does not involve a long
> hang would be even better.
>
> Anyway, to make others' life better quickly I've pushed out the easy
> part of your fix.  It sits with the fixes to other embarrasing bugs.
>
>   git://repo.or.cz/git/jrn.git svn-fe

Pulled, thanks.
