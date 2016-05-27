From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: document the --decorate=auto option
Date: Fri, 27 May 2016 13:17:36 -0700
Message-ID: <xmqqy46vp867.fsf@gitster.mtv.corp.google.com>
References: <57486E12.7030907@ramsayjones.plus.com> <57489366.507@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri May 27 22:17:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6OCc-0004tf-8Y
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 22:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575AbcE0URl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 16:17:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756572AbcE0URk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 16:17:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 24EC91D709;
	Fri, 27 May 2016 16:17:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N7WuDyLeDcKHEHRrtjsCNHTD4jw=; b=Ux6nfW
	DzEHTOhhDMuKzJQZTX8M+LcHtrAg3HHHPEtMFs6mk55sdfRYtmmpO7rDeucVq3KO
	ek9h9tiSmuLOhCXTyHCHIwMAZRtOejNFqkW0nSUqenfLM348WjrNbglYreOQc6Sl
	qq9r7ZtTwl3QxT5L7yvez+9t6joGJMoan+f/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FU7ep4r63frdeUs/XNznIGr53kiP204d
	7VnPRemQLdcuB601vEEKjiTP+4iba6yzNBVQLHqFWITBEZpm7HAQNiCMZ6lSgCKu
	PBznzJRlTdbj7zaeZMfV+xp3f+zXr274jrMcErmeR9SFp9cicixiHxfkNt9nl3qy
	smL0+2N4Ui4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C5061D708;
	Fri, 27 May 2016 16:17:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B9741D707;
	Fri, 27 May 2016 16:17:38 -0400 (EDT)
In-Reply-To: <57489366.507@xiplink.com> (Marc Branchaud's message of "Fri, 27
	May 2016 14:35:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0ECB9104-2448-11E6-96E7-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295793>

Thanks, both.
