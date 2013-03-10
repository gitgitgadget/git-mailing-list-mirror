From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] shell: new no-interactive-login command to print a
 custom message
Date: Sat, 09 Mar 2013 21:04:51 -0800
Message-ID: <7v38w3etfw.fsf@alter.siamese.dyndns.org>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130309215237.GA24777@elie.Belkin> <20130309220011.GC24777@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 06:05:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEYRv-0008DM-0G
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 06:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826Ab3CJFEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 00:04:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53036 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab3CJFEx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 00:04:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62570C3EE;
	Sun, 10 Mar 2013 00:04:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ldGduI+4I0kKA7pQ73bN0VrHL9I=; b=vYSqnQ
	3iKJIMz6Jh1fe2vmtj67vyaVkzZ2vBcN1EjR05BBDxfvOAg+kS8LDaKtU5Ayl+Uq
	w1Fxsxzcat2cC1/Zbshg4qG1XsibQzE+Rnf7fYWtOcwBt7GRR/hoYdjWv9jvKHMi
	eRgen/XcrHnB4foXOW26G8bahq35VzvoC4Mds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s/1bitLCgklE/m46Sdj2QQpqHqfX3fQR
	/UfFPEa8MPo1Od58D7G2JisDc1LzCjYeJXjj+EIYhPzyLUuYkx+0AKM7LMGgzb3o
	ZBmKBk4nIAtughUT89CDtOcvy9fgrutRWKzKRK5+LPcqkLIiS3rup8F39e7HfCcn
	iWPXxOu/lio=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 558E5C3ED;
	Sun, 10 Mar 2013 00:04:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C08F9C3EB; Sun, 10 Mar 2013
 00:04:52 -0500 (EST)
In-Reply-To: <20130309220011.GC24777@elie.Belkin> (Jonathan Nieder's message
 of "Sat, 9 Mar 2013 14:00:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0AE149FE-8940-11E2-9195-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217778>

Jonathan Nieder <jrnieder@gmail.com> writes:

> If I disable git-shell's interactive mode by removing the
> ~/git-shell-commands directory, attempts to use 'ssh' in produce a
> message intended for the administrator:

Sorry, but -ECANTPARSE.  s/in produce/produces/ perhaps?  Or if you
meant "ssh in" as a verb, then "attempts to ssh in to the service
produces a message".  I dunno.

Patch text looks good, including the documentation.

Thanks.
