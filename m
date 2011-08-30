From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3903: fix misquoted rev-parse invocation
Date: Tue, 30 Aug 2011 11:03:44 -0700
Message-ID: <7vobz622v3.fsf@alter.siamese.dyndns.org>
References: <fa41d38f9297ca14b61e05033c9d1b5f5a778263.1314662636.git.trast@student.ethz.ch> <CAH3AnrophV=bi+70B8EnfZpBQXVbEAJ9nSo9UbZ2svDNre9W=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 20:03:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QySfC-0001b3-4Y
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 20:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935Ab1H3SDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 14:03:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141Ab1H3SDq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 14:03:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66F9E4977;
	Tue, 30 Aug 2011 14:03:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=N7WuDyLeDcKHEHRrtjsCNHTD4jw=; b=LtzmvPHI+CF69JE8RhGQ
	fWdAWeHAtdeaQu8Z4RokYFlIym8jN08Bkd1LCsNJU4L7+gSETdcdYYydvgVmR6BW
	KNBNB+5NrKKyce87/IBwyPHeNwOXk8UlhFO2OtsDStaoKFYmpoE4W/uv7OPzZUNP
	WtG1xba//EK4CTh6D0BXuTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=DtYfjRyg9pThtqBqN7QwMeCyUAZbdRmDvJQ7Frab8JNMk9
	vcUDroa25cZVxqkbp1+LQbIdEhwO/MDUEyxMuDmDLY0mr83CZ6WK6zW+YbcRA5zM
	vhIFl4Sd70M8sWDV4jeF3gXYsXIErd9dtlovVGsvncQdcRw77dgF7iZqd1jUQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F1704976;
	Tue, 30 Aug 2011 14:03:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3C974975; Tue, 30 Aug 2011
 14:03:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6776C29A-D332-11E0-B5F1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180427>

Thanks, both.
