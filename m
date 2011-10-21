From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Breakage in master since 6d4bb3833c
Date: Fri, 21 Oct 2011 10:01:14 -0700
Message-ID: <7vehy68ejp.fsf@alter.siamese.dyndns.org>
References: <4EA1614D.3090202@alum.mit.edu> <20111021122801.GA3799@goldbirke>
 <4EA17B1D.9000900@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Oct 21 19:01:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHITB-00036g-Et
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 19:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab1JURBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 13:01:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361Ab1JURBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 13:01:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A9145D90;
	Fri, 21 Oct 2011 13:01:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qx6qbeH82Ppr4/JMocv06nppGz4=; b=P7y4AH
	yFDFbHubqFT830pW7iCkJNBCkswJ8ltvIInCIR/kcN5Ae6wtNEq7wUoOEmuoHUVf
	4opNUymCHzVb7jqg2Ctb5yJCOIOYtOoiFH3gzZHUhBoG3e+x77BawqbZPtkEjmJu
	/VOEVIc9GarMJ6kuRZWYj6RGMEpo9jYknS4DY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XM1PfUicPW0qN8XzuOnlHd7poSBCtOkD
	PHbIwOQdB/aAHK1fPXuG05Gsrr3rEIXxd0MahCsjs80//ObqMPuN+t9Cdp8oJU97
	0R+igY1nQFV20ZlhCiBAJHwxtvWZwwKJ2YuKs4hTo8lEPY14EEauIMOqdj70JUBN
	SQ8M0GDsug8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72EBF5D8F;
	Fri, 21 Oct 2011 13:01:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9D8C5D8E; Fri, 21 Oct 2011
 13:01:15 -0400 (EDT)
In-Reply-To: <4EA17B1D.9000900@alum.mit.edu> (Michael Haggerty's message of
 "Fri, 21 Oct 2011 16:01:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49D30AA8-FC06-11E0-B3D2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184068>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Yes, you are right.  Setting GIT=$(pwd)/bin-wrappers/git fixes the problem.

So in short, this was a false alarm crying wolf, and there was no problem?
