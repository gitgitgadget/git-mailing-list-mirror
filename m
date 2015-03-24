From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2015, #08; Mon, 23)
Date: Tue, 24 Mar 2015 15:26:21 -0700
Message-ID: <xmqqpp7y3ucy.fsf@gitster.dls.corp.google.com>
References: <xmqqmw338khu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Michael Wagner <mail@mwagner.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 23:26:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaXHW-0002Tq-6G
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 23:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbbCXW0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 18:26:38 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752444AbbCXW0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 18:26:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE5CA436A3;
	Tue, 24 Mar 2015 18:26:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:references:date:in-reply-to:message-id
	:mime-version:content-type; s=sasl; bh=+wqr5XKU/TyKJY5orYgAONTLQ
	7E=; b=OJUUaF6mt6JWeWmSBDhwSdDe3wF1qu3yL3gQE4wdxXyYQ2rfJspwQf86m
	DtC4ud5LAq0+OhSlpAZWUG1RIpWq8WlzudxeyHsl+kgDccFbdal2eaw24u89pZpb
	3kABfD1tPS63PKY2tNwGr3mhcqorilGQmoEcYqdVuPb6RbXlGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:references:date:in-reply-to:message-id
	:mime-version:content-type; q=dns; s=sasl; b=Bh43OOhq4n0NlinMBr0
	vb62WLzyRTn6mmpUkI24ZVBwcph1ZyDaEHY0F7teod3LY7FHzRNdi2+J3IwOCKN5
	5x9Sr4k8GuAXTuq9pVsOC6m/CA1NOFGukydHqrSxiexF/nlKjQ9jEouOHDSlidsg
	G2nEQCQLp9gJD6AJUkyApZkI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6982436A2;
	Tue, 24 Mar 2015 18:26:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 840854368A;
	Tue, 24 Mar 2015 18:26:22 -0400 (EDT)
References: <538F69DA.9010201@gmail.com>
In-Reply-To: <xmqqmw338khu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 23 Mar 2015 14:35:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CD0311C8-D274-11E4-8A16-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266235>

Junio C Hamano <gitster@pobox.com> writes:

> * jn/gitweb-utf8-in-links (2014-05-27) 1 commit
>  - gitweb: Harden UTF-8 handling in generated links

This has been lingering in my 'pu' branch without seeing any updates
since $gmane/250758; is anybody still interested in resurrecting it
and moving it forward?

Thanks.
