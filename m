From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: Replaced /bin/sh with /bin/bash to make scripts
 with Bash syntax work on Solaris.
Date: Mon, 09 Aug 2010 09:57:27 -0700
Message-ID: <7vvd7j67wo.fsf@alter.siamese.dyndns.org>
References: <1281099365-11978-1-git-send-email-asgeir@twingine.no>
 <20100808031142.GA20077@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Asgeir S. Nilsen" <asgeir@twingine.no>, git@vger.kernel.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 18:57:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiVfh-0000cH-8F
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 18:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080Ab0HIQ5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 12:57:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab0HIQ5s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 12:57:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 522AB1BCC;
	Mon,  9 Aug 2010 12:57:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=93k3O5YrXGpPb4hOVYuodP8b7rM=; b=x0b4MCcgBvzAkKY9zc6yS86
	ZVznfIt4dwmkirCeSaE/cU0+9ugMBQvO5MefNCpIICXnQNwQHxGVT5FxucBoJUVa
	g9Zeo+QPSxBOFnniHOLQhPHEVosb9VDqqoqHXtpeRQm17m3eR6IY8QtzWR3z65le
	5yZFgv1+k2SwJ4UUWY8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=VEbeZYviZKno+NFSgSTJOGgbungjvU7w57GGHGGRV5Y1XZ/sT
	ghsVETpklZy7ve28LsZ19dtvQIGy9H8NaTyH3xI7OQh5cilS8SZWm0egx8pT+7dq
	CGzmv6EKRAN4e9W2YQv/jxf25hLxSK2i9WZiXNEoaqxAtyJ3wz4hWyRjas=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 760681BC2;
	Mon,  9 Aug 2010 12:57:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.126]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 576541BC0; Mon,  9 Aug
 2010 12:57:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37BF5714-A3D7-11DF-8964-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152988>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Asgeir S. Nilsen wrote:
>
>> +++ b/contrib/ciabot/ciabot.sh
>> @@ -1,4 +1,4 @@
>> -#!/bin/sh
>> +#!/bin/bash
>
> Maybe, relying on a sane $PATH:
>
> 	#!/usr/bin/env sh

That's even worse.  Please don't go there.
