From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FW: question about merge in 1.7.10
Date: Fri, 24 Feb 2012 13:22:33 -0800
Message-ID: <7vbooox6xy.fsf@alter.siamese.dyndns.org>
References: <1F026B57884A5841B330471696849DE9114503D7@MBX021-W4-CA-5.exch021.domain.local> <4F47E51B.6080401@in.waw.pl> <1F026B57884A5841B330471696849DE9114508EC@MBX021-W4-CA-5.exch021.domain.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Marlene Cote <Marlene_Cote@affirmednetworks.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:22:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S12bB-00027z-G9
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 22:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758124Ab2BXVWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 16:22:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab2BXVWg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 16:22:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0343B70A4;
	Fri, 24 Feb 2012 16:22:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=55le9/Ku/VnSMq1s4MM5Kj303kQ=; b=ZxFaNp
	dSHGRYwzm6aFFvXYMYCf+hCmHd0Cmx3yltgf+HM4CjpjXocTdyG+bUuA/NsmFl7G
	6d0L31zXc1kvAQM61zh82PQi6P1+SugeWcSnAM82nzesItsC6nucqDdnJL17bWnv
	/4IROlTD6EsshQHGEQTMFs9A+5WqV/uT+y+sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dBddd0zeTCXb9EXhFOfoAYxPbtP/Oepn
	aALYrSA6d3CLshfbU2jOQ+8Tu2mDw8kaFcVtN/6UqTD2q+E3ww63LDjQHft5IUzv
	2+BLItORBdP8j4Kmj1IqUJCERH8XNClE2XQVc+rL9sxKQPMTWRFVc6yA62OxpjVJ
	66GfpYjya00=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED2EE70A3;
	Fri, 24 Feb 2012 16:22:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5ECB170A2; Fri, 24 Feb 2012
 16:22:35 -0500 (EST)
In-Reply-To: <1F026B57884A5841B330471696849DE9114508EC@MBX021-W4-CA-5.exch021.domain.local> (Marlene Cote's message of "Fri, 24 Feb 2012 19:33:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB8AD3C2-5F2D-11E1-8460-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191484>

Marlene Cote <Marlene_Cote@affirmednetworks.com> writes:

> I know that the tree will be dirty.  The change to git in 1.7.10 says
> that the merge will require a commit message when the command is run.

I do not think I ever said that.

	"merge" will always start an editor when it auto-commits

is what I said.

Could you point me where you read that "will require a commit message", so
that it can be corrected?
