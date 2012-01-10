From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] clone: print advice on checking out detached HEAD
Date: Mon, 09 Jan 2012 16:36:10 -0800
Message-ID: <7v4nw4cs1x.fsf@alter.siamese.dyndns.org>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 01:36:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkPhP-0002dM-7c
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 01:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933640Ab2AJAgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 19:36:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933621Ab2AJAgM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 19:36:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DEFD64E9;
	Mon,  9 Jan 2012 19:36:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qGbE9C5Ztt3RfhqKw7oqcBndvZI=; b=s8xAtL
	rMFMOisVsWGoXe7BGx3mEQTHQbJw1vEV1w7fiTKfYWpLAj6wDrDcbSGotHRLbUuv
	n4QjLA5QbPy0slBtANCSww4jhc2w18cyUwF8hb7uD+8PuLxQ9zMKu5iFVVEQK3ot
	jWRmmJmk8mVVx7Pnw6zBoT5Q73Yoz7yf/h2ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n7NbWgYaPj1KblBAqbXGc/LFsuScEfvn
	vMGZoGsKjfyYz1/OVW3bPOnTSDMAcsBqE5IEMqV1VnwdjsrByHtKOXJzODFbdfWt
	NVi5h949C0vGtxh7HUZkBgCP/IYjigK9iwvQr/iIj687vxCAxHMSAHoCu8N0pL1Z
	TbyZC7FHCw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6582F64E8;
	Mon,  9 Jan 2012 19:36:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA86464E7; Mon,  9 Jan 2012
 19:36:11 -0500 (EST)
In-Reply-To: <1326023188-15559-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 8 Jan
 2012 18:46:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18846A1C-3B23-11E1-96A3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188203>

This patch makes 100% sense _if_ we let clone result in a repository with
a detached HEAD, which I am not sure if it is a good idea, or if it is
better to fail the attempt to clone to give incentive to the owner of the
remote repository to fix it.
