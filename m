From: Junio C Hamano <gitster@pobox.com>
Subject: Update git-gui tree please?
Date: Tue, 22 Mar 2011 22:46:17 -0700
Message-ID: <7vlj06gziu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 06:46:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Gtt-0005bG-9A
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 06:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883Ab1CWFq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 01:46:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364Ab1CWFq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 01:46:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3306A23A5;
	Wed, 23 Mar 2011 01:48:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=D
	NqQZZYPN3sdim54S3cDy+MLG2U=; b=NnX6q+7reY+MRfO09RDM2KnjeJQJE6G1p
	va8cxP0DFIleXvJBDbd6sMCINkeJIbuHh52T58ij+dIDYO5qPImo5NOSmcXydXfU
	6xSvlkyugm/ifKNlyAuaq2Os+f8rv+ugToio97XwdbGANBVEosi09uQdVsw4GYP+
	rYqfAhQUmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=c92iinxd+KUPBw1UnVmVuejJnOkabs6RCff6TfySd5n626DgP8p1ABY5
	sBtI6MCqNcgkCBd5npKkPBgJvsgv1igX6UEymO5KLRCwVbc5noJcxtUKL6aJLmHN
	HPVWNV4kI+zpRpeaNjcJqDapxCxmpdrnrillQW1tBskm/UDeixQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 003C123A2;
	Wed, 23 Mar 2011 01:48:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CBD2B23A0; Wed, 23 Mar 2011
 01:47:58 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E1DD7E0-5511-11E0-A5A9-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169800>

As Sebastian's addition of BeyondCompare-3 as a new backend for mergetool
has graduated to my 'master' branch, could you fetch from me and merge the
tip of ss/git-gui-mergetool branch to git-gui repository, like this?

	git fetch git://git.kernel.org/pub/scm/git/git.git next
	git branch ss/git-gui-mergetool f3768a6714e667205d68475
        git merge ss/git-gui-mergetool

Also I'll hopefully tagging 1.7.5-rc0 by the end of the month or the
middle of April at the latest, so please start planning to wrap up the
enhancements and fixes meant for the next release and throw me a pull
request when your tree is in a good shape to do so.  I realize that I am
already behind your tip 4c2519e (git-gui: fetch/prune all entry appears
last, 2011-02-22), but I'll wait until I hear from you.

Thanks.
