From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH svn-fe] fast-import: make code "-Wpointer-arith" clean
Date: Mon, 28 Feb 2011 14:05:17 -0800
Message-ID: <7voc5vhl2a.fsf@alter.siamese.dyndns.org>
References: <20101224080505.GA29681@burratino> <20110226114435.GB12231@elie>
 <7vhbbolm5q.fsf@alter.siamese.dyndns.org> <20110228213210.GD1942@elie>
 <AANLkTikD8qQKdhXN9dx+hk8r=eGRBtc3eRSFU2vDxmsP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 23:05:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuBDo-00088V-Oq
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 23:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab1B1WFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 17:05:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58768 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab1B1WFf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 17:05:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 702624CD4;
	Mon, 28 Feb 2011 17:06:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OiT36VvVsbpbcsaK2qO9bUc2HaE=; b=qNGf7a
	Ft9YLhljufA89D5RhP/Ksh6+dPHFA7Ec+gxczLk2l4KogUpOG6eUfbTQADD6U/7T
	qeoptLPL8shrGPSXlCHeE9tOiQQ8xBxVsW7FRPINfjM7orexw47TEGQw3lLgo5u6
	Q2R29uv5kyROTwn572x3sLp+jZs48r154UmZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q3pI4cl+A/d2OiEWa/JkbyXGliNTh3Ho
	LEgQSVSg92OxJi+ZxFSjDrkzlvQEgopzu6tHv9eyFTMcW51yFrbSy8G+wsWcntzt
	RumtUKV1CWDSTrisUUo5THF8wcEh9SXzTVgZUaJoA4vtaxEJVfuRmyEcdL35lTCR
	cXSDuNK94Uk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B8914CCF;
	Mon, 28 Feb 2011 17:06:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 95EA94CCA; Mon, 28 Feb 2011
 17:06:38 -0500 (EST)
In-Reply-To: <AANLkTikD8qQKdhXN9dx+hk8r=eGRBtc3eRSFU2vDxmsP@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 28 Feb 2011 22\:36\:33 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 07BF4614-4387-11E0-9597-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168154>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> How come this slipped by unnoticed (except by Junio)? Is the default
> Makefile not strict enough?

No, it's just me being a tad overly paranoid.
