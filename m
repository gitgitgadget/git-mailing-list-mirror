From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/6] gitweb: feed metadata enhancements
Date: Fri, 06 Feb 2009 16:24:04 -0800
Message-ID: <7vab8z14d7.fsf@gitster.siamese.dyndns.org>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
 <200902062342.57994.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 01:25:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVb0v-00048x-7r
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 01:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbZBGAYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 19:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbZBGAYO
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 19:24:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbZBGAYN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 19:24:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BBEAF2A973;
	Fri,  6 Feb 2009 19:24:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B91472A978; Fri, 
 6 Feb 2009 19:24:06 -0500 (EST)
In-Reply-To: <200902062342.57994.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 6 Feb 2009 23:42:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A51B5EAA-F4AD-11DD-BC5C-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108802>

Jakub Narebski <jnareb@gmail.com> writes:

> On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:
>
>> This second revision adds two patches to improve client-side rss
>> caching: the last-modified header we output is based on commit rather
>> than creation time, and we now act on if-modified-since request headers.
>> 
>> The last patch requires either HTTP::Date (from libwww-perl) or
>> Time::ParseDate
>
>
> Below there is summary of my comments.

Thanks.
