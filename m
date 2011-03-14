From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'typechange' in the git-status output
Date: Mon, 14 Mar 2011 12:44:01 -0700
Message-ID: <7vhbb5cwse.fsf@alter.siamese.dyndns.org>
References: <AANLkTimWR0avW6mBWGa0ArVB8oZUM7nuvc5AYf=wgU-W@mail.gmail.com>
 <AANLkTikkHWFrjmrPMP_poxrkCwE34jqaFDbU1Roouw--@mail.gmail.com>
 <1300129161.13980.4.camel@drew-northup.unet.maine.edu>
 <20110314192238.GA30378@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 20:44:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzDgk-0003j2-FR
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 20:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981Ab1CNToR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 15:44:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab1CNToQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 15:44:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A83745B8;
	Mon, 14 Mar 2011 15:45:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uq3fFDK7a1nrFz1TrqA5wfA0eAQ=; b=KuQlIx
	dw4obc2qVVRquqkFiZR4jDekgnzlwQYrUVNq+L77sxi8AIPqXftdaKN+RhgWjWDV
	7iCvqjrY7qH4br6kI2EUj2FQjhmGep/YmqtMMVz/xhySMR+HcCgAPOUGEbY3Yv6x
	+yyZUt0JB+h2zotSD14NEytVOg/gBW537uDmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tWWZJQFGitHtDuJZc5JQdIklwI7Lwvqb
	nngCXlAeSkWzi6Pi1pm2rh/EUqD+RR3nQFA/VkV+y5Z4aBs5JDEgYfOQM9C0rxlG
	Il7D67MPnVSSY69HMcy73mqYfWzQRnMZVOy0AzVLWS5gaLzctgrQafGpou/iaWbn
	THOjNNnnlDU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CD7A145B7;
	Mon, 14 Mar 2011 15:45:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6576D45B0; Mon, 14 Mar 2011
 15:45:32 -0400 (EDT)
In-Reply-To: <20110314192238.GA30378@elie> (Jonathan Nieder's message of
 "Mon, 14 Mar 2011 14:22:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3CF18E4-4E73-11E0-942C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169017>

Jonathan Nieder <jrnieder@gmail.com> writes:

> On the other hand, if you want to _back up_ or sneakernet a git repo,
> I agree that "git bundle create /path/to/backup.bundle --all" is
> better.
>
> Perhaps the user manual could explain this somewhere.

I agree "bundle" documentation would be a good place to show that "better"
way.
