From: Junio C Hamano <gitster@pobox.com>
Subject: Re: release-notes could be clearer on git-fetch changes
Date: Wed, 19 Feb 2014 12:01:45 -0800
Message-ID: <xmqqtxbu98ie.fsf@gitster.dls.corp.google.com>
References: <alpine.LSU.2.11.1402191952070.31131@nerf08.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@inai.de>
X-From: git-owner@vger.kernel.org Wed Feb 19 21:01:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGDL8-0002eG-4q
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 21:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbaBSUBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 15:01:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbaBSUBs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 15:01:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B9956CF2A;
	Wed, 19 Feb 2014 15:01:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xb5UkxxjRFBtMxyTe99hDtzdYJI=; b=q4xpla
	sMbHhOiObsdnmlETsfKujKYY3/vLsHfvEjgTqyX8RLFs+v9H2T+GvA2dwnU3UyY6
	tN1CCxnj7FfSXkJBSyy/SvgaHajuQ6xX9/UCjsK1AqtipMR0b9PSnP61cK/8neky
	COxcOkds3Haj1MfAY7pgWTk/ew3O2oN3GFofI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T74kdWYQJ5ou19A962wTJ/1IQxJ05PJ9
	uKvAymMxliwYyF3QV+dxcFlsLhhoYWuD4YUtAVpOsv2hVHVmXWNY8Xz26W5t7kMA
	7VCIepNR3oFzrPwu6IIJvdVwqRnDEe4wYGEtOBODc2Rndm3TvKqGOBsqBUvYA0tJ
	k6xUxWV4+5A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 037506CF29;
	Wed, 19 Feb 2014 15:01:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE6156CF27;
	Wed, 19 Feb 2014 15:01:46 -0500 (EST)
In-Reply-To: <alpine.LSU.2.11.1402191952070.31131@nerf08.vanv.qr> (Jan
	Engelhardt's message of "Wed, 19 Feb 2014 19:53:32 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A9901488-99A0-11E3-A94D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242401>

Jan Engelhardt <jengelh@inai.de> writes:

> The release notes for 1.9.0 read:
>
>> * The "--tags" option to "git fetch" no longer tells the command to
>>   fetch _only_ the tags. It instead fetches tags _in addition to_
>>   what are fetched by the same command line without the option.
>
> I think the release notes should also say -- like it was done
> extensively for git add -- how to get back the old
> behavior (perhaps through now-different commands).

Perhaps, but the release note is not a place to repeat what the
documentation already teaches---it primarily is to enumerate the
changed areas, to highlight the things users may want to look up in the
documentation, to give them a starting point.

You would do something like this, I would think:

	git fetch $there 'refs/tags/*:refs/tags/*'
