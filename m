From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] standardize brace placement in struct definitions
Date: Fri, 18 Mar 2011 00:25:20 -0700
Message-ID: <7vwrjwyjof.fsf@alter.siamese.dyndns.org>
References: <20110316024959.GA24932@elie> <20110316065256.GA5988@elie>
 <20110316070834.GF5988@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 08:25:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0U46-0007Zb-UK
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 08:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366Ab1CRHZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 03:25:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab1CRHZb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 03:25:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D47A32480;
	Fri, 18 Mar 2011 03:27:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=eAUq/lsurObcq71BHSaFqkkXP9U=; b=mHp0zOQjAYDNaQDMCWPf
	QLmoA9pgoon+MY3+BQ/mmFoLK8BRT8m70Uz/oxFcK18kaPLHKazzY/vDAFIg08N5
	tS+O7YiAhj/9Z05Ctrr6Olc3MxTj/ZA/RMvZ8TbkAFelEr3BLWrUMarLKmYk8T9n
	kkGe/0UGKdwSQEXKAtfpm8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=LCdXBfjNfrFBIvVcqeUgfK11wf0hznTvkb2a+yNw10p//7
	U/xFJxMg2VLXO42Pxbsu/Z+3mobQLiyPiKlYz0zEJ/tMhdCdcF9jrysv/Qw5Y5iZ
	RjNBSojH8pRc2RZ4SEy7m0zH6KNSNdfwHoZb28fdiz71fIEqtPCnMrCLsaeoE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9FC39247F;
	Fri, 18 Mar 2011 03:27:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 90E90247E; Fri, 18 Mar 2011
 03:26:56 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D2A4B54-5131-11E0-A8FF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169296>

Jonathan Nieder <jrnieder@gmail.com> writes:

> In a struct definitions, unlike functions, the prevailing style is for
> the opening brace to go on the same line as the struct name, like so:
>
>  struct foo {
> 	int bar;
> 	char *baz;
>  };

Thanks for killing these eyesores.
