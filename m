From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule deinit: require '--all' instead of '.' for all submodules
Date: Tue, 03 May 2016 15:25:39 -0700
Message-ID: <xmqq37pylqxo.fsf@gitster.mtv.corp.google.com>
References: <1462313499-6760-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com,
	cederp@opera.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 00:25:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axilH-0004xS-HK
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 00:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822AbcECWZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 18:25:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64183 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756574AbcECWZn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 18:25:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CF4519E3B;
	Tue,  3 May 2016 18:25:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=okYi4zjEMpvXWb0nVhqrwDD6VRI=; b=Pewafo
	gNJnVFt6YfsmFocgLRq91z8vbV8FPsaRHVplf3BvP08lxAua2h8OpoLGxRXPkTGz
	+OmSM8+TeT5T8Rvs1J0ZIhxvefWw2DZDqY0gl1DznxJsUcpyZMUHb3VnDFHO5Kud
	OewBuiRheHYrt5jDRdnMDNTCllHMK53j6pGjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uIoufHKZASVJGHGU+AtnjXWS/mh5YBlB
	7XXwhUyA0pCCYPboZdNlI1WcC1IwsyCZmlF6gbPe/lvm+tYN8cQuFpTVmcFo/tx6
	AaLOsldk1f503cPjNMC9Jo1xIHTIXYrWZEl+HLQ15iHoRqqcH9ZmwuVOrD8G3t7h
	W32HeZQxmE8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 14EDE19E3A;
	Tue,  3 May 2016 18:25:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7495719E39;
	Tue,  3 May 2016 18:25:41 -0400 (EDT)
In-Reply-To: <1462313499-6760-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 3 May 2016 15:11:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F8401FC2-117D-11E6-8B4B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293468>

Stefan Beller <sbeller@google.com> writes:

> ...
> So instead of a path spec add a parameter '--all' to deinit all submodules
> and add a test to check for the corner case of an empty repository.
>
> There is no need to update the documentation as it did not describe the
> special case '.' to remove all submodules.

Now there is, isn't it?
