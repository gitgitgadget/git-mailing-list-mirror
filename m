From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] userdiff: funcname and word patterns for sh
Date: Wed, 25 Mar 2015 14:36:26 -0700
Message-ID: <xmqqiodo2205.fsf@gitster.dls.corp.google.com>
References: <1425918999-11992-2-git-send-email-adrien+dev@schischi.me>
	<1425944432-23642-1-git-send-email-adrien+dev@schischi.me>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr
To: Adrien Schildknecht <adrien+dev@schischi.me>
X-From: git-owner@vger.kernel.org Wed Mar 25 22:36:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YasyX-0004XI-L2
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 22:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbbCYVg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 17:36:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751092AbbCYVg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 17:36:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 147FF43F35;
	Wed, 25 Mar 2015 17:36:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9larLmFcKJe2YaI3SXFK/tZtXus=; b=jHp5sY
	lGt22ohRVNmcG4bmyrs9xP5O6h1l4WuZ+0zZOYIhFZMsIkaO+rI02LPApyd/h7iV
	brvbgkwj49kzQ3SSr47M1AvAyd27EJycTRaWv84idy7k7Pxaizb8B2RffqnENvZX
	+6uWtJo97EKK81KlpoaHL63vUH1zHBUfpmvcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YZeoFi4jOSlICItOt6mKbyM/W3JZK2l6
	KsnDeOKsfbbz2HnDyrpHz10pSJvdh+lccIyrnL92roO7myehzLjKsAInlKAojAOK
	9LcS30mYrNUM2O85v7oCxwc+jUr5E13Jrps3Iy45HmwHq0PAox2djgNrT65crGUq
	PMCz1PNYXkI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C82F43F34;
	Wed, 25 Mar 2015 17:36:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83FE243F33;
	Wed, 25 Mar 2015 17:36:27 -0400 (EDT)
In-Reply-To: <1425944432-23642-1-git-send-email-adrien+dev@schischi.me>
	(Adrien Schildknecht's message of "Tue, 10 Mar 2015 00:40:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE444E6A-D336-11E4-889B-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266305>

Adrien Schildknecht <adrien+dev@schischi.me> writes:

> Add regexp based on the "Shell Command Language" specifications.
> Because of the lax syntax of sh, some corner cases may not be
> handled properly.
>
> Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
> ---

Is a reroll for this patch coming, or should I drop this from my
tree for now?

Thanks.
