From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] pager: remove 'S' from $LESS by default
Date: Wed, 30 Apr 2014 17:49:21 +0200
Message-ID: <vpqy4ymlsvy.fsf@anie.imag.fr>
References: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com>
	<1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqbnvihlny.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Kastrup <dak@gnu.org>, d9ba@mailtor.net,
	jrnieder@gmail.com, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 17:49:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfWle-0004r2-Cf
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 17:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759294AbaD3Ptu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 11:49:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59009 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759122AbaD3Ptt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 11:49:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3UFnKWR007914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Apr 2014 17:49:20 +0200
Received: from anie.imag.fr (ensi-vpn-228.imag.fr [129.88.57.228])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3UFnLs3010731;
	Wed, 30 Apr 2014 17:49:21 +0200
In-Reply-To: <xmqqbnvihlny.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 30 Apr 2014 08:38:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 30 Apr 2014 17:49:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3UFnKWR007914
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1399477762.2204@hw5k2Ta8y6rOl7YU2kfDtQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247723>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> By default, Git used to set $LESS to -FRSX if $LESS was not set by the
>> user. The FRX flags actually make sense for Git (F and X because Git
>> sometimes pipes short output to less, and R because Git pipes colored
>> output). The S flag (chop long lines), on the other hand, is not related
>> to Git and is a matter of user preference. Git should not decide for the
>> user to change LESS's default.
>
> Git always pipes its output to less,

Err, no, not all commands use a pager.

> I am inclined to suggest queuing it for the first batch after 2.0
> instead of directly applying to 'master', as we have past the point
> we can expect to see reports of unexpected fallouts and fix the
> issues in time for the final.

Fine with me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
