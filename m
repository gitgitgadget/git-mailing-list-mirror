From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 00/16] Return of smart HTTP
Date: Mon, 12 Oct 2009 23:42:57 -0700
Message-ID: <7vbpkb3iby.fsf@alter.siamese.dyndns.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
 <4AD3F7C5.2060203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: eduard stefan <eduard.stefan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 08:53:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxbGQ-0006nV-Qg
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 08:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933008AbZJMGoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 02:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758011AbZJMGoQ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 02:44:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758811AbZJMGoP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 02:44:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5BA8D75BB5;
	Tue, 13 Oct 2009 02:43:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YH3SHjMcLJHVABYhG9PNuNT+rxo=; b=LRaMa1
	B8U/PL2NjbDlVJwsZ4GqEdAXtVab0I9zlQ7pExOEdHF1Q2huozaV9rJDQ9VVfFb4
	KKG13xZM+xdfJ9ZbF9reKsvcm7KRvo4XrqOzxaPxinmNrCKt0O0Ar785WQMgWUkG
	7Js1zaR7Yy5xj8vGI1tLzgT0RAaDZKC3aV2g8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rux7gUnGK3OT9knjSkjm7nbNrXDn61Za
	jjf9CaQnbN8XqkPWE5stLlwMXF/8xPyn9MYksNZI3UUzXk4SfVyw+J1hWyXv/kZD
	PIE8ZKCKneInYwQfq7u7xLmhHhOMIls8Pg4RHB34b+UpLq5NTIycmad3OSEyGusD
	izYvgJ+eXtw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3244375BB4;
	Tue, 13 Oct 2009 02:43:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 450C075BB3; Tue, 13 Oct 2009
 02:42:58 -0400 (EDT)
In-Reply-To: <4AD3F7C5.2060203@gmail.com> (eduard stefan's message of "Tue\,
 13 Oct 2009 06\:45\:09 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A88734CC-B7C3-11DE-BD77-A730BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130132>

eduard stefan <eduard.stefan@gmail.com> writes:

> I have apllied you patches on top of Git 1.6.5 release,
> and they solved my http cloning crashes on windows
> (msysGit environment).

Unfortunately that is not a very good news.

As there is no chance Shawn's new series will be applied to 'maint' for
updating 1.6.5.X series, somebody needs to address the breakage without
introducing the whole new HTTP code.  Is the breakage you are seeing
limited only to msysgit environment, or does the same breakage appear on
other platforms?
