From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Wed, 21 Aug 2013 14:41:31 -0700
Message-ID: <xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 23:41:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCG9r-0002ep-Tw
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 23:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab3HUVlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 17:41:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624Ab3HUVlf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 17:41:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EEF93B6F2;
	Wed, 21 Aug 2013 21:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CAL3xpCLjxUVS/0XmdFscR1IWos=; b=rMf3Am
	i4Entq3N7Nxku8eOwswRz70edJ4aOnehPprWG3onSOZ6Gh8C5KDMREhvWxgM9ZNo
	i9LIrtuEG+GyD7N35QlO3C7YN53eP0JjLfFvc23lV88yFw6EyhJj6stMYz5I5+ed
	AeoVZ9+5QlI+JuL3/Ru6eoOwrzbqnqNHsd2sM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YeQqwwWpuu66/TJZc+8dZ/kUCxFQEIDp
	ht5P/U6MU63qLVxz1a5jeMA7CKOlgMFY8nc3cgTJHuCdIYecvCW5Dhc+AuvPL3e5
	pnsPM63Wnt/YRSbT8xMPSEJyHp8NtLW8RhDk+6TB9zkUZ8mDK4iwTPqE9oF78Lcr
	vGSw8zPJ7MM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52AAC3B6F1;
	Wed, 21 Aug 2013 21:41:34 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE7CB3B6EE;
	Wed, 21 Aug 2013 21:41:33 +0000 (UTC)
In-Reply-To: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	(Brian Gernhardt's message of "Wed, 21 Aug 2013 16:31:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 72CB0230-0AAA-11E3-A9DA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232738>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> With 2eac2a4: "ls-files -k: a directory only can be killed if the index has a non-directory" applied, t3010 fails test 3 "validate git ls-files -k output".  It ends up missing the pathx/ju/nk file.
>
> OS X 10.8.4
> Xcode 4.6.3
> clang "Apple LLVM version 4.2 (clang-425.0.28) (based on LLVM 3.2svn)" 

Very interesting, as it obviously does not reproduce for me.
