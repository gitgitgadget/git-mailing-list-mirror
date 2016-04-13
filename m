From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/2] Fix relative path issues in recursive submodules.
Date: Wed, 13 Apr 2016 15:23:43 -0700
Message-ID: <xmqqzisxi1w0.fsf@gitster.mtv.corp.google.com>
References: <1459469849-9643-1-git-send-email-sbeller@google.com>
	<56FE8898.20906@ramsayjones.plus.com>
	<CAGZ79kYE3E7stNc3Xbzr-qvncLGt4qRPMbv897k5h0B50-Rogg@mail.gmail.com>
	<570E9C46.6080905@ramsayjones.plus.com>
	<CAGZ79kYj+4_6BsrcRRzsvdp_FcRG9VuiJ1tLjSo3D5_uWe2nfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Norio Nomura <norio.nomura@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:23:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqTCR-0006ut-LJ
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbcDMWXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:23:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62542 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753033AbcDMWXq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:23:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C4E712756;
	Wed, 13 Apr 2016 18:23:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EQ8zyKgdw00MhPqdLJh/X3qpJeQ=; b=O3yC9L
	82qOOeB8S2wBbVPaEU+7AVWe9DetX44IlQehpNNSfBWLa6Rz1GtXYNe3RvqKcFq+
	7tdv2H9pP9Q5cbqPYrc0Zy25J8Ao4zHlH3AogWm8Ox+LspTgD+FAVJ1vivfDCGXb
	0+ktdS0d3R9wLvW87BX25+gpdTOSeMDAlUhtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iErfmnQ+bywxO/wcefRD84QibSDekUZd
	oAv4bZAv5ELKzkmS3WDUdYVkv6D5u6Wmjc/j9MoMVv46tYNGRpYjxxindACxgvTr
	b2I/sv7m1QDrEzyxfVJ+4MEqiNZCy6OPsNWFHTOuhujpHLm1KySRBeguZegcSGwp
	nAxHDbdlrts=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3479D12755;
	Wed, 13 Apr 2016 18:23:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9787212754;
	Wed, 13 Apr 2016 18:23:44 -0400 (EDT)
In-Reply-To: <CAGZ79kYj+4_6BsrcRRzsvdp_FcRG9VuiJ1tLjSo3D5_uWe2nfQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 13 Apr 2016 13:34:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6256018C-01C6-11E6-BE04-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291499>

Stefan Beller <sbeller@google.com> writes:

>
> Ok fixed this instance here, too.

... So... should I hold sb/submodule-helper-clone-regression-fix?
It has been marked to be merged to 'next' for some time now.
