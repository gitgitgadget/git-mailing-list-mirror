From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Make 'git help everyday' work
Date: Thu, 09 Jan 2014 15:49:52 -0800
Message-ID: <xmqqppo090m7.fsf@gitster.dls.corp.google.com>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jan 10 00:50:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1PMU-0005U6-PJ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 00:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbaAIXt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 18:49:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756602AbaAIXt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 18:49:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D3EE62321;
	Thu,  9 Jan 2014 18:49:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MWUp30wi30VUI9ig2PbLiM8fvXE=; b=n+Mgj5
	kYSW/FNPu//tWK8F0PQBcWNokKolCubDk9vkkECaNBmcQktB2xaIQQmJNyi0/Jzv
	GYv8o3guvMTWc74jxHboxGxgZKldyoVeUvyajuBEy74DNCNbgzK0i5PiXKQesEFG
	jSZo1SXpxiH2Bnnzpn3L5PBejV7QG6oVt7Lk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C75pCUgusp+Ij0/13L3qw5iSvjXMx7Lm
	SFGyLK45kpjl2WXQjj5Ot3XuYIkadGlIhAlCT2R7KPIUVdD4roTAa7LqmTRoDZoG
	cJNLc8uLrA/FEqTQnQlOcxi3UhTJ8AG5O0Ypdxcn+OrVbKGMhJO+nqvlOp6DpUfK
	KjTuaik4O8g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B8DE62320;
	Thu,  9 Jan 2014 18:49:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C2346231F;
	Thu,  9 Jan 2014 18:49:54 -0500 (EST)
In-Reply-To: <1389309192-5748-1-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Thu, 9 Jan 2014 23:13:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BCF3E7DA-7988-11E3-8CBB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240293>

I think we already use a nicer way to set up a page alias to keep
old links working than making a copy in Documentation/; please mimic
that if possible.

It may be overdue to refresh the suggested set of "top 20" commands,
as things have vastly changed over the past 8 years.  Perhaps we
should do that after reorganizing with something like this series.
