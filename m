From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9143: do not fail when unhandled.log.gz is not created
Date: Thu, 09 Dec 2010 16:11:43 -0800
Message-ID: <7v39q6fpvk.fsf@alter.siamese.dyndns.org>
References: <4D0133AF.40000@web.de> <20101209213123.GA25684@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 01:12:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQqal-0003J4-4V
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 01:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757565Ab0LJAMA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 19:12:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab0LJAL6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 19:11:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 44CC42F26;
	Thu,  9 Dec 2010 19:12:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tdkEnJT1OzNn
	f9PWHbaox9baaWE=; b=CvWR6dGgeOZ/sY9DUCNC4jRVTI/TqHMvfaF6hFhh/drW
	Zv2pPE8Y8obG/SNQSpfSvAALVV+xDil9VBZpnEIn69zXXdCDS+CNnvZjtLM8nD9X
	fQiW26lTZ5JXty7Uchu5Vj606IpOdz79NYUTCqR2y8cYzMHGlpmtq+BnCGIN/l4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LKObI8
	xlmHybuJaLA/hTJBTJvaqcYyK18hHxSUvPcwxLP2f/IvkDZ1pzrUsJeo3YYsnwjh
	n9Gyh2eCU6BiJS1NRHWoCZpVeKoNrcCsJGOuf9gQIIm6p+p9wmz0e3jG2c1J0k3+
	882Fy6XnmiHu8US8HYxYYhv9CGn6wkQxFWgAA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 023DC2F25;
	Thu,  9 Dec 2010 19:12:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9CA402F24; Thu,  9 Dec 2010
 19:12:10 -0500 (EST)
In-Reply-To: <20101209213123.GA25684@dcvr.yhbt.net> (Eric Wong's message of
 "Fri\, 10 Dec 2010 05\:31\:23 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 250D10EA-03F2-11E0-8D78-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163363>

Eric Wong <normalperson@yhbt.net> writes:

> It's pushed out to git://git.bogomips.org/git-svn along with an
> older patch from Steven:
>
> Steven Walter (1):
>       git-svn: allow the mergeinfo property to be set
>
> Torsten B=C3=B6gershausen (1):
>       t9143: do not fail when unhandled.log.gz is not created

Thanks; will pull.
