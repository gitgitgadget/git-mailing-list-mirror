From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/fetch: print hash of deleted tag when updating
Date: Mon, 27 Sep 2010 09:38:55 -0700
Message-ID: <7vfwwv2lb4.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=KVDRzE3-NW+GTO_CL-KtNZ+BjkErgNKMPPtGf@mail.gmail.com>
 <7vsk0wmbcd.fsf@alter.siamese.dyndns.org>
 <A612847CFE53224C91B23E3A5B48BAC749BFD33D90@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Knittl <knittl89@googlemail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 18:39:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0GjU-0005HX-DV
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 18:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933233Ab0I0QjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 12:39:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759803Ab0I0QjH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 12:39:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CF128DA8BC;
	Mon, 27 Sep 2010 12:39:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ph8+6/tM2qnJesQS5pHmvJcGJ4c=; b=HP9nvS
	E7yT1e2Bi6FsEjxJ6y1et8uvDL9uUsWxXeqBjA1Q256mBWh1YTjkYvv1v1qX6+mf
	7M4BHI0L/1W6rP0L4gco+S+KMVvjjtUum/qOaVYtNNkXokrvaJuheOH4foKKNnMo
	ClDalPMQXuk2BXcplvhc36jAu8qco+yOba7oY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DSJk173h0gMR0pXbHrDLAnx2wVv00LE1
	AzE8DTLsKEKhlelB5o/PZlrqriwKF9E8oqujyqn1VZab4q22RWiX3nVAwDsKRRtu
	S69q0Fuj6xJN0nC/k74YTb2S/e3wcgvyILpcWEARPMWksmb4lhz5QrIus4B8Q1TW
	pyp+bFcZEsQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C29BCDA8B7;
	Mon, 27 Sep 2010 12:39:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FAEDDA8B5; Mon, 27 Sep
 2010 12:38:57 -0400 (EDT)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC749BFD33D90@xmail3.se.axis.com>
 (Peter Kjellerstedt's message of "Mon\, 27 Sep 2010 13\:37\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BBDF65B2-CA55-11DF-B56D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157353>

Peter Kjellerstedt <peter.kjellerstedt@axis.com> writes:

> Shouldn't this behavior of --tags require --force to keep in line 
> with what is described in git tag's manual page?

Sounds sensible, if nobody is already relying on this behaviour.
