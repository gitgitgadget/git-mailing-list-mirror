From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT GUI PATCH v2] git-gui: tolerate major version changes when comparing the git version
Date: Mon, 19 May 2014 10:16:10 -0700
Message-ID: <xmqqzjid1yg5.fsf@gitster.dls.corp.google.com>
References: <CAFOYHZBPLZhVuf=bO0hPcUH2_0WXFSqk=_CqoUWBRixQc0L==Q@mail.gmail.com>
	<CAFOYHZD=wxwm0nLhtZwvXDAhQ23j0C5maArQunc0CVe_-SF_mQ@mail.gmail.com>
	<871tw7xg3o.fsf@fox.patthoyts.tk> <5369E0A3.4040701@gmail.com>
	<5369E58D.4030908@gmail.com> <53728D70.4020506@web.de>
	<5373200D.7020108@web.de>
	<xmqqlhu4jhcb.fsf@gitster.dls.corp.google.com>
	<xmqqk39ohvyp.fsf@gitster.dls.corp.google.com>
	<87k39kbnmg.fsf@fox.patthoyts.tk> <5377BD31.8040004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: patthoyts@users.sourceforge.net,
	Chris Packham <judge.packham@gmail.com>,
	GIT <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon May 19 19:16:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmRAi-0008Q9-Dv
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 19:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbaESRQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 13:16:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54314 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932240AbaESRQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 13:16:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BD0F4166B7;
	Mon, 19 May 2014 13:16:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sc4i23VywhnuIi1y7kAXZmd13+4=; b=x6tWf9
	OkZYlR0p8belMMDZr9UHD49YBYTS7lJrPRDJXgUKVQ1T3lBxOWWM31ult513Xdbc
	EK26Gv/bMM8xydm2lREO7yW2CsPpvWXOWtQkCBvNbc66OQGSnaq+Pdu3A3OHqicN
	vfR7r7EE813Y2fgSTFAoWtEpJU5nJWGQwocu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RuR74/rYWJ5loxtNCGSnaYFB845e0Ivi
	3TpmisO2k3HIk9bsurAM54dbDzHm0mZbKAFgDByTzm+9T+cu9fJ3X2WC6pmhOW7m
	/YXYfkuNbHDF61SYVBlXnbZhMENcSfTpOfrFOFToPzXjYhL5ENQaTy83MtHETA6h
	bHWsF+Iv9DA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B2A9A166B5;
	Mon, 19 May 2014 13:16:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BED80166A7;
	Mon, 19 May 2014 13:16:11 -0400 (EDT)
In-Reply-To: <5377BD31.8040004@web.de> (Jens Lehmann's message of "Sat, 17 May
	2014 21:49:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 467D8E42-DF79-11E3-8DE6-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249604>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 17.05.2014 14:23, schrieb Pat Thoyts:
>>
>> The analysis about the major version number being significant is
>> correct. ...
>> 
>>   package vsatisfies $::_git_version 1.7.0-
>> 
>> will suffice.
>
> Junio, please replace my old version with this.

Thanks, both.  Will replace.
