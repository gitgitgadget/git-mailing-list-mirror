From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improved error messages when temporary file creation
 fails
Date: Sat, 18 Dec 2010 12:47:27 -0800
Message-ID: <7v8vzmhkps.fsf@alter.siamese.dyndns.org>
References: <20101207181633.GF25767@bzzt.net>
 <20101218165514.GT25767@bzzt.net> <20101218200516.GA10031@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Arnout Engelen <arnouten@bzzt.net>
X-From: git-owner@vger.kernel.org Sat Dec 18 21:47:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU3gr-000359-LL
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 21:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198Ab0LRUrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 15:47:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab0LRUrg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 15:47:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7FB992E2B;
	Sat, 18 Dec 2010 15:48:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=MHgipstavFoCofEBSJezVnB7kUA=; b=eoHrW2
	7c2X8TQDY/U78iIYCCHMdadpCQ+R48N5YktCrORUjM47ySpUE6ECQqnkxZSp7iT+
	/K7xGhlpwFLteLwvbIeD3vM2DrB479uhAWpWq/Vxtl5GqxB6YHysQTt5aYbNr/UJ
	NZ25j34D7eQvlPnNuHiRprbASuERREK4+BN8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AUDqfWMhXe6j6gypWl34xhGEJh/Sx34m
	3OGd/KoY1VO7/uSd/CaEzkc39lCqIVu+Rn+pUxzpQkiFCS30tLKlgx3g6E7voYAu
	YeECXWG69nOgiGgAN24mtfyTeBQImd7UBL8Uw4blDnVgeQ6+0maWIIgtvXUqWDn/
	SNUftInTItc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4C0002E2A;
	Sat, 18 Dec 2010 15:48:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1C6BD2E29; Sat, 18 Dec 2010
 15:47:55 -0500 (EST)
In-Reply-To: <20101218200516.GA10031@burratino> (Jonathan Nieder's message of
 "Sat\, 18 Dec 2010 14\:05\:16 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 19CDDC76-0AE8-11E0-B1ED-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163931>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi again,
>
> Arnout Engelen wrote:
>
>> Updated version of the patch
>
> Almost there.  Some remaining nits from my pov:
>
>> , taking into account the feedback from this 
>> thread.
> [...]
>
> This text above the "---" becomes part of the log message when a patch
> is committed to git.git, so it is best to make it self-contained.  The
> usual advice is "describe the current behavior, why the proposed
> behavior is better, and then how the proposed behavior is achieved."

Thanks, Jonathan.

The important part of self-containedness is that people who are reading
the resulting commit and the history that contains it should not have to
unnecessarily refer to outside resources, especially the previous rounds
that weren't satisfactory.  The comparison with previous rounds however is
a very valuable resource for reviewers on the mailing list, so don't
remove what you wrote there, but move it below "---" lines.
