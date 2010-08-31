From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] merge: Make '--log' an integer option for number of
 shortlog entries
Date: Tue, 31 Aug 2010 12:53:37 -0700
Message-ID: <7vfwxua79a.fsf@alter.siamese.dyndns.org>
References: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
 <1283226800-28980-1-git-send-email-artagnon@gmail.com>
 <20100831143236.GC2315@burratino> <7vzkw2abpz.fsf@alter.siamese.dyndns.org>
 <20100831191324.GA27381@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 21:53:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWu0-0001TM-Id
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376Ab0HaTxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 15:53:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158Ab0HaTxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 15:53:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32B81D2F99;
	Tue, 31 Aug 2010 15:53:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XLDYgyR9uqVNMKA0o00K1db9kjM=; b=s8UA9y
	TzheLTAVIubGw9+aCqQHS3iuJbPw7scl++IXZo5WtN6Snu0oXw+2GyVJdv+ciVIY
	Q/HcJJNQFfoY3n/eZVvWHiq1Olc3uO66cZLem5QvDQuHI1wAlMiSIIhheq+dE3Cs
	YetfivVoRwSH5p/JG4wgHZMcGLvrAAboO5MW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UsRdF3Tv8As1DcZta/mg4QCTyzD7x+WR
	E1zqS8IJHnV4YVPlVdZGON8/L3c1yr9G8wK0L+3CCuZTmmzC4sIK8tnvclCbREbS
	xzLLAi/iYQwd8JVVCRhzxMGxKimlV6L3Rp4vFsbiRztYf7eN8xaqM6NpQUyHF6z5
	v7WHt/xFSVw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F2890D2F95;
	Tue, 31 Aug 2010 15:53:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3558AD2F94; Tue, 31 Aug
 2010 15:53:39 -0400 (EDT)
In-Reply-To: <20100831191324.GA27381@kytes> (Ramkumar Ramachandra's message
 of "Wed\, 1 Sep 2010 00\:43\:37 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75459198-B539-11DF-BE20-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154979>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> It's a little asymmetric- the program won't error out when 'merge.log'
> is set to -1.

And what is the reason you do not want to diagnose that as an error?
