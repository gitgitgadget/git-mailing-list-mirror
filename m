From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 06/10] fast-export: add new --refspec option
Date: Mon, 11 Nov 2013 15:25:45 -0800
Message-ID: <xmqqd2m6jyue.fsf@gitster.dls.corp.google.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
	<1384210507-26561-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 00:36:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg11U-00045Q-U9
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab3KKXf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:35:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204Ab3KKXf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:35:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B453951424;
	Mon, 11 Nov 2013 18:35:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=BeWEHDKjToAHvXZtGfBFexOGbfQ=; b=C0MF7GqaiREhQWKQIZIJ
	5J16anLCuhlAWh7D7WorERR4F4EN1BfqeepdZMP69SEqOEQylp05jwZnDnS9LH+r
	y7jmOFv2uV9oW1idiGI+2qJ+If9d6WGkxD+atPvlslpk8FtCji6EhvG83NIpmHhh
	+f8MJ+8C3bUud0hi59GS4Co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=QRDwIKRiYBV1j3G2d7zc7S/BrUXwoTeSLSse4kG9C8TwP2
	K7roSZ6MhrHAGWI6UOj3AGIbvTQ1LSgKojep63xlV41fhZ91pbjj6ehxs5R3SD6j
	VLBFW1wQmkyhFdCOjljf/1vfp02OYJgliFJ+nkXyPt895PsXmpbdeJC31FmhY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1B1651423;
	Mon, 11 Nov 2013 18:35:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0039151422;
	Mon, 11 Nov 2013 18:35:54 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0246097C-4B2A-11E3-83D9-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237677>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So that we can convert the exported ref names.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

I thought that the discussion agreed this option should not be
called --refspec but something like --refmap?
