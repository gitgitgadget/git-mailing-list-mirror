From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/9 v4] difftool: fix regression in '--prompt' options
Date: Thu, 22 Mar 2012 12:13:29 -0700
Message-ID: <7vsjh0wism.fsf@alter.siamese.dyndns.org>
References: <1332358560-13774-4-git-send-email-tim.henigan@gmail.com>
 <1332381236-16004-1-git-send-email-tim.henigan@gmail.com>
 <7viphxz37j.fsf@alter.siamese.dyndns.org> <871uoljbe9.fsf@thomas.inf.ethz.ch>
 <CAFouetjqzAwCe3mHkpJB4Xod4rJEF9OD77ch906TGUd9+-KZWA@mail.gmail.com>
 <7v3990zi5h.fsf@alter.siamese.dyndns.org>
 <CAFouetj+myKuUqw3-SwnbZ-=Sey29q9xYdaW4noHp_ebkmrk-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 20:13:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAnS5-00062e-Pk
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161Ab2CVTNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:13:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754067Ab2CVTNb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:13:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 167796907;
	Thu, 22 Mar 2012 15:13:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eN1vV19Sn8vXK3Qf2Pv3LFgccyY=; b=EKqz9Y
	xQwE7tzGHfhBnRrABJPehimpTnaRp6GybwSAnUnM7Ir4mw4gR4GwLipYdhzic5Xt
	FJWTDS7XhJDx9ceR5+NSo+l9ylOJb5xx5pM+MBLy8BrThqoaPC8uj2BHOoxtvDYl
	ACmSNnzqPDO7Zmh+sxjP+2UmcD0ep5NzxwuFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ieh7uzzobFBBHbp8uPqn066N5hWUVuS7
	nE3BcJzQjBgLKwa2tPyuLqzhhTKx5owMd3JX0vUK3qbBfS+GVpeY00BSTOgfdblI
	o2Fm3VJOdHRmUZgLAl7fvm8Lesp+wa7DU8mFNgghEQPzPYO/esOvixv8DofAtQVV
	vScc0xoxO1g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D7A66906;
	Thu, 22 Mar 2012 15:13:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 963A16905; Thu, 22 Mar 2012
 15:13:30 -0400 (EDT)
In-Reply-To: <CAFouetj+myKuUqw3-SwnbZ-=Sey29q9xYdaW4noHp_ebkmrk-A@mail.gmail.com> (Tim
 Henigan's message of "Thu, 22 Mar 2012 15:01:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C73BF7E-7453-11E1-AD40-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193692>

Tim Henigan <tim.henigan@gmail.com> writes:

> I will resend the entire patch series (will be v6) when this is done.
>
> Does this sound like a good plan?

Absolutely.  Thanks for everything.
