From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 15:58:51 -0700
Message-ID: <7v1uvl2wd1.fsf@alter.siamese.dyndns.org>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:07:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3FbI-0007BS-Av
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744Ab1ILXH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:07:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755687Ab1ILXHY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:07:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C76A4AA2;
	Mon, 12 Sep 2011 19:07:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=PcOV4rYvDLhaE2YENgOzmmjVs+k=; b=g9JtQoP8OpnDRqJz90e+
	MdiJxKoZOZnTyW10tCGe5Tbfygkqv+jC4RtUMkmBzNG0FXv2P+hOBLw9ejisDb71
	deeWqnh9aZJQ/FFyG8eXx6jtmsi4kBnXNeOMOlMkzH8NW/kKL+cNJ+iJrFgniLeA
	1CNbHyq31MowZ4wa5pmwhIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=wL/x5O3bdUj9f5X/FhE5JPvMV3Cx42sXVljGAmC2+XgvQC
	h/IR0HnaKFJPSuKv9utmGYZKLatomLrU3cfv3gK7UoPkiKZHfZkeg5CepHqboIGj
	LzPjQid1OutEw4VULDmv/BOb6fI8GAFcKNe7Z8aTHCQ5PbSmwwVFrAbdVJd7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54DBC4AA0;
	Mon, 12 Sep 2011 19:07:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF9CA4A9F; Mon, 12 Sep 2011
 19:07:23 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9A33AF2-DD93-11E0-82EF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181251>

Junio C Hamano <gitster@pobox.com> writes:

> * rj/maint-t9159-svn-rev-notation (2011-09-11) 1 commit
>  - t9159-*.sh: Add an svn version check

Ack/Nack from people involved in git-svn and/or the patch, please?
