From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] log/ format-patch improvements
Date: Thu, 26 Aug 2010 08:37:22 -0700
Message-ID: <7vk4ndo05p.fsf@alter.siamese.dyndns.org>
References: <1282422531-29673-1-git-send-email-artagnon@gmail.com>
 <20100825084416.GC3280@kytes> <20100825205416.GB2319@burratino>
 <20100826053439.GB9407@kytes> <20100826054659.GC9708@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 17:37:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoeWT-0001GL-VX
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 17:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab0HZPhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 11:37:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab0HZPhk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 11:37:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D4A8D08E8;
	Thu, 26 Aug 2010 11:37:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WLNgUCez22S0E5EVUwYBtsa5jbs=; b=Fbqh9n
	y7ZoWalTbmIKG+A//GibGmczre5VWQQYOP401hbL7DYEK1Dx1C9p7A5DXMI46KDu
	ewVn515hCLY+uaoyLTMwFdL7WfbMNkN8SyPfJFB1nFtzMPJf7tmSMhMN1NZmfbQq
	FxuikSa3qYQMSEsK2dJq4zg38btO7Rk9hEsSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qbLhtUsGaCEEZR7hyv07hnXpb/JYuU9/
	pflnPpMl+4jWj0dVKEtG3t4+28DvlD72nHIxTBHGl7lxu6zwr6bzhZI+bVlOghOB
	98EIokURUj9i6+aqVlTcAMx0MPZyrDKu9Uo22yksOaak+4C4yS4dsCbQ9m7I1hew
	2b6CUJrhUXU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D7D54D08E3;
	Thu, 26 Aug 2010 11:37:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C94BED08E1; Thu, 26 Aug
 2010 11:37:24 -0400 (EDT)
In-Reply-To: <20100826054659.GC9708@burratino> (Jonathan Nieder's message of
 "Thu\, 26 Aug 2010 00\:46\:59 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D74E4008-B127-11DF-8F35-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154542>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
> ...
>> Good idea. I'll write a patch. Do we also want people to be able to
>> turn off `--no-merges`?
>
> I don't see a need for it.
>
> However, if you can think of good names for --undo-no-merges and
> --undo-merges options to "git log", that might be a nice independent
> change for the revision option parser.

Wait a bit.  How would you represent a merge in a patch form that can be
read by "git apply" (and "patch") in the first place?
