From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-svn: clarify the referent of dcommit's optional
 argument
Date: Wed, 16 May 2012 15:49:24 -0700
Message-ID: <7vzk97bv2j.fsf@alter.siamese.dyndns.org>
References: <1337200956-9260-1-git-send-email-jon.seymour@gmail.com>
 <CAH3AnrqQDfx7s1fXBgKJmFtMA33CW9qx2tWSoenqSR0pVc63WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, normalperson@yhbt.net, trast@student.ethz.ch
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 00:49:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUn2Q-000285-5t
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 00:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137Ab2EPWtl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 18:49:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36806 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760712Ab2EPWtk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 May 2012 18:49:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FA4488A3;
	Wed, 16 May 2012 18:49:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ip5UcLmR/1Tl
	3sXN6TzAsO2FBGM=; b=neyCjwTH6FRvrvV2YQkWmR87cBO/gGiTyqXpe+sVtF+C
	3aG3SX+Lwx2KB16imMRrCW3hbGdaG35fCARKzjno+UHkN897tu2rC+v1QP6vcjW5
	ENT7lp/BzrCEjDW8cCPf8Gn1GMQFPOYt3nhcHiDpHfyXFOZrdJmLbiV+v9lKFfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kNAJW0
	WS5e+BvwmWS9/X4J6hw6O5LWno+qhl81MgIbY9QNo/7tZdvxMvZm5m8TgBavAOQM
	3w9pePffIJNKiMSp46UJPESsVXC/4suzEzF251iTQjdj8Krb7L0fdWChoSw01FaX
	ctQnMOU9XJ2myU+vU/NBn8pULHP9sFPWqSGA4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3934088A2;
	Wed, 16 May 2012 18:49:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2688889A; Wed, 16 May 2012
 18:49:38 -0400 (EDT)
In-Reply-To: <CAH3AnrqQDfx7s1fXBgKJmFtMA33CW9qx2tWSoenqSR0pVc63WQ@mail.gmail.com> (Jon
 Seymour's message of "Thu, 17 May 2012 06:45:39 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AC57416-9FA9-11E1-8ED3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197904>

Jon Seymour <jon.seymour@gmail.com> writes:

>> +Originally, 'git svn' recommended that developers pulled or merged =
from
>> +the 'git svn' branch. =C2=A0This was because the author favored `gi=
t svn set-tree B`
>> +to commit a single head rather than the `git svn set-tree A..B` not=
ation to
>> +commit multiple commits. Use of 'git pull' or 'git merge' with `git=
 svn set-tree A...B`
>
> A...B -> A..B
>
> Will fix in next iteration, assuming Junio and Eric are otherwise
> happy with the update.

I don't have an opinion on the latter half of the patch that is primari=
ly
about the rationale given by "the author", i.e. Eric ;-), but the
description of dcommit subcommand itself certainly looks simpler and mo=
re
readble to me.

Thanks.
