From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-svn: memoize _rev_list and rebuild
Date: Thu, 23 Jan 2014 08:49:43 -0800
Message-ID: <xmqq8uu6wsg4.fsf@gitster.dls.corp.google.com>
References: <1390443319-11239-1-git-send-email-manjian2006@gmail.com>
	<20140123025807.GA4370@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: manjian2006@gmail.com, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 17:53:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6NWw-00018K-9B
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 17:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbaAWQxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 11:53:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59790 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777AbaAWQxV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 11:53:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8270065BE4;
	Thu, 23 Jan 2014 11:53:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=ZUfRO1E02NYE84m8Vr/hwEOuKUs=; b=GSoZMPAULrkHZjME1xis
	Ok+fI2ZG5EKrooRJcA5XJwHC/MVIHO/YaUs1AMNMDX6R08lPIKczNECW7fBwVS6Y
	kFKZOmVvdJB9i0FCiV/3iBJHU1AYVHtKDyI8O/84aAf8mOGoRAlXjhctUWjJlJ4w
	st+tyh5y9ku2JlWLZQFvOw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=DQXkFuKq1HlPbE2eqB07he/MDPBPhfYTEhtyASCt8s1SYy
	vlvnAthuKj6GmaPSSi3eHXmWuxDqzm5nCIkRHmMoH+gmXZZ+CO++ON7wImYUFi20
	XgajCDXMuebxnyy8sjDmk8o8M8WLq2AcfI7Y6EFZgxF+rtHHWz6dMTuKFwBpg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72FA265BE3;
	Thu, 23 Jan 2014 11:53:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B5B465BE2;
	Thu, 23 Jan 2014 11:53:19 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DC97A72C-844E-11E3-BF9B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240917>

Eric Wong <normalperson@yhbt.net> writes:

> Pushed for Junio.

Thanks.
