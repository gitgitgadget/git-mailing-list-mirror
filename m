From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] submodules: Use relative paths to gitdir and work
 tree
Date: Tue, 06 Mar 2012 22:31:44 -0800
Message-ID: <7v8vjcq5v3.fsf@alter.siamese.dyndns.org>
References: <4F53DA95.2020402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 07 07:31:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5APg-0006Cp-8e
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 07:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992Ab2CGGbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 01:31:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41567 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab2CGGbr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 01:31:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5A11368B;
	Wed,  7 Mar 2012 01:31:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DPu6hZF8de7vK34DrKUTNoIBZ2M=; b=vYfe2U
	Vek0MMTTP4sLzPy8V0aDlld6M5BT0D59sNQiBSK4jzDz8/qlHMN1P54DiCsoK6BI
	TrEU9GMpQ+BiYtItpfA+8Olnc+mKkvB8TvM9j7u/JrfsCqgmBNabbEGO7uADyUl6
	xhsT6u9xcGqfAIg0viy8Iqh2dFtJRrJAweoEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CTCx8gMqvHu5hIhoX6DrIa72zfDCLwHK
	u/rX6N/5NB9bViESEaEkb/0poAR6REQZbi5x7OqO9bK7meMCeUNJSkpNVl2mm12z
	OfT0GjNlxFHWNEvdqc38ctu0A0hcGVtAPIpwK5OETJkWeaYssTUnClOAAx7EAz+q
	a/Gfo48Rdh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC908368A;
	Wed,  7 Mar 2012 01:31:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 471463686; Wed,  7 Mar 2012
 01:31:46 -0500 (EST)
In-Reply-To: <4F53DA95.2020402@web.de> (Jens Lehmann's message of "Sun, 04
 Mar 2012 22:11:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 365B2B56-681F-11E1-A4BE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192429>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> This is the third round of the former two patch series. It applies
> cleanly on current master and maint and IMO is maint stuff as it fixes
> bugs related to submodules. Those were introduced when moving the git
> directory into that of the superproject and using a gitfile instead.

I looked at this again and think this addresses the review comments
made during the previous round, but I would like to get "Yay" from
people who helped reviewing the previous round.

Thanks.
