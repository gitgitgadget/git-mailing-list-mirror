From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 0/3] gitweb: make static files accessible with
 PATH_INFO
Date: Sat, 31 Jan 2009 17:32:27 -0800
Message-ID: <7vd4e30wno.fsf@gitster.siamese.dyndns.org>
References: <1233365512-7130-1-git-send-email-giuseppe.bilotta@gmail.com>
 <200901310304.51205.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 02:34:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTRDl-0003lL-FE
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 02:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbZBABch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 20:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753280AbZBABcg
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 20:32:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbZBABcf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 20:32:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A6442A2F6;
	Sat, 31 Jan 2009 20:32:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 203EF2A2EE; Sat,
 31 Jan 2009 20:32:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 33C690DC-F000-11DD-B74F-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107964>

Jakub Narebski <jnareb@gmail.com> writes:

> Giuseppe Bilotta wrote:
>
>> This patchset includes
>> 
>> 1. the single patch to make static files accessible with PATH_INFO, with
>>    the same quoting standard as the nearby code;
>> 2. an additional patch that extends the README with some examples on how
>>    to configure Apache to use gitweb with PATH_INFO enabled by default
>>    (and gitweb as directory index);
>> 3. the repeatedly recommended comment fix to align comments to code in the
>>    git_header_html() sub.
>
> I like it. Ack for the whole series.

Thanks, both.  Applied.
