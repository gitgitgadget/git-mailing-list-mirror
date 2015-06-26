From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v9 4/5] bisect: add the terms old/new
Date: Fri, 26 Jun 2015 09:00:55 +0200
Message-ID: <vpqoak3x8bc.fsf@anie.imag.fr>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-5-git-send-email-Matthieu.Moy@imag.fr>
	<CAP8UFD1EWYzg7-O4BDgUTQPJOoo6TEAF49amakgfR8K6CX886A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 09:01:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8NdO-00089o-2D
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 09:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbbFZHBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 03:01:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55948 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbbFZHBE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 03:01:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5Q70tST015255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2015 09:00:55 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5Q70tAT032334;
	Fri, 26 Jun 2015 09:00:55 +0200
In-Reply-To: <CAP8UFD1EWYzg7-O4BDgUTQPJOoo6TEAF49amakgfR8K6CX886A@mail.gmail.com>
	(Christian Couder's message of "Fri, 26 Jun 2015 06:11:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 26 Jun 2015 09:00:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5Q70tST015255
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435906858.32408@iJfD8B+tZNMqOiCvSDmehg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272763>

Christian Couder <christian.couder@gmail.com> writes:

> So perhaps you could use a function like:
>
> write_bisect_terms() {
>       if test ! -s "$GIT_DIR/BISECT_TERMS"
>       then
>             echo "$NAME_BAD" >"$GIT_DIR/BISECT_TERMS" &&
>             echo "$NAME_GOOD" >>"$GIT_DIR/BISECT_TERMS"
>       fi
> }

I already had it in the last patch, but reworked the code to introduce
it earlier, and never >"$GIT_DIR/BISECT_TERMS" outside this function.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
