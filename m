From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GC of alternate object store
Date: Fri, 31 Aug 2012 12:45:29 -0700
Message-ID: <7vr4qmn8va.fsf@alter.siamese.dyndns.org>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
 <loom.20120827T233125-780@post.gmane.org> <hbf.20120828vnfp@bombur.uio.no>
 <20120829074249.GA14408@ugly.local> <7v3935y9tw.fsf@alter.siamese.dyndns.org>
 <20120830095314.GA29038@troll08.europe.nokia.com>
 <7vbohstlih.fsf@alter.siamese.dyndns.org>
 <20120831162629.GA18215@troll08.europe.nokia.com>
 <CAPBPrnvrQx2SeyNM_nxnn7bB=Sakj6X=dbH2va+O-TnspY=Bpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Oswald Buddenhagen <ossi@kde.org>, git@vger.kernel.org
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 21:45:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7X9v-0003Oy-L6
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 21:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab2HaTpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 15:45:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791Ab2HaTpc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 15:45:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F092296B6;
	Fri, 31 Aug 2012 15:45:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YSdFsvHjqB5J73i7r9eEv2SysUo=; b=LEQ13U
	ffM7mfH4L+UuQ8UERa+MRJvw5tXGCMNjiHSb8QvSf4xGwktE4zje6AYlgY7AkGfw
	18jqzV9lgPfDsd4tmQgs5BpnaPYMVxeMZbQb1Gy/qooVqpV5rEUVNdmeZJF+2nyb
	+7jeRbng43meaO/iXu5Sezq2yYZTAxdLKuK1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LYN29kPF8bKFGcNwSO2ia3tnGq84iJzx
	T5ytuzlk8b2qitIL2NhBFtjsY2wCJXHIRQD0xovMiwH+lySczi7rrLD6ZNzSHb+6
	Jo7/dAlvRUDzK4IK8N/mj/MuE/7/REdcCY3zUiUxuDNvFmYnfDr+Hw5j7rD86gDg
	hnvMgtI04F4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAC8696B5;
	Fri, 31 Aug 2012 15:45:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BED496B3; Fri, 31 Aug 2012
 15:45:31 -0400 (EDT)
In-Reply-To: <CAPBPrnvrQx2SeyNM_nxnn7bB=Sakj6X=dbH2va+O-TnspY=Bpw@mail.gmail.com> (Dan
 Johnson's message of "Fri, 31 Aug 2012 15:18:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C3B5F96-F3A4-11E1-921B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204606>

Dan Johnson <computerdruid@gmail.com> writes:

> I believe that is bad interaction with "--all" (probably a bug). If I
> am remembering correctly, --no-tags is internally a per-remote
> setting, so I'm guessing it's not getting set on all remotes here.
>
> I'll look into this more a bit later tonight. Does fetch --no-tags
> work when you specify a remote?

Thanks.
