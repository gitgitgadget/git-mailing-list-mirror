From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit -S documentation
Date: Tue, 08 May 2012 16:49:23 -0700
Message-ID: <7v1umuutbw.fsf@alter.siamese.dyndns.org>
References: <48CBB45F-BF3B-470D-B80B-D0CD788E0081@planquart.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geoffroy PLANQUART <geoffroy@planquart.fr>
X-From: git-owner@vger.kernel.org Wed May 09 01:49:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRu9r-0007at-IJ
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 01:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461Ab2EHXt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 19:49:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37547 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774Ab2EHXtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 19:49:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D27F48185;
	Tue,  8 May 2012 19:49:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P9SXXTGw/j1VzJemHgxxTpXdcew=; b=AIC/kT
	NSC+Bf2R663+J0Eoyuyw1waD58bXOKjdA2bP636ogDsGh/0DVEZUHvhRwCmvh45a
	XPBzPibBav6baq40ohTJXEhPT+eDGpT+nLisYi392AMrBTqsY/jlMwOBg6+5iQC2
	oRXgGbOd7ItzbBn6VKfMulZsJsqFNytys7Z0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X9stvFQ5r1Nx4AXlA8hVKMRAPTu0rLDg
	Vv1BF0x0PJmKhnOrNbJKyNxtVpxzfhapq6SAkTjdFrDdOJXMamoPmm0Y+BkDgFM6
	6+4E7Z1R5qNtRwbwMIr7xTQcxlLLXYjrSnPTee6l7ZtC0SzAEqL0Ouw4iAiglzLn
	u9vtaLMm1u0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB2268184;
	Tue,  8 May 2012 19:49:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60CD28183; Tue,  8 May 2012
 19:49:24 -0400 (EDT)
In-Reply-To: <48CBB45F-BF3B-470D-B80B-D0CD788E0081@planquart.fr> (Geoffroy
 PLANQUART's message of "Wed, 9 May 2012 00:12:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 70B026BA-9968-11E1-BCA3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197430>

Geoffroy PLANQUART <geoffroy@planquart.fr> writes:

> I recently discovered the git commit -S option, but I can't find any
> documentation about it.

It was done as a bonus checkbox feature while the more important "merge
signed tag" feature was implemented, as the changes needed for the latter
had to touch codepaths that needed to be touched to implement the former,
so I am not surprised if it is underdocumented ;-)

Output from "git log ^4a3a1ed 5de89d3a", especially the log message for
ba3c69a (commit: teach --gpg-sign option, 2011-10-05), would be a good
place to start writing new materials to add to the documentation, but at
the end-user level the only two options that matter would be --gpg-sign
given to "git commit", and "--show-signature" given to "git log" family of
commands.

Thanks.
