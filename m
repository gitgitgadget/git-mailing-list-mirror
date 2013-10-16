From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc: remove gc.pid file at end of execution
Date: Wed, 16 Oct 2013 14:38:54 -0700
Message-ID: <xmqqeh7k6glt.fsf@gitster.dls.corp.google.com>
References: <1380187098-8519-1-git-send-email-Matthieu.Moy@imag.fr>
	<20130928003319.GR9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	pclouds@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 23:39:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWYo2-00086k-2F
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 23:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494Ab3JPVi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 17:38:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755248Ab3JPVi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 17:38:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB3AA4BDA9;
	Wed, 16 Oct 2013 21:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=VSuXb6TOOYvRdd4SmCTnwgW0mnw=; b=Tth7Gky/0Jyeoj++pHpj
	orT+zx1QyZW4FJos0B+uBPh+HpZYZn5Kf3u8w/Uf6Si+O2fWIJ3OsmKdl5e0kAoO
	/TGMJ/9PVD4XUgGgmet0C3pDiOJQhoRjy/Guj53F+G2ROPQoS0+4pxLaRK1/U3RH
	Ded+ZVzW5nDXHCL0K0IgQlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=g3ZdeMCPd/rJ0tQiNrlUddNm431vm2EhYGkBDITjBVRy56
	t0r+VZuOfD0yC6Sl21/HTyKpIJu4AcrgsBmMQGxFhq79U/UtaRLb072Le0PnM6wy
	3/8bZ8oUscaDe2kD66m49SzaMEfur8SdZP+6uwUePh/qFI0KDbWKMmMwMgID4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E40C4BDA7;
	Wed, 16 Oct 2013 21:38:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0F6C4BD9F;
	Wed, 16 Oct 2013 21:38:55 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5BE0787A-36AB-11E3-8EC7-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236267>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> This file isn't really harmful, but isn't useful either, and can create
>> minor annoyance for the user:
>
> Would something like the following make sense, to ensure the gc.pid file is
> always removed on normal exit?

Has anything further happened to this discussion?
