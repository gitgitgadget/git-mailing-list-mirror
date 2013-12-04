From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] mv: let 'git mv file no-such-dir/' error out
Date: Wed, 04 Dec 2013 18:48:30 +0100
Message-ID: <vpqeh5s8q35.fsf@anie.imag.fr>
References: <1386059524-14442-1-git-send-email-Matthieu.Moy@imag.fr>
	<CACsJy8CfvdT2LgRHax3P6k94C3S9ScB4fuNRm7bZWGXRW=NqKA@mail.gmail.com>
	<vpqa9ghhunu.fsf@anie.imag.fr>
	<CACsJy8BdXkzzZpEaOvqkJ8ckubbQ0ArOMUT8qnMHMDscupfj_A@mail.gmail.com>
	<xmqqpppclde1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 18:51:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoGbo-0003Np-6F
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 18:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884Ab3LDRvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 12:51:32 -0500
Received: from mx2.imag.fr ([129.88.30.17]:46277 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755182Ab3LDRvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 12:51:10 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id rB4HmSwm015842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Dec 2013 18:48:28 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rB4HmU8i032373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 4 Dec 2013 18:48:30 +0100
In-Reply-To: <xmqqpppclde1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 04 Dec 2013 09:44:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 04 Dec 2013 18:48:29 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rB4HmSwm015842
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1386784112.5711@1lDoATjEGtfGzlLF0v4+Hg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238795>

Junio C Hamano <gitster@pobox.com> writes:

> It seems that t7001 needs some face-lifting, by the way.  Perhaps
> after this patch solidifies.

Yes. I followed the style of surrounding code, but it could be
reformatted to follow the current standard. I have no time for it now.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
