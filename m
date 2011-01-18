From: Junio C Hamano <gitster@pobox.com>
Subject: Re: core.whitespace space-in-indent feature request
Date: Tue, 18 Jan 2011 12:31:00 -0800
Message-ID: <7vwrm2j6nv.fsf@alter.siamese.dyndns.org>
References: <AANLkTikiHXofGVg9QECg9a4U4r4VGD1tb6oMV21nzd9W@mail.gmail.com>
 <1295380297.3778.47.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Victor Engmark <victor.engmark@gmail.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Jan 18 21:31:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfID9-0000rg-UN
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 21:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615Ab1ARUbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 15:31:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44152 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab1ARUbL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 15:31:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1650B38E1;
	Tue, 18 Jan 2011 15:31:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E/idS5GSXwVXfgHdA0ghDwXBFcE=; b=lQoqb4
	MoIT/frbkoUEXfe8l9UqmvDJsb5fc4EGXv8abPM7M35p1sdIi9wgMwmaygNJF8Ga
	LBHfAf8m3fJFTHa1qPp2+32slzR5tgwPFqZUTkwdBfUFVeBl8XCGdZjGCqXeHIRt
	WqFU2OBwdlgr0SMqlmXMimj1V+ybMv7qaZmv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VmNBATWqk20q72P4TBF5fa1IyXCOEFXX
	ULA388QEm1LLuQj75CVfWUCJ8AsCXOaTnguvsq6LZavqI9kAZeU5zd7g5eKyTYAs
	VJYKJ28IqM5rqUmF4jWtVf9n8IZxw1KkaAhaUzQS4OejRu6MQjh6ashRr0g4ONt0
	Jv35QwW5B4E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D74F438DD;
	Tue, 18 Jan 2011 15:31:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CB69F38DB; Tue, 18 Jan 2011
 15:31:48 -0500 (EST)
In-Reply-To: <1295380297.3778.47.camel@drew-northup.unet.maine.edu> (Drew
 Northup's message of "Tue\, 18 Jan 2011 14\:51\:37 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FBF9AE24-2341-11E0-B263-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165214>

Drew Northup <drew.northup@maine.edu> writes:

> On Fri, 2011-01-14 at 13:40 +0100, Victor Engmark wrote:
>> Hi all,
>> 
>> I couldn't find this mentioned anywhere, but it would be useful for
>> languages where you typically want only tab characters in indentation,
>> like makefiles. Would be equivalent or similar to indent-with-non-tab
>> and tabwidth=1.
>
> Victor,
> What would the point of this be? Git doesn't change the layout of the
> code when storing it--that's up to the thing between the chair and the
> keyboard.

True, but I think Victor wants to be able to ask "diff --check" to
complain and diff --color to highlight when it sees a line that begins
with a SP (or a HT then SP) by setting:

	* whitespace=space-in-indent

or something in the attributes file.

As "equivalence" exists, not very much interested in coding it myself,
though ;-)
