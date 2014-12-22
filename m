From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Supporting a few more usecases with remote helpers
Date: Mon, 22 Dec 2014 08:39:56 -0800
Message-ID: <xmqqegrrbpur.fsf@gitster.dls.corp.google.com>
References: <20141222010726.GA4817@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Dec 22 17:40:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y361l-0008PC-TT
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 17:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184AbaLVQkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 11:40:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754994AbaLVQkG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 11:40:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BE452742B;
	Mon, 22 Dec 2014 11:39:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IPDRz3DqyjkGb7hZ/bj/Wi1iyss=; b=lYsK1B
	Dd9EGJClxfZJfxbZp5TYYvlGnPSvljfl+2RtYZgWyewj6r+iZRTVRPIytX4tCHTm
	kKS7UMl+95WfW4s4jItvw9r5tKN9j5KaJYs57f70UIenxiq8DlpHb192At7UkYXw
	5G/Px8ga28ycqroV6kFudIycTn1dRGZe03dWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AZEsnIdASsvmV1Xrfn/zjX/eLromK4Nl
	8jlb/yngpKCgVmv5mA28Vg0MX9bfld4pcqKqua+FdfKWRiB1g6lU/HUosimYOs5A
	S3B9R3rX7FQ9WUKkSAMvx+9KOaiWdzQe2V8YbEb9b7p5UY3eEUvJyophEwMdgDKj
	8Hfyqu5WSWI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 62AB12742A;
	Mon, 22 Dec 2014 11:39:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D76EA27429;
	Mon, 22 Dec 2014 11:39:57 -0500 (EST)
In-Reply-To: <20141222010726.GA4817@glandium.org> (Mike Hommey's message of
	"Mon, 22 Dec 2014 10:07:26 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2A62C490-89F9-11E4-A14F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261647>

Mike Hommey <mh@glandium.org> writes:

> 1. I think it should, as long as the given sha1 is reachable from the
> public heads, but that's offtopic here.

Sounds vaguely familiar:

  http://thread.gmane.org/gmane.comp.version-control.git/178814/focus=179007
