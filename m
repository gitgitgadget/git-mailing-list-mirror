From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] port --ignore-unmatch to "git add"
Date: Fri, 14 Aug 2009 12:52:33 -0700
Message-ID: <7vws56i35q.fsf@alter.siamese.dyndns.org>
References: <200908121726.52121.luke-jr@utopios.org>
 <1250133624-2272-1-git-send-email-luke-jr+git@utopios.org>
 <7vy6pna4lu.fsf@alter.siamese.dyndns.org>
 <200908132306.37947.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Dashjr <luke-jr+git@utopios.org>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 14 21:52:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc2pe-0001OA-1g
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 21:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757091AbZHNTwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 15:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757089AbZHNTwi
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 15:52:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57444 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757087AbZHNTwi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 15:52:38 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 43F12294D4;
	Fri, 14 Aug 2009 15:52:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D77D3294D0; Fri, 14 Aug 2009
 15:52:34 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 057E084A-890C-11DE-8955-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125942>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>> 
>> Chould you refresh my memory a bit?
>> 
>> In what circumstance is "rm --ignore-unmatch" useful to begin with?
>
> Not sure about add --ignore-unmatch myself, but there's even an
> example of rm --ignore-unmatch in man git-filter-branch, along the
> lines of
>
>   git filter-branch --index-filter '
>     rm --ignore-unmach some_file_that_shouldnt_be_in_history
>   ' -- --all

Ah, that makes sense.  I am not sure about "add --ignore-unmatch" myself
either, and an example similar to the above filter-branch would not apply
very easily (i.e. "add a file that should have been in history" would not
need --ignore-unmatch).
