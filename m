From: Mark Dominus <mjd@icgroup.com>
Subject: Re: [PATCH] document 'T' status from git-status
Date: Mon, 31 Oct 2011 10:04:21 -0400
Message-ID: <4EAEAAE5.30209@icgroup.com>
References: <1319933204-21587-1-git-send-email-mjd@plover.com>
 <7vmxcjro5t.fsf@alter.siamese.dyndns.org> <4EADB4DB.5020004@icgroup.com>
 <7vpqhdrdys.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 15:04:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKsTf-0004bZ-EU
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 15:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497Ab1JaOEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 10:04:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab1JaOEd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 10:04:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54E984590;
	Mon, 31 Oct 2011 10:04:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=VIHbwt4gahDT
	1CZ0w2eu445HlLk=; b=WwF+XtyFZMvdM8/YTBXcHr1o2OzLlw5UHRAtPAi9lbcU
	z0NYXGttZAfovrs5DYxLkfDzDldMQ4rdlYNG0RInOTqsMMm2NXOSRQ6G1LHowj6o
	+Un4xVdH/gL6Rzb11gjhtDF/pLAJRrvkSMxmtFJwceA5i9SrROYR4iobnGGPLTA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B794458E;
	Mon, 31 Oct 2011 10:04:32 -0400 (EDT)
Received: from [10.80.10.81] (unknown [66.92.52.243]) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPA id 71CEC458C; Mon, 31 Oct 2011
 10:04:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23)
 Gecko/20110921 Thunderbird/3.1.15
In-Reply-To: <7vpqhdrdys.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 40A9A322-03C9-11E1-982B-9DB42E706CDE-09857176!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184505>


> It is trivial if

Yes, it was very stupid of me to miss that.

> I dunno.
>
> An obvious alternative is to add T next to all occurrences of M in the
> table where we say "M is possible", but unless it is accompanied by an
> explanation "T is just a special case of M", I suspect the resulting
> description would be harder to understand than currently is, and as long
> as the reader understands "T is just a special case of M", then there
> isn't much point adding T everywhere M appears in the table anyway, so...

If you are suggesting that the patch you gave is preferable to actually 
including T in the table, then I agree. Your patch is also better than 
what I sent because it includes the unusual word "filetype", which the 
user is likely to search for after seeing it in the git-status output.
