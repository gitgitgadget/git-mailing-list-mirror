From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git submodule update and the --merge flag when submodule is yet
 to be checked out
Date: Fri, 18 Mar 2011 14:35:15 -0700
Message-ID: <7vwrjwun70.fsf@alter.siamese.dyndns.org>
References: <AANLkTikJo_pjSAmVV3wjWi04io4zWb-_P5p81TYj9tq6@mail.gmail.com>
 <7vipvgw3c1.fsf@alter.siamese.dyndns.org>
 <201103181524.40521.olsonse@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Carl =?utf-8?Q?F=C3=BCrstenberg?= <azatoth@gmail.com>,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:35:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0hKc-00010r-GH
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 22:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607Ab1CRVfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 17:35:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131Ab1CRVfa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 17:35:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8A52045F5;
	Fri, 18 Mar 2011 17:37:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aaE+u2pYj7xyIpW8LfIfaQ8JwAY=; b=rsVR6V
	fU6j2ohjch2Nk4CUKOPPBXQ4H4syo/2ZLDHXfFo9anjkB/+j7ZLkH1J4x/6zpEXP
	J32j1yIDmggJh2OS1BSc7ynBIzFrO/qgNCvBccPjIE4JAzNRC44itw8ZxqBaxaCd
	Oxw5NEW2NDzoTOWwf2zudBFAe1YTIOLjy7qS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vIL0xU9c9ogfiwBW5aVfT8a3FZ+NidLL
	xiHPecRnTw0tKrVIk+OOOUN1LT2wTxkasZOP0TrkoHqueznd3xn1SiydEvz9EVAq
	xcxQpxXtEjGh2WrK2V2rnoomHBFbvn11JSz2Q3iTbfKPzQ3YKcN7eLZIFksztOBS
	h0L1y2LbU1o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D7A245F3;
	Fri, 18 Mar 2011 17:36:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A61C545ED; Fri, 18 Mar 2011
 17:36:51 -0400 (EDT)
In-Reply-To: <201103181524.40521.olsonse@umich.edu> (Spencer E. Olson's
 message of "Fri, 18 Mar 2011 14:24:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA1B4698-51A7-11E0-B451-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169366>

"Spencer E. Olson" <olsonse@umich.edu> writes:

> Yes, this was the intent of this fix last month

Thanks.
