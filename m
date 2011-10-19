From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t3000-ls-files-others.sh: use $SHELL_PATH to run
 git-new-workdir script
Date: Wed, 19 Oct 2011 10:31:33 -0700
Message-ID: <7vmxcwdh1m.fsf@alter.siamese.dyndns.org>
References: <jKc1nei6yQLMU5upFxa60klqkQwEDsUHt5jcsbbnbL-TuvERAV3NOSvVH9yzlpgnPdDi0-5rPkBeDx7SQF7CEqlyj9UX6NqKccGu9kUyq1SFu2oCzI2xkRSoDmDBH66WbRZaTWHtj8ubURHpkyEvMA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Oct 19 19:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGZzQ-0006qy-Eh
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 19:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757132Ab1JSRbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 13:31:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755300Ab1JSRbg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 13:31:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D05EB4EF1;
	Wed, 19 Oct 2011 13:31:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=tUl77R
	fMwI3ooo8b/FTBn2O4f24jZ10Q1R8gfYU7xsu3rF6scH2mb2Fh3sAqo8RCVNnMrl
	iun/CWONz6+RzmFA6V2lrrBuedy1zprfNCWJC/gK2jKVrDAv/psEuSKr9YKrC71x
	sMYFklAxDHlUALO7eam9Xz1Ppi0WY59oo2byQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xHNyx3HkCmQytCajI4q42jzl+LUSf709
	o/IxzZZ1lNw+8/GQDUY+un3RtrTRCicH7FN4C5Vdl14vlTzGIIF5tAO0uxXUC4uq
	XqD49wP6yooNYqHrL47vSGXeYo/5x55PfHLWTrBMDMF5ATzlgyhsZaXkGJZQ//Ai
	yRVXhDYzvbQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C61564EEE;
	Wed, 19 Oct 2011 13:31:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5ED974EEC; Wed, 19 Oct 2011
 13:31:35 -0400 (EDT)
In-Reply-To: <jKc1nei6yQLMU5upFxa60klqkQwEDsUHt5jcsbbnbL-TuvERAV3NOSvVH9yzlpgnPdDi0-5rPkBeDx7SQF7CEqlyj9UX6NqKccGu9kUyq1SFu2oCzI2xkRSoDmDBH66WbRZaTWHtj8ubURHpkyEvMA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed, 19 Oct 2011 09:26:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3176AF62-FA78-11E0-A4DD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183938>

Thanks.
