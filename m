From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/19]  convert test -a/-o to && and || patch series
Date: Tue, 20 May 2014 10:57:34 -0700
Message-ID: <xmqqy4xwz629.fsf@gitster.dls.corp.google.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 19:57:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmoIK-0006nY-4G
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 19:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbaETR5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 13:57:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65223 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbaETR5j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 13:57:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 370331860D;
	Tue, 20 May 2014 13:57:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k2bkFO6FP2qyAWpket3fOU9zkv0=; b=sW0N9c
	vxRUjEhjcXI/ozg9axcdD26ToWN7iHDGvPO+OugBEZBHKOUqYIDfW3AMSoFua8m+
	puWU1IIfCYeC8NoSWHXt15JtDNvI3Vi+kfRL9B9Wjzfz806OSbFglym1Gf83K1lr
	MRLTzNaceMPZjD/fUjLfpvya11IkEdjf1HSD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L9bQN6NM6/CurohGZ1o9Ue0FLI+kLYjO
	EmOx0dIXThgCkJoJoFZX0G9sUhHACO0qaz47NXMYFifFFj5UgUvd/v1zU0Zy6JJ6
	FAgRg8ItCF0ZD0ww7jconptJEPszXzULOEa/30WA9odF9v7ZW8NoRjDv667IyMLg
	8u970+inlWo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E04E1860C;
	Tue, 20 May 2014 13:57:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1C73518607;
	Tue, 20 May 2014 13:57:36 -0400 (EDT)
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 20 May 2014 06:50:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 39AEA186-E048-11E3-B9C0-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249712>

Elia Pinto <gitter.spiros@gmail.com> writes:

> These patch series  convert test -a/-o to && and ||.
>
> This is the second version.

Perhaps slightly off-topic, but has the remainder of the previous $(...)
series been perfected and ready to apply?
