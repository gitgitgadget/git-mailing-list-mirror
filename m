From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 009/142] t0001-init.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 13:02:14 -0700
Message-ID: <xmqqpplakpx5.fsf@gitster.dls.corp.google.com>
References: <1395768283-31135-1-git-send-email-gitter.spiros@gmail.com>
	<1395768283-31135-10-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 21:02:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSXYJ-0003TO-0V
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 21:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbaCYUCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 16:02:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41532 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545AbaCYUCV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 16:02:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 282E876467;
	Tue, 25 Mar 2014 16:02:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mDnwLjb6G9wXPnSDZvXjzPpAGFA=; b=L/EW5k
	q6p+KBuB9Cxt46lIca7D9u/s/Hpy4qjZzIGCbLxb+UW4fH5pZ+iCcidfNvPdDwDK
	Txq/NPrnrd3EwfnxGmpnBgk+uZZXzJwqk29gkCmVnu7m/c7/UQbqu+VpM+T+vcz4
	VS9nxJEuhPKpl/j3mBXQYIOGEN6VVUPWyxApU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h4D0VDVhuixfs+VRD3vv0sEC6NmuLoAL
	OtwS+xU4NTwjwtZdjeP0s3DBrI2iHOF06ZKglvbXFdsnAqUboJ/F6iH/6Ayskfyl
	7bAs+QWQRyjKdTuo+VyUQ21p+tgCgRROMxcXn2F0BHpcFmaEVMeB629dXGnfsvtO
	ziB/lPP+5Hg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EB1176459;
	Tue, 25 Mar 2014 16:02:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15B6D76448;
	Tue, 25 Mar 2014 16:02:18 -0400 (EDT)
In-Reply-To: <1395768283-31135-10-git-send-email-gitter.spiros@gmail.com>
	(Elia Pinto's message of "Tue, 25 Mar 2014 10:22:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5E26D9D2-B458-11E3-BB1D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245147>

This conflicts with a topic in flight.
