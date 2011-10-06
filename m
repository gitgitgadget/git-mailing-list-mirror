From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-difftool: allow skipping file by typing 'n' at
 prompt
Date: Thu, 06 Oct 2011 10:36:40 -0700
Message-ID: <7v62k210pj.fsf@alter.siamese.dyndns.org>
References: <20111004105333.GA24331@atcmail.atc.tcs.com>
 <7vbotwdbjg.fsf@alter.siamese.dyndns.org>
 <CABURp0qmYWRJzHZZwZreKnj0ymFyM_AYXWXqwy=vTZspoPvvvg@mail.gmail.com>
 <7vty7oblpu.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gssgpy7nF46c1roJUCN5yvQaOYfVE_-ZrvMfHGWKvk0w@mail.gmail.com>
 <20111006125658.GB18709@sita-lt.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Sitaram Chamarty <sitaram@atc.tcs.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:36:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrsJ-00006N-5K
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180Ab1JFRgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:36:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965106Ab1JFRgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:36:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8865666A5;
	Thu,  6 Oct 2011 13:36:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=et1bSlAwc1Xfusx1asaz726V0kw=; b=vmLmEL
	sArt408bdWxJG+Snc5u6MwK8w3FEDy5UpC3F5P9gEuMmPdXEucHzZxQCCmeq3gRp
	9xhjczKz6Mu7CbYNRo6zsqBuKEMrzxUfOxujDbcMsifq4M/a7D0ZT9+vI4AtZIgL
	v++bJJyTqSoxEgo8/9cy5t24JiIstBhHI+sKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WPHaMyeAwfKmMafU08O9zZ/sQHe9CxGb
	GuWbJVZTiSAHZq3izDaXAYOxQmYa4KDNVgxHCa3Q2SouttKatz/tviFx3aa7PlmZ
	5VEE0X0AObLh6H4oJDIXm/MVHdYnpGSh9w3q/0Ttjfo4ZsI5zeSXxieNglmQDJSG
	E9FUwYzZmQE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EF2C66A4;
	Thu,  6 Oct 2011 13:36:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0D1A66A3; Thu,  6 Oct 2011
 13:36:41 -0400 (EDT)
In-Reply-To: <20111006125658.GB18709@sita-lt.atc.tcs.com> (Sitaram Chamarty's
 message of "Thu, 6 Oct 2011 18:26:58 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0D70D6E-F041-11E0-89CF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182999>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Signed-off-by: Sitaram Chamarty <sitaram@atc.tcs.com>
> ---
>
> (re-rolled according to earlier discussion)

Thanks. It is clear from the subject and the patch text that you are
changing "hit return to unconditionally launch" into "launch it if you
want to", but can you give justification why a choice not to launch is
needed in the log message?
