From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "remote-tracking branch"?
Date: Mon, 11 Jun 2012 09:46:06 -0700
Message-ID: <7vipex7q5t.fsf@alter.siamese.dyndns.org>
References: <4FD6068D.1010509@xiplink.com>
 <7vr4tl7qu3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 18:46:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se7kt-0001gP-S3
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 18:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab2FKQqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 12:46:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754176Ab2FKQqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 12:46:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DA7A88AA;
	Mon, 11 Jun 2012 12:46:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iTk81SE3Cip9O1kBbf/XkX6/bAQ=; b=iiywsi
	4AaX8eMYfMclooeqKiq4n04URcS+pFy9Z7xHZiH2pU+iH/5Qi+jMh4zTeoE/oVvZ
	FE17/srJkH2bJlkyqIdAkbGwKKB1BJ+kr+uS1ORTefJyltBvkeOVf/DGADnGrz9H
	8IDUEMykarGBKuWgeAcZZICS0K009mdVPEkQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nKKh2UdK7E8AtEsCUCqlPM/fjgApEMsk
	qMMUOW0/JhzQtt3hEme96S+ejVCaPXF6T+g5ABpk7aopZO6UPT0Y5TpaPucsxMIE
	2HmlduMAXb4xAgxPTEP+XxkIL+/EOqZvkdQ6TvLCZK+Dm1UFoz5QBK2y1QL2crv8
	e0YcHjVfTso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6208588A9;
	Mon, 11 Jun 2012 12:46:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D900F88A6; Mon, 11 Jun 2012
 12:46:07 -0400 (EDT)
In-Reply-To: <7vr4tl7qu3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 11 Jun 2012 09:31:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F13C3828-B3E4-11E1-AF4F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199674>

Junio C Hamano <gitster@pobox.com> writes:

> Unfortunately, no concensus terminology for them exist; I find
> myself calling them "the branch you integrate with upstream's
> master", "the branch you forked from origin's topic", etc.

Actually, I take that "no concensus exists" back.  "upstream" is
probably the closest to the consensus terminology, and that is why
"git log master@{upstream}" will give you the history of the remote
tracking branch you use to integrate with master.
