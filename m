From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsimport: strip question-mark characters in tags
Date: Wed, 14 Apr 2010 12:27:43 -0700
Message-ID: <7v1vehrg0g.fsf@alter.siamese.dyndns.org>
References: <20100414133831.GA12135@f.santiago.vpn.redhat.com>
 <7vfx2yqf9s.fsf@alter.siamese.dyndns.org>
 <20100414154409.GA28268@f.santiago.vpn.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ed Santiago <santiago@redhat.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 21:28:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O28Fi-0005Ng-2d
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 21:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796Ab0DNT1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 15:27:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab0DNT1w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 15:27:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 11745AB5A6;
	Wed, 14 Apr 2010 15:27:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dTcj8Nqjr+hHV/TkVEIrhUqYaAg=; b=XTS0+C
	TW/+g3PO9DYlact6+n0T+cDQhczfCYyfurCjACru9QrS4ve/v1W/2NSOuYIznXce
	2ShApKkT89uNwZLsFWbIJSRf8pCBehfrifSmezLUyq9z6YvkQpbZwQySxf5d9dF2
	SCy2JyTmb4EZd6l2nwOmM2qjEkbj9q7c/oy9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DxZkTXlZ6VzRzsGPUQm8Lw87pZLOaXW4
	sb/ZMAtx3z0BdTQlqonPd3LhBezBiALZHfVDDYg3b0MDzV17GUA6WLbuxnE73nYY
	/pK4n3vV4NCW/MM/RrmVBpsSLryb5SVr9ai7PBLsMSDePij2kjSL2j/cP33j4pU8
	MfwzK5jIAX8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E3057AB5A4;
	Wed, 14 Apr 2010 15:27:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B33EAB5A0; Wed, 14 Apr
 2010 15:27:45 -0400 (EDT)
In-Reply-To: <20100414154409.GA28268@f.santiago.vpn.redhat.com> (Ed
 Santiago's message of "Wed\, 14 Apr 2010 09\:44\:10 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CEF63248-47FB-11DF-A941-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144895>

Ed Santiago <santiago@redhat.com> writes:

> On Wed, Apr 14, 2010 at 07:29:03AM -0700, Junio C Hamano wrote:
>> 
>> I agree that people may want to optionally replace them to avoid mapping
>> two originally different tags into the same one.
>
> I considered that but decided that it was beyond the scope of
> what I wanted to tackle.

Oh, one step at a time is perfectly fine.
