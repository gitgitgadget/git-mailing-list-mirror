From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: make 'show' an alias for 'summary'
Date: Mon, 01 Oct 2012 10:41:41 -0700
Message-ID: <7vsj9yccoa.fsf@alter.siamese.dyndns.org>
References: <1348926195-4788-1-git-send-email-artagnon@gmail.com>
 <50670A94.2070504@web.de>
 <CALkWK0nCahg7165_JuJSj7u0UfYRGZgFjJ6O-o=HCwdsPwU-xg@mail.gmail.com>
 <50671364.5030205@web.de>
 <CALkWK0nRKopT4fm36UVyR4Jy1gfeSY4zGy+-nzxm=H=NGcR=DQ@mail.gmail.com>
 <5069D24A.6060101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 19:42:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIk0B-0000iK-2N
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 19:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab2JARlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 13:41:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46607 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753Ab2JARlo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 13:41:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C10AE94F9;
	Mon,  1 Oct 2012 13:41:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R/Fs1zRmcaxZF1wvnfJf3CIoavI=; b=m49TyN
	bTpB6t5BtUY7pDp6c4/voJpNkDhqU3/Vq0SUxLjQerabT2CIiuYx+czQ69/3bn8j
	SlhqeyCS0YIWnNw8HgZR2Tuc2lx2a+jeyffRZH0jdKXtFv2/p1LlwLO9Xu/Lzxta
	Q3UorumBdUTOS4q4VIUsprNqazKSHWeb6aiJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fdezcp5ri6PnaMFB/unbbq+Rll+G9Lat
	DbNHLKsIbpryBFmSuo3OMgBCwomH0soPdxwNK3Of0Fm7QsuWnfqJ9MY0t5+yWrpy
	ENrb7I95AEMyrDdULT1IPuWP041ftBphylubEbL/HH+5zj8eicQtRBUc2iHH642X
	WoTlwlw5spk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE94A94F8;
	Mon,  1 Oct 2012 13:41:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26A7F94F6; Mon,  1 Oct 2012
 13:41:43 -0400 (EDT)
In-Reply-To: <5069D24A.6060101@web.de> (Jens Lehmann's message of "Mon, 01
 Oct 2012 19:26:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 437994D4-0BEF-11E2-885B-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206749>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Me too would expect a show command to show me a list of all the
> submodules and maybe some extra information (is it populated or
> not, does it have its .git directory embedded, does it contain
> changes). So maybe "show" should be a slightly pimped "status"?

What's the next inventive way somebody who did not read the
documentation will come up with to spell the subcommand known as
"status"?  "submodule list"?

Do we really want 47 different subcommands that give the same output
or slight variations thereof?
