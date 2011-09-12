From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 15:02:38 -0700
Message-ID: <7vd3f52wd5.fsf@alter.siamese.dyndns.org>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:07:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3FbH-0007BS-Qw
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723Ab1ILXH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:07:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755637Ab1ILXHV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:07:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE09D4A99;
	Mon, 12 Sep 2011 19:07:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=K0aUGz7odl8d/LhtaVBsgUToj80=; b=PYzS+K34QuFS36ME5efX
	fHF9axW4zbuKFVYOTbEyEimS4J7vDBgx/zlI6SuQmaJhUCcm/tBkSX9fK4VRPepk
	3kbKl2wRIkxhvdZag16a6/aSz2n/jCTpm9SJS70OKlJ4xvdHHN6tcGPkiew0GLw5
	bM97pKgSV3KWi3xhB/1nhZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=gqo7hzH/UTmeSth8dyTrmtOS2SLZgv+45T43xspEKlszXa
	YrzKLfIEZv540h34nWuf3Ti7VF5TO9MGW5k+dmy5znL0S3CKI6o5/vO3l8Qz1GMR
	A6FyhNQzg9K4ICaiqI7D4VYVs08jY5Lofu+vFX8Tp2gcLWXax/a2UzwodNaZI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5D464A98;
	Mon, 12 Sep 2011 19:07:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 380384A97; Mon, 12 Sep 2011
 19:07:20 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7709D88-DD93-11E0-BC5B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181250>

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * sr/transport-helper-fix-rfc (2011-07-19) 2 commits
>  - t5800: point out that deleting branches does not work
>  - t5800: document inability to push new branch with old content

I vaguely recall that one of my unrelated topics fixed the issue you were
trying to work around with this topic, or something? Can we see a re-roll
after 1.7.7 ships?

Thanks.
