From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH try 2] gitweb: Add option to put a trailing slash on
 pathinfo-style project URLs
Date: Sat, 13 Dec 2008 14:37:13 -0800
Message-ID: <7vmyez4s86.fsf@gitster.siamese.dyndns.org>
References: <1229195421.3943.8.camel@mattlaptop2.local>
 <1229202689.31181.1.camel@mattlaptop2.local>
 <m3tz97g329.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 23:38:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBd8N-0002iY-AK
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 23:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbYLMWhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 17:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbYLMWhW
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 17:37:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbYLMWhV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 17:37:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B69968626A;
	Sat, 13 Dec 2008 17:37:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B9E5586269; Sat,
 13 Dec 2008 17:37:15 -0500 (EST)
In-Reply-To: <m3tz97g329.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sat, 13 Dec 2008 13:47:46 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9A86B452-C966-11DD-B06C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103032>

Jakub Narebski <jnareb@gmail.com> writes:

>> +	# If you want a trailing slash on the project path (because, for
>> +	# example, you have a real directory at that URL and are using
>> +	# some rewrite magic to invoke gitweb), then set:
>> +	# $feature{'pathinfo'}{'default'} = [1, 1];
>> +
>
> Are any disadvantages to having it always enabled?

Good question.

>> +	my @use_pathinfo = gitweb_get_feature('pathinfo');
>
> Why not name those variables for better readability?
>
> +       my ($use_pathinfo, $trailing_slash) = gitweb_get_feature('pathinfo');

Good suggestion.
