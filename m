From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 2/2] gitweb: Hyperlink multiple git hashes on the
 same commit message line
Date: Fri, 20 Feb 2009 00:35:41 -0800
Message-ID: <7v4oypfqua.fsf@gitster.siamese.dyndns.org>
References: <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org>
 <1234926043-7471-2-git-send-email-marcel@oak.homeunix.org>
 <200902182255.13983.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Marcel M. Cary" <marcel@oak.homeunix.org>, git@vger.kernel.org,
	fg@one2team.net, giuseppe.bilotta@gmail.com, pasky@suse.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 09:37:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaQsv-0006g5-Ey
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 09:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757246AbZBTIf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 03:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756820AbZBTIf6
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 03:35:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756673AbZBTIf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 03:35:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A9FB9B391;
	Fri, 20 Feb 2009 03:35:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 610EF9B38D; Fri,
 20 Feb 2009 03:35:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7E2533E4-FF29-11DD-BDB1-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110819>

Jakub Narebski <jnareb@gmail.com> writes:

>> +	$line =~ s{\b([0-9a-fA-F]{8,40})\b}{
>> +		return $cgi->a({-href => href(action=>"object", hash=>$1),
>> +					   -class => "text"}, $1);
>> +	}eg;
>> +
>
> Almost correct... but for this unnecessary 'return' statement.
> Without it: ACK.

I've applied this directly on 'master' without the return from inside s///e
with your Ack.  Please check the result.

Thanks.
