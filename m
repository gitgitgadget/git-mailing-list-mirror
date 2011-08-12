From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] rev-parse: add option --is-well-formed-git-dir
 [path]
Date: Fri, 12 Aug 2011 13:57:27 -0700
Message-ID: <7vipq2mjpk.fsf@alter.siamese.dyndns.org>
References: <1313178913-25617-1-git-send-email-iveqy@iveqy.com>
 <1313178913-25617-2-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 22:57:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrynP-0004Zz-KT
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 22:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164Ab1HLU5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 16:57:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51050 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364Ab1HLU5a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 16:57:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9668B3315;
	Fri, 12 Aug 2011 16:57:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zo/gBMTUOFs2uc/JBWEd7EtgcF8=; b=ld0j93
	QRtSPzzf+RC0ynWHF2m3o/VAC6Jpv+jBRuwrLVwtkxsNBkqEBJb4qyjSZaLqxh5/
	UoKfAWnjD0jZ6GVX1RP+ssUwxkwIduDIia/M8BNlN5OBsPYCfJuDPIxTOiUCkZa8
	pdDCpfUYHq03yZkfzqrlmp6RA4gld8zP8EWdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VVHnHjY6qbDdunw8nDrDgqF0yHePJr3B
	e79v/XR3Pg5mUPWQ2/4La0KGTa6qjHqcqpeSOHKH0GqHpACKC/FUbumu9JkPhb7q
	LTKccpPO4cah9NTstHkSRjqOmEv8sViHhY9kJp4OIRCyd866XgLlU+RRbkhkB1we
	QmXbyph2aMg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E14E3314;
	Fri, 12 Aug 2011 16:57:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2650A3313; Fri, 12 Aug 2011
 16:57:29 -0400 (EDT)
In-Reply-To: <1313178913-25617-2-git-send-email-iveqy@iveqy.com> (Fredrik
 Gustafsson's message of "Fri, 12 Aug 2011 21:55:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0CB2122-C525-11E0-B789-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179247>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> Check if [path] is a valid git-dir or a valid git-file that points
> to a valid git-dir.

On Subject, here, and in the doc, I do not think you meant "[path]" (which
typically means "you do not have to have anything, but you are allowed to
have a path, if you do write something here."). Perhaps you meant to say
<path> instead (which is how most if not all of the documentation mark a
placeholder in a description)?
