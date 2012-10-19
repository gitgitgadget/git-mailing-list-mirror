From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix potential hang in https handshake.
Date: Fri, 19 Oct 2012 14:49:04 -0700
Message-ID: <7vehkui14f.fsf@alter.siamese.dyndns.org>
References: <5081c896.cMdU6VySSwFm0uOa%szager@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, daniel@haxx.se, sop@google.com, peff@peff.net
To: szager@google.com
X-From: git-owner@vger.kernel.org Fri Oct 19 23:49:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPKRX-0008Vd-Dq
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 23:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933038Ab2JSVtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 17:49:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932148Ab2JSVtH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 17:49:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BE069DE0;
	Fri, 19 Oct 2012 17:49:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=gbKk53
	WPGEB5Mx7zgoxJihtNW8o8h4Vv1YaQkrpk792ffqQm2rCll3sdgdcwO73/e961OV
	7mbfBOkqYUZkaN6ODnyyBSoNZv1KhgAYMOwgwQF0/IZpJ7MvMT2x6V9NBxyjY7pA
	sowLReKGRCe53moswHY4BiQCWAyaKNX8gvafM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D3hQlLreSCh2N1jHrhpWV8z/Xaed3RdO
	wQfh+tv9IpoqCCwHUR8gusc3boFq6OXfFQvVwJzjMhHTchcoSw1YImbSUv2YqMhP
	K3qqclX6R5m2ueeEl7WjIc4AStlMcKJStBX0iEhyq4AjgbftjqbRbGWVsqlLZRVg
	Y1VXG7VnzaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECB989DDF;
	Fri, 19 Oct 2012 17:49:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64FC79DDE; Fri, 19 Oct 2012
 17:49:06 -0400 (EDT)
In-Reply-To: <5081c896.cMdU6VySSwFm0uOa%szager@google.com>
 (szager@google.com's message of "Fri, 19 Oct 2012 14:39:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE2E2612-1A36-11E2-B647-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208070>

Thanks.
