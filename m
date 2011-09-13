From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] t9159-*.sh: Don't use the svn '@<rev>' syntax
Date: Tue, 13 Sep 2011 10:14:20 -0700
Message-ID: <7v1uvkxt3n.fsf@alter.siamese.dyndns.org>
References: <4E21D295.7020600@ramsay1.demon.co.uk>
 <7vvcuy82kn.fsf@alter.siamese.dyndns.org>
 <4E269AB6.8070207@drmicha.warpmail.net> <4E27098B.906@vilain.net>
 <4E6BA0FA.9070103@ramsay1.demon.co.uk> <20110913075726.GA15066@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 19:14:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3WZ2-0007Go-9h
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 19:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595Ab1IMROX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 13:14:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49066 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755416Ab1IMROX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 13:14:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D24505F27;
	Tue, 13 Sep 2011 13:14:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=DqKYC2
	yl3/NqXQq/eI8v/osjqXLpQhI2rO0heK7c7n20N9cDy2rcK9Xv71iyu3BewCqCkI
	AUgljv/BOdzG9K2hOET/5eN1BOl+QrHkDlC03qE7POL2mRLZae+0put5Jm4jxMd8
	8YY9G6VMNxwwKiJ0S07X2EzihAa7jdNz9qgfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eXKn7aBwB2em5kN0mFiNp9aQHK2HpAZ0
	o1rLjkYJR3q6y+MoNrJuURLKTKQ4qRQF4n+WFE8dYcFhL34hjlt6TwtkH7zPacV0
	ZSevzCRV8ZXUIHmUwj/dm2SGTMLClQOWeNscG81Qy0RkMIhb1OL3PNxQX7ww4tRE
	Q3aJ6qAGnV4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA1DE5F26;
	Tue, 13 Sep 2011 13:14:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C5885F24; Tue, 13 Sep 2011
 13:14:22 -0400 (EDT)
In-Reply-To: <20110913075726.GA15066@dcvr.yhbt.net> (Eric Wong's message of
 "Tue, 13 Sep 2011 07:57:26 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2E2C26E-DE2B-11E0-AC49-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181293>

Thanks; will queue.
