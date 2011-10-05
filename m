From: Gioele Barabucci <gioele@svario.it>
Subject: Re: Git attributes ignored for root directory
Date: Wed, 05 Oct 2011 22:17:16 +0200
Message-ID: <4E8CBB4C.4000408@svario.it>
References: <4E8B55FB.1050203@svario.it> <4E8C481A.1070808@alum.mit.edu> <7vd3eb8hkb.fsf@alter.siamese.dyndns.org> <4E8C9A35.5030504@svario.it> <7vvcs370d1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 22:17:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBXuF-0000iL-6Z
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 22:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935273Ab1JEUR0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 16:17:26 -0400
Received: from begonia.svario.it ([91.213.195.127]:60760 "EHLO
	begonia.svario.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935252Ab1JEURZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 16:17:25 -0400
Received: from [192.168.2.2] (dynamic-adsl-84-223-204-232.clienti.tiscali.it [84.223.204.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: gioele@svario.it)
	by begonia.svario.it (Postfix) with ESMTPSA id 72C102CE35;
	Wed,  5 Oct 2011 20:17:20 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110923 Thunderbird/7.0
In-Reply-To: <7vvcs370d1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182880>

On 05/10/2011 20:35, Junio C Hamano wrote:
>> What if I do not want to say things about the "content" of the
>> directory but about the directory itself? This is exactly my case.
>
> Oh, that is totally different. We do not store directories, and they =
do
> not have attributes, period.

While that is true (yet many beg git to natively support empty dirs=E2=80=
=A6),=20
`.gitignore` does deal with directories. As you quoted,

 > If the pattern ends with a slash, it is removed for the purpose
 > of the following description, but it would only find a match with
 > a directory. In other words, foo/ will match a directory foo and
 > paths underneath it

Isn't applying the same logic to `.gitattributes` be the most=20
straightforward solution? Also code-wise, I suppose.

Bye,

--=20
Gioele Barabucci <gioele@svario.it>
