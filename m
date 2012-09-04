From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Tue, 04 Sep 2012 08:31:59 -0700
Message-ID: <7vharddcsw.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CACsJy8C36eghwEOYqbnd2z5C5KnynWsvwMDa4e2hns3uW243EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 17:32:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8v6s-0000tY-8B
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 17:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159Ab2IDPcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 11:32:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204Ab2IDPcF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 11:32:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 849E58101;
	Tue,  4 Sep 2012 11:32:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KN6u7FZ5usmDYh/SrzGXBs/MRLw=; b=LhAyHr
	RHnGcNGaivpSHeVdgi0BzPZmO7zSBm4TutohgsXC1JC3eBRqc7/RF0HyVeoxuVs4
	vomMTsr4c2N5ceJldJHb3dCgxqAbSuFbHLU7tpKay+jnMymUVHRQbxPF7LG7WKll
	kqHC5sKAlGzmb6VPApvumqdRZvAN5ZdaSRPhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=blMsh353SM31BCMBDU/AM0YqyPTdm1zS
	z7ZqswSNwGtz5Vp2BJkickQgODuoL9Ip98rn9XW/MZxBzuyaQdXFtPC6nXgkzAO5
	ir/VDPF4nKqjOdSGMtv/aqB+eJg0t+2gL69TWdRrns+zRMhKlWV3NkSaTD7zGRyx
	nxyhRmosv/E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 711988100;
	Tue,  4 Sep 2012 11:32:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 942C980FF; Tue,  4 Sep 2012
 11:32:01 -0400 (EDT)
In-Reply-To: <CACsJy8C36eghwEOYqbnd2z5C5KnynWsvwMDa4e2hns3uW243EQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 4 Sep 2012 17:14:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC27AF48-F6A5-11E1-8F5F-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204748>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Tue, Sep 4, 2012 at 9:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Perhaps like this?
>
> Looks good. I was going to complain that this patch applied to
> git-checkout.txt only but I just saw git-add.txt also mentions about
> quoting wildcards. So I'm good.

Ok, with a log message like this:

    Document file-glob for "git checkout -- '*.c'"
    
    Just like we give a similar example in "git add" documentation.
