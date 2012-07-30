From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2 11/16] Add explanatory comment for transport-helpers
 refs mapping.
Date: Mon, 30 Jul 2012 10:38:28 -0700
Message-ID: <7vwr1lqhd7.fsf@alter.siamese.dyndns.org>
References: <1343658683-10713-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <20120730170842.GC8515@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:38:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvtvS-0005sg-Hn
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976Ab2G3Rid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 13:38:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42858 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680Ab2G3Rib (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 13:38:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF8A29B8D;
	Mon, 30 Jul 2012 13:38:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IpNC7DT4bibRXn9Pmy5AD5ETnnA=; b=b7l0km
	Zc5ecjBB10Lp1n2Hqk0jXaHXSZ4r4gDY61XRjDdztvJSbyBBjf3As8bo/X97SVVq
	76vjnqwI3dmKRjhychfeSqddvhNdeObGhRKrS2Lk8EvUFVQIqOxKAdRSaTlEt0Pf
	wSKKALOE0zEknTbdneCA/+hwzJ+kYbWEC3oeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oXYtbf2HFfW9U/j/BaI4Q/5/I/2s4ZDo
	tJ65rlvuZKxf+SQqJ4rqSmvVNrgVl1UHfTHfCYJ+jxhRWtMaussD1zY9QWkQXtHB
	CWlW7RGRlHUDhzG5ye60xQDr3x/R8Xtzh7FaPwEbcqv3uekccX+SSjFfjKYT7HUX
	pripJkMqTag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC2819B8C;
	Mon, 30 Jul 2012 13:38:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52BD09B8A; Mon, 30 Jul 2012
 13:38:30 -0400 (EDT)
In-Reply-To: <20120730170842.GC8515@burratino> (Jonathan Nieder's message of
 "Mon, 30 Jul 2012 12:08:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 608897FE-DA6D-11E1-BA03-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202590>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I would like to see the patch applied so the remote-svn series without
> it gets shorter and easier to review. ;-)  Munging the two context
> lines ending with argv_array_clear(&importer_argv); to
>
>  	free(fastimport.argv);
>  	fastimport.argv = NULL;
>
> makes this patch apply against master.  Does it look ready for
> application to you?  If you'd like, I can send a copy rebased against
> 'master'.

No need for that; "git apply -3" as well as "git am -3" can grok
this just fine ;-)

>> +	/*
>> +	 * If the remote helper advertised the "refspec" capability,
>> +	 * it will have the written result of the import to the refs

perhaps s/will have the written result of/would have written result of/?
