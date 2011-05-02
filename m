From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2011, #01; Sun, 1)
Date: Mon, 02 May 2011 08:48:23 -0700
Message-ID: <7vvcxtp0hk.fsf@alter.siamese.dyndns.org>
References: <7vd3k2q8lt.fsf@alter.siamese.dyndns.org>
 <BANLkTimXGChZ+3UAHqqgOGcDt_wGH9XLHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 17:48:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGvMV-0005sR-Ai
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 17:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757Ab1EBPse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 11:48:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab1EBPsd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 11:48:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 495EE46F5;
	Mon,  2 May 2011 11:50:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S9T7Bj9t3ICMoaYvRifRaEl8I5c=; b=BLvdRM
	Qs6/y3eNG3nQZCZPnj94qW67veXLMfNsnIjMc38z0GXv+pktU2Xw7UjdXppv1+pS
	M6/K5mNACkOETTxbXsDpyMXO/U/JqjwLdkQjo7hEGG+0T8zjTFRcs8NI2ZdKbaxN
	OwFoIGelRA6Jez9XC+VrC/qoTl4cYYuVre2BE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SZXIhLagyMwXTUXSQgmkPhsNWyjU3unW
	xbK9MCBN3QkUDOnFeYlpu9XnLHAL8Gf9UEY9GmVc6ZvhNKRXhSKutr8pabZnEGd3
	TD0fq0HEXmoaT2naO29JmuDVfJuZjfNlIXzmPgGtlGXDRsiE6QpMcETSCHza7/Xo
	dcu0m7bjOco=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 244B946F4;
	Mon,  2 May 2011 11:50:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 46BD546F3; Mon,  2 May 2011
 11:50:29 -0400 (EDT)
In-Reply-To: <BANLkTimXGChZ+3UAHqqgOGcDt_wGH9XLHA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 2 May 2011 12:28:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E935EE9A-74D3-11E0-B8DB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172597>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, May 2, 2011 at 6:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * jc/magic-pathspec (2011-04-06) 3 commits
>
> This needs some tests. I'm going to add some unless somebody does it first.

Thanks.
