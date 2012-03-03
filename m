From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: filtering out mode-change-only changes
Date: Sat, 03 Mar 2012 14:16:43 -0800
Message-ID: <4F52984B.5050805@pcharlan.com>
References: <jik2le$2lb$1@dough.gmane.org> <7vmx82wbmr.fsf@alter.siamese.dyndns.org> <7vipiqwb2g.fsf@alter.siamese.dyndns.org> <4F4E7847.9030402@gmail.com> <7vsjhts9hu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 23:17:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3xGx-00023W-FR
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 23:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825Ab2CCWRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 17:17:43 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:38428 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab2CCWRc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 17:17:32 -0500
Received: from homiemail-a49.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 49A8C179163
	for <git@vger.kernel.org>; Sat,  3 Mar 2012 14:17:30 -0800 (PST)
Received: from homiemail-a49.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a49.g.dreamhost.com (Postfix) with ESMTP id BF74E5E0058;
	Sat,  3 Mar 2012 14:16:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=pcharlan.com;
	 b=X5J86b8x/W4d7ufIcywmq70qgTkI2TpXPRsTbm6L3liVgtO1P1jmZlQco01qh
	grroBQsUqcufoyzWVgy8WOH5srSryynTymyhbOgJSFtfj1XCLFYCMsZn3H3H7dEW
	vru/WV+RNRTRjJmX3HoC99n/3Jty70VOI+MaoxXWxpNr/c=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=pcharlan.com; bh=9Eyp
	btIH0ENO7mHE74NtWZcgY1Y=; b=iXb59ePaSWVv1sbsO4JQVz/l6HrY/qWiKwBu
	t9wKw5SfVTHITXWiSkhnneZxU647Jhul7l8wcoTNDkHpuUVUw/sV8/jHkdXxyVrn
	5QKOk9nDfEw8HjDKZ4c4muqQPz4y4tdGznZzDG+XDe+EtCRiP91zsbOfuqwGfA1g
	36CZsUc=
Received: from [192.168.0.106] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pete@tento.net)
	by homiemail-a49.g.dreamhost.com (Postfix) with ESMTPSA id 964AA5E0057;
	Sat,  3 Mar 2012 14:16:42 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vsjhts9hu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192139>

On 2/29/2012 11:52 AM, Junio C Hamano wrote:
> Neal Kreitzinger<nkreitzinger@gmail.com>  writes:
>
>> A3-2: (Some Desired Options)
>> --name-status learns a new status for file-mode-only changes (ie, "P"
>> for "P"ermissions).
>
> After reading everything above I omitted from your response in my quote, I
> still do not get the feeling that these willy-nilly mode changes that you
> are suffering from is a problem that is general enough to warrant such a
> change, even if such a change is done as an optional feature.

I'll add a vote for the usefulness of the option.

I'm dealing with a repo whose history occasionally has commits that do a 
handful of real changes mixed in with tens of thousands of mistaken mode 
changes.  (New workflow is fixed but it is infeasible to fix history at 
this point.)  It's cumbersome filtering away the noise.

If Git's diff engine could ignore mode changes that would be a big help.

Regards,

--
Pete Harlan
pgit@pcharlan.com
