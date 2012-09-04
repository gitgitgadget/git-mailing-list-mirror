From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Tue, 04 Sep 2012 16:31:09 -0700
Message-ID: <7vwr0974ci.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CACsJy8C36eghwEOYqbnd2z5C5KnynWsvwMDa4e2hns3uW243EQ@mail.gmail.com>
 <CAB9Jk9CNYr6LfWvyVqXvHjh7dzhUAuzkufqO9YMeOXg08D2cJw@mail.gmail.com>
 <CACsJy8AUYigHVKjzE-0NT0hnOrQWdufN+COmkk=2Q8L1Rimytw@mail.gmail.com>
 <CAB9Jk9D0DHBJEpVq=Z=12TV=+Av0oFVZ0yO1svLh1wyuP+9r1Q@mail.gmail.com>
 <7v4nndd98g.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9DVcG14mS3HaGE4JEY0AwExvjqrnQqzTEZxHLjEQ6UObg@mail.gmail.com>
 <7vobll8qn2.fsf@alter.siamese.dyndns.org>
 <53AE674D81CD4B9CB013C1DE846240B2@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Angelo Borsotti" <angelo.borsotti@gmail.com>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 01:31:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T92aW-0008KW-8f
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 01:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885Ab2IDXbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 19:31:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59282 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752445Ab2IDXbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 19:31:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AA398ACC;
	Tue,  4 Sep 2012 19:31:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PMe7w8yXNOTVXyZoaYBKf5gnfAY=; b=teUXjI
	Xg0t+E7i1dsAyDunvIY0AN/wER8tSLRrtPT1XjmKc7LfpNNqAT9xLbCdwwDleBBj
	cJjpKWupnLgEkeh7tVW8lFCNwAkxmBPDgewXLWztzzWAHJZrN98w537lDTX6yhJA
	RdnxPFDCUysgCdkR1njlg1ZiErqgXWJDWaA9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WM5JneVIUPcgSZU6va0p6UeI/7xNx1WV
	vTeFssIv9NGnFaEPIbi35He4qTGqMdGWtJJfhYLsEpp99R8v8jTVuucjzdteV2Hq
	ws2a6Plbt2ZyOGYeG674Yse9d3OFR1zRCN0l48WiPh9zY+b3GEjm5C1f1vHaCvZu
	Atp4PmjmboE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDABF8AC8;
	Tue,  4 Sep 2012 19:31:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 585CA8AC6; Tue,  4 Sep 2012
 19:31:11 -0400 (EDT)
In-Reply-To: <53AE674D81CD4B9CB013C1DE846240B2@PhilipOakley> (Philip Oakley's
 message of "Tue, 4 Sep 2012 23:53:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C582F46-F6E8-11E1-ABB6-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204794>

"Philip Oakley" <philipoakley@iee.org> writes:

> A comment about the need to quote wild cards would certainly be of
> advantage to many Windows users who won't have used a shell in that
> way before.
>
> Plus I suspect that a large fraction of basic unix/linux users will
> have never really considered the difference between shell expansion
> and git expansion in this case where there are two diifferent 'file
> systems', as demonstrated by the initial query. 

OK, anybody wants to do a patch on top of 5635be1 (on 'pu') or on
caae319 (which is 5635be1^2), which adds an example of quoted
fileglob to git-checkout documentation?
