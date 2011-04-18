From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REGRESSION] git-wrapper to run-commands codepath regression
Date: Mon, 18 Apr 2011 15:10:10 -0700
Message-ID: <7vmxjn6wjh.fsf@alter.siamese.dyndns.org>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
 <20110418211102.GA13566@sigill.intra.peff.net>
 <20110418211849.GB13566@sigill.intra.peff.net>
 <7vvcyb6xww.fsf@alter.siamese.dyndns.org>
 <20110418214337.GB25104@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 19 00:10:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBweM-0006MH-27
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 00:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab1DRWKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 18:10:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab1DRWKY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 18:10:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 920C34DCA;
	Mon, 18 Apr 2011 18:12:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4nr7elrdc9uSFagzMU8SgM6hEKE=; b=e0JQt5
	S/wAfAe7cT20M9dMcZwE5ZHXi4eHCIjLnes08ITKDILHjwuThFL3hKql1SscOY24
	SKSo99L9F7+O8Sj34gijGKB92c5e7N2jUh96LbXyEo7YscyQuc6Gk4wcRDlkZCvV
	kNQjqBsWZpd4UZkm5YxQ21gxxVrs/zST9OhMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uG3JF0B1rD/cBwKrGsJna2fh1e1Sfe/z
	fkXaWCN2Ju1gZdQpgXii5e0puvEEhXC2tBIbu9R6ujxDJ9A4/jKE2WWla6zBAwu0
	guGYQ3+Z5u+mZxADu5S5p9H5tX0ebbYUxjdrIY0ZKf4TZzQkSnEaHTiiPR1qYt7s
	l6Q5QcY/N30=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5FA494DC7;
	Mon, 18 Apr 2011 18:12:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 56A434DC3; Mon, 18 Apr 2011
 18:12:13 -0400 (EDT)
In-Reply-To: <20110418214337.GB25104@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 18 Apr 2011 17:43:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC03D3D8-6A08-11E0-8A88-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171764>

Jeff King <peff@peff.net> writes:

> ..., but then again, it looked like a
> pretty innocuous patch in the first place, and held a pretty nasty and
> surprising bug. :)

Exactly.  It was quite embarrassing.
