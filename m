From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Fri, 18 Feb 2011 10:34:37 -0800
Message-ID: <7voc69p4xu.fsf@alter.siamese.dyndns.org>
References: <4D0ED5EC.9020402@burntmail.com>
 <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com>
 <4D119015.6020207@burntmail.com> <4D2AB63D.7040803@burntmail.com>
 <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>
 <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino>
 <7v8vynnokt.fsf@alter.siamese.dyndns.org> <4D450655.5090501@burntmail.com>
 <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com>
 <7vhbcb35xk.fsf@alter.siamese.dyndns.org> <4D5E1116.7040501@burntmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@laptop.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Guy Rouillier <guyr@burntmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 19:35:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqVAW-0008R3-LG
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 19:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791Ab1BRSe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 13:34:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab1BRSe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 13:34:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EE5654CD9;
	Fri, 18 Feb 2011 13:36:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+wbdL0AlHWxC42SGqsq93GTPzHQ=; b=kU2Vsq
	tVsp/wrjHS8laCX8k6pUbaSv1nzwdPfVVzjkt3r7kZqu8z+c9YS7GfyomKqji2oK
	UcASDAqgL9J80IswESgLiZMDMZx3x0lKKTTZNYir2IWhR2BmzVFHr+wEyBs3aoz8
	wXyogb21pjr1WL4OI3/LaaCELoq32HaaVBulQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iGh0Ripntf8NzxXzVlA115Zy03GdZmZM
	NWpwKr6buo0kOC7urauNlEnFeBhEDfQfYIKNm4qNiK/voWrQ7tyoO8oJ9UWhtM3H
	ZTAQbp/RUbWAS/Cn+rxUjtCYU/GYRhud9hfKiIM3m2gCYzjevQWIgrnAAvsFcIPc
	PAajQiNSiEw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 514844CD8;
	Fri, 18 Feb 2011 13:35:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AEAC04CD1; Fri, 18 Feb 2011
 13:35:48 -0500 (EST)
In-Reply-To: <4D5E1116.7040501@burntmail.com> (Guy Rouillier's message of
 "Fri\, 18 Feb 2011 01\:26\:30 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED8C7308-3B8D-11E0-853B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167222>

Guy Rouillier <guyr@burntmail.com> writes:

> ...  I'm new to all this and I thought 
> perhaps one of the listed committers had to submit the official patch.  

There is no _listed committers_ ;-)  I was hoping either you as the original
author of the patch or Martin as the area expert would respond, but as
long as the result looks correct and explained well, it doesn't matter
either way.

Just one hopefully final question.

After stripping "/<version number><space>" from the beginning of the line
in order to treat newer .cvspass file format and the original file format
the same way, the code splits the remainder into two fields (cvsroot and
lightly-scrambled password).  It used to split only at a whitespace, which
seems to be in line with the source of CVS 1.12.13 I looked at (it is in
password_entry_parseline() function, src/login.c).  You new code however
also allows '=' to be a delimiter to be used for this split.

Is this change intentional?  If so please explain why it is necessary in
the commit log message.
