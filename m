From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid the use of backslash-at-eol in pack-objects usage
 string.
Date: Thu, 17 Sep 2009 15:00:36 -0700
Message-ID: <7vvdjhgrjv.fsf@alter.siamese.dyndns.org>
References: <1253224300-18017-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 00:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoP23-000856-Hl
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 00:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbZIQWAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 18:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbZIQWAm
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 18:00:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZIQWAl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 18:00:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 55FAE362B0;
	Thu, 17 Sep 2009 18:00:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0sO7qdQIFmOkHdtxdXd/iOm/fsw=; b=FpYoPr
	NBIaviqvaKEEikFQRu7VZIS+dqmFcTf9yQJYjU7Dx9116FV1ipdKxwfEpZTVS945
	JUYMXUg4nF8OuSbVTL/4k/mPNxOjqunVP1E3yFB1ZSqune5sDAtt/EjcSIE3OzIB
	KwKUXVhVu9KicDZb0sT7i+Gn26eXuwe49weH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UIQmrm9xIGIhTTSHDgc6ja+QMIaZzwyE
	6MJSTJFKwCtnHy4iiVU97misn82ABe5nwl/I6NiFfoKhxvygiDKFkTTtYrikN51N
	ODU6vIWNEH2VyGEna64oqZ/NF63QJfyKF2PTLeb0dRNYWt4+ZiDkmYdO8FBRrWxH
	b2vKNxiiAnA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39EB3362AF;
	Thu, 17 Sep 2009 18:00:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FFC4362AE; Thu, 17 Sep
 2009 18:00:37 -0400 (EDT)
In-Reply-To: <1253224300-18017-1-git-send-email-tfransosi@gmail.com> (Thiago
 Farina's message of "Thu\, 17 Sep 2009 17\:51\:40 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8AF0DF50-A3D5-11DE-B4E8-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128775>

Thiago Farina <tfransosi@gmail.com> writes:

> +static const char pack_usage[] =
> +  "git pack-objects [{ -q | --progress | --all-progress }] \n"
> +  "        [--max-pack-size=N] [--local] [--incremental] \n"
> +  "        [--window=N] [--window-memory=N] [--depth=N] \n"
> +  "        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n"
> +  "        [--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n"
> +  "        [--stdout | base-name] [--include-tag] \n"
> +  "        [--keep-unreachable | --unpack-unreachable] \n"
> +  "        [<ref-list | <object-list]";

Do you still want to keep the trailing whitespace on these lines?
