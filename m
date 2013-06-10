From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rm: introduce advice.rmHints to shorten messages
Date: Mon, 10 Jun 2013 09:57:04 -0700
Message-ID: <7vd2rtkiov.fsf@alter.siamese.dyndns.org>
References: <1370868700-27189-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	<1370868700-27189-2-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	<18c54938bf29444008aec7b3e48912dc@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	<git@vger.kernel.org>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Mathieu =?utf-8?Q?Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 18:57:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um5P7-0000Mt-7n
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 18:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab3FJQ5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 12:57:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40118 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297Ab3FJQ5H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jun 2013 12:57:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA77A26858;
	Mon, 10 Jun 2013 16:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fPIgS11JYN47
	th2+6KC8rGrQ8V8=; b=gIu1lfqi2RuH13aOQzaUHrjyaxUQK+dYg4jWSqjokNvK
	BgzywPmNph6ucFVM8ux3sdhV++tbgXr6j/3u/Gp9Os6ZVvpX7KlLMODKmtGtq157
	FThQLOhZdGirYQwuoWpH+bUZMNVAzTlxWHSfja+eazhaCLn0gf/GTphgcZh0yL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=f0byvy
	f8M4k4ziA3FV1evCDpiqBcPCqU/6n49MWjBPm2SpCad3ZM2YLMKDcNi9lWnv3+qZ
	rHyjT555pvZeGogGJg7sngd3opB5Lmz1lZpGHa95aZbvoQmfNNK87Rw4mxvT1UGn
	Qk4Syk1v/m3CQxnh/j1c6md6VxwekG/SuHLNg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1ADF26857;
	Mon, 10 Jun 2013 16:57:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BE1F26856;
	Mon, 10 Jun 2013 16:57:06 +0000 (UTC)
In-Reply-To: <18c54938bf29444008aec7b3e48912dc@ensibm.imag.fr> ("Mathieu
	=?utf-8?Q?Li=C3=A9nard--Mayor=22's?= message of "Mon, 10 Jun 2013 14:54:23
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8026148-D1EE-11E2-A9A2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227322>

Mathieu Li=C3=A9nard--Mayor  <mathieu.lienard--mayor@ensimag.fr> writes=
:

> Please ignore this, manipulation error while in the git send-email
> command line.

Here is what my mailbox looks like (the penultimate one with 252
lines is what I am responding to). =20

  R. [ 146: Mathieu Lienard--Mayor ] [PATCH 1/2] rm: better error messa
  R. [ 231: Mathieu Lienard--Mayor ] [PATCH 2/2] rm: introduce advice.r
  R. [ 157: Mathieu Lienard--Mayor ] [PATCH 2/2] rm: introduce advice.r
  R. [ 198: Mathieu Lienard--Mayor ] [PATCH v2 1/2] rm: better error me
  R. [ 157: Mathieu Lienard--Mayor ] [PATCH v2 2/2] rm: introduce advic
   . [ 153: Mathieu Lienard--Mayor ] [PATCH v3 2/2] rm: introduce advic
   . [ 214: Mathieu Lienard--Mayor ] [PATCH v3 1/2]  rm: better error m
   . [ 214: Mathieu Lienard--Mayor ] [PATCH v3 1/2]  rm: better error m
   . [ 153: Mathieu Lienard--Mayor ] [PATCH v3 2/2] rm: introduce advic
  R  [  33: Mathieu Li=C3=A9nard--Mayor ] Re: [PATCH 1/2] rm: better er=
ror m
  O  [  38: Mathieu Li=C3=A9nard--Mayor ] Re: [PATCH 2/2] rm: introduce=
 advi
  R. [ 156: Mathieu Li=C3=A9nard--Mayor ] Re: [PATCH 1/2] rm: better er=
ror m
  R. [ 252: Mathieu Li=C3=A9nard--Mayor ] Re: [PATCH 2/2] rm: introduce=
 advi
   . [  84: Mathieu Li=C3=A9nard--Mayor ] Re: [PATCH v2 1/2] rm: better=
 erro

I am guessing that [v3 1/2] and [v3 2/2] are the final ones but it
that is not the case please holler.
