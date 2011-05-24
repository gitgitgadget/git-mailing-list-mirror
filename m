From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix usage of git-init and git-init-db documentation
Date: Tue, 24 May 2011 09:26:01 -0700
Message-ID: <7vfwo483qe.fsf@alter.siamese.dyndns.org>
References: <1306248113-19948-1-git-send-email-pegon.marc@gmail.com>
 <7voc2s850z.fsf@alter.siamese.dyndns.org>
 <BANLkTingh__Yxy_rEM2mV6wB453OdarrwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Pegon <pegon.marc@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 18:26:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOuQz-0007i4-73
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 18:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab1EXQ0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 12:26:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab1EXQ0L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 12:26:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F235656EA;
	Tue, 24 May 2011 12:28:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bt+MfgEk/gcVz1AuoAs/JcBg4lk=; b=OT9sAb
	0QX1PyUYyvUdZc/Zy3ZoDcZ3dasveExcwDtenZ0WF2NXYkVl/ZjsoR2cTBOAZAvq
	YC0EbutgOr+gwpZkWaWSdc0/nb1awxDHUXI9uG61IVK1+98B7youl9/we1z0fdKC
	SvWLkPnt0aTbwMxf4BcadZxzb+zvQHcNAiGSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tio+ybI9rNB/N8LbYTJL7WjMnn24ILHK
	svX27ZhzroHRalJhoX0Y0S8kigHTPLhx3GFPYq6E2ziq+EbxhmgxorWxvWp7i1OY
	o2Ywug5RhO9jIqDBYl6BWWxpsSOJmbqJ4JIfojRxkTSD3JSEVZNsDflwwZRcRl5K
	JHZNm4l0CBA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A789656E9;
	Tue, 24 May 2011 12:28:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6858656E7; Tue, 24 May 2011
 12:28:11 -0400 (EDT)
In-Reply-To: <BANLkTingh__Yxy_rEM2mV6wB453OdarrwA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 24 May 2011 23:04:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3781492-8622-11E0-A1FD-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174326>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> As it hasn't been advertised in the documentation (lucky us), it probably is not too
>> late to remove it.
>
> No objection if you remove it. I was probably thinking of git
> "symlink" but the traditional -l was taken, so -L.

I do not care deeply enough to remove it myself, but it is a bad taste to
give a short variant to an option that hasn't yet proven to be frequently
useful, especially to a command whose other command has no short variant.
