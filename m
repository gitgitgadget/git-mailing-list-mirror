From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t7800: don't hide grep output
Date: Fri, 22 Mar 2013 15:45:03 -0700
Message-ID: <7vd2ur5a1c.fsf@alter.siamese.dyndns.org>
References: <20130322115352.GI2283@serenity.lan>
 <cover.1363980749.git.john@keeping.me.uk>
 <cover.1363980749.git.john@keeping.me.uk>
 <4cbe25e4b1fd7a8d45067106d24f7d83ca5c8e5b.1363980749.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Mar 22 23:45:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJAiP-0007TM-Nk
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 23:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423474Ab3CVWpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 18:45:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47838 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423438Ab3CVWpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 18:45:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26D5FA291;
	Fri, 22 Mar 2013 18:45:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uy+pGWHe8OqQDDpvklsbbv4dPl0=; b=eDB/UJ
	XyDohO9IceyOY48JMVTSOfKV1pF4VqQE7P+TckcxrWreDADsAOXRyTTzO0a4//Rj
	FmXHd2Q+Qk4oWxRCUNNTY2z5pwlAtBh4jvn9n/NdiepwDOb4PKg40dx/GwIdbJXV
	AhZAcky9rlweyhpmKxahR5cCBpUVPU0agzq/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rLiS7T0eQw31YA4NGC/wPyS/f0vw+zz3
	eDSRlj8LH2FbW0MvosWCQYN1a25efNmToyVzBpqjiSJ5rEeDjAgY9Rj3qrNoud0W
	ikTJBy5Q0qfxUHGrH3NZ6IKA7WS+QZIc1W7okty1RKTE2SgXh/4OwzhjtRjbzGK/
	PJX4GCOrv4c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B77EA28F;
	Fri, 22 Mar 2013 18:45:05 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EC65A28B; Fri, 22 Mar 2013
 18:45:04 -0400 (EDT)
In-Reply-To: <4cbe25e4b1fd7a8d45067106d24f7d83ca5c8e5b.1363980749.git.john@keeping.me.uk>
 (John Keeping's message of "Fri, 22 Mar 2013 19:36:31 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 236ED26E-9342-11E2-9A3C-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218862>

Looks good from a cursory read.  Thanks.
