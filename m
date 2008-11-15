From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Documentation/user-manual.txt, asciidoc and "--" escapes
Date: Sat, 15 Nov 2008 04:07:53 -0800
Message-ID: <7vzlk15h0m.fsf@gitster.siamese.dyndns.org>
References: <ddb82bf60811061904t5defc492m80cd1b759674eb6@mail.gmail.com>
 <ddb82bf60811061909m6f8a7b72o4b03ebcde8b9d188@mail.gmail.com>
 <ddb82bf60811090044l43eb4bb1ga5a16718a4176c29@mail.gmail.com>
 <2c6b72b30811091052k77200785j722c8aed2beb7684@mail.gmail.com>
 <ddb82bf60811092338m3aad8041w20de23f18aa7d56e@mail.gmail.com>
 <20081110100757.GA12868@diku.dk>
 <ddb82bf60811100214j4246cf25yc1263c2ae8cd10fc@mail.gmail.com>
 <20081112000445.GB17662@diku.dk>
 <ddb82bf60811140502y60987761g55fc959a3e246afe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jonas Fonseca" <fonseca@diku.dk>, git@vger.kernel.org
To: "Piotr Findeisen" <piotr.findeisen@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 13:09:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Jy0-0006gk-3q
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 13:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbYKOMIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 07:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754872AbYKOMIP
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 07:08:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859AbYKOMIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 07:08:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ACF807DAC3;
	Sat, 15 Nov 2008 07:08:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4F1247DAC2; Sat,
 15 Nov 2008 07:08:03 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 13F8B2DC-B30E-11DD-A397-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101061>

"Piotr Findeisen" <piotr.findeisen@gmail.com> writes:

> However, this seems a bit messy -- fighting against asciidoc instead
> of using it as it's designed to be used. IMHO, it's better to
> explicitly escape non-punctuation "--" with "\" and write punctuation
> "--" with spaces on both sides.

Thanks for digging.  I agree with that.
