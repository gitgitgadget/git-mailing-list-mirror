From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Wed, 28 Aug 2013 23:05:02 +0200
Message-ID: <vpqy57l4jcx.fsf@anie.imag.fr>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
	<vpqhae97f8j.fsf@anie.imag.fr>
	<CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 23:05:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEmvV-0001Ul-JU
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 23:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643Ab3H1VFI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Aug 2013 17:05:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40091 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755630Ab3H1VFF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 17:05:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7SL50R3018398
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Aug 2013 23:05:00 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VEmvH-0001WH-4w; Wed, 28 Aug 2013 23:05:03 +0200
In-Reply-To: <CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 28 Aug 2013 15:48:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 28 Aug 2013 23:05:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7SL50R3018398
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378328700.80247@KYjvAZYTOLCKPQTkyFD7tA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233214>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Aug 28, 2013 at 3:05 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>>> +     bzr log | grep "^committer: " > ../actual
>>> +     ) &&
>>> +
>>> +     echo "committer: Gr=E9goire <committer@example.com>" > expect=
ed &&
>>
>> Git's source code usually says >../actual and >expected, without spa=
ce
>> after '>'.
>
> Not that usually:
>
> % git grep ' > ' t/*.sh | wc -l
> 1943

Do I really need to quote the paragraph in CodingGuidelines?

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
