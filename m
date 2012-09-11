From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] fix broken list iteration in clear_child_for_cleanup
Date: Tue, 11 Sep 2012 13:32:50 -0700
Message-ID: <7vzk4wfggd.fsf@alter.siamese.dyndns.org>
References: <1347373967-29248-1-git-send-email-david@optimisefitness.com>
 <1347394965-29906-1-git-send-email-david@optimisefitness.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, kusmabite@gmail.com
To: David Gould <david@optimisefitness.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 22:33:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBX8o-0005Xz-De
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 22:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab2IKUcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 16:32:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48993 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612Ab2IKUcx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 16:32:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E37397DE;
	Tue, 11 Sep 2012 16:32:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=EtjK2S
	ENpDNlnI8K8xEsc0h/iU+O9zznzUj5nDtuGuqB9KXh+4dlMUxpmodfzXcf6Gkvdp
	3IsL/BbsupziRdxQ8cx6rirqIBOazPtlkcWqLhoGs9yF0KTTD9GNo/cXsmVISSFS
	f0gCc3zTLCma/9RuDNTxPjrFfXhUZV1KQNtcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=piYnfgNeVdNpCW+nBxq0N5cL6pVqwOga
	WVFOxbj6VpoyyWpsaKZe3yaMvaHyLOD3lYH1UxtMa9CdSbTlau3qRs+1d8wMhMai
	IJvHYxWhla9OXWymJbjxgUNdwLRhkcDPligt5YbJDYpcIYHnTL+ybe+T5PtmS1e3
	DYMdqCFR0gw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7947A97DD;
	Tue, 11 Sep 2012 16:32:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0776197DB; Tue, 11 Sep 2012
 16:32:51 -0400 (EDT)
In-Reply-To: <1347394965-29906-1-git-send-email-david@optimisefitness.com>
 (David Gould's message of "Tue, 11 Sep 2012 21:22:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBF02EA8-FC4F-11E1-8209-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205266>

Thanks.
