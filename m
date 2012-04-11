From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (bugfix)] gitweb: Fix unintended "--no-merges" for
 regular Atom feed
Date: Wed, 11 Apr 2012 09:48:48 -0700
Message-ID: <7vd37emcy7.fsf@alter.siamese.dyndns.org>
References: <4F79D76D.80805@pipping.org>
 <7v62df9yo5.fsf@alter.siamese.dyndns.org>
 <201204042058.32549.jnareb@gmail.com> <201204111739.07765.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Pipping <sebastian@pipping.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:48:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0j1-0003Ds-SQ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760682Ab2DKQsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 12:48:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760593Ab2DKQsu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:48:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2848064DA;
	Wed, 11 Apr 2012 12:48:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XZwCvK6AXzgONctCMWl3nnpuNus=; b=VsNslL
	KcUsrGFVlnHIjQs9SnmGd8S944EV2Vxe8fdd3tUG1DquLkIvFHHHA240AdHL7KAH
	0KQadZKi8ykONx7lFJz/rrYYXqbe0u/WiGz09QlhWwN8We39YzYZdmh27kVh15Kt
	kE+wq0Kk/6U5vNGVn6lrJjkGcyPATnKIdj2UE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YZ6yo3rGlB7/VX3GEyvdrDd9Gr3E1wDr
	eGmrnKCMpAwBD8exP9XdQnrBRpf3OTT1sSbo2uyngYn/P64uZ6UZjBEcdop81qFY
	ysbcB+eEPQNWgFXZtnKcO9ETSetIoECHyu5DB13dgDLAYuiRY6RNboj0Xa3Qxegf
	uCn6h9NEAHI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FC1B64D9;
	Wed, 11 Apr 2012 12:48:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD6B964D8; Wed, 11 Apr 2012
 12:48:49 -0400 (EDT)
In-Reply-To: <201204111739.07765.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 11 Apr 2012 17:39:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 367D6C8C-83F6-11E1-8481-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195213>

Jakub Narebski <jnareb@gmail.com> writes:

>> So 1.7.10.1 it is...
>
> Ping!

You are part of my distributed memory and the system is nicely
working ;-)

> I don't see this trivial fix (admittedly for obscure bug) in "What's
> cooking", and it is not present in 'master'.

Of course not.  Now you reminded me, it will.

Thanks.
