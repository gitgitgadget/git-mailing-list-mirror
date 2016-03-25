From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v10 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 25 Mar 2016 10:05:28 +0100
Message-ID: <vpqshzfuduv.fsf@anie.imag.fr>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
	<1458591170-28079-1-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, pyokagan@gmail.com,
	sunshine@sunshineco.com
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:05:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajNgk-0004JN-LV
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 10:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbcCYJFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 05:05:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37303 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbcCYJFp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 05:05:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u2P95SF2025158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 25 Mar 2016 10:05:28 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2P95ST2024026;
	Fri, 25 Mar 2016 10:05:29 +0100
In-Reply-To: <1458591170-28079-1-git-send-email-mehul.jain2029@gmail.com>
	(Mehul Jain's message of "Tue, 22 Mar 2016 01:42:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 25 Mar 2016 10:05:29 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2P95SF2025158
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1459501532.29612@nQ+ZVucDg5nTFvdUiW+6Qg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289863>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> +--autostash::
> +--no-autostash::
> +	Before starting rebase, stash local modifications away (see
> +	linkgit:git-stash[1]) if needed, and apply the stash when
> +	done. `--no-autostash` is useful to override the `rebase.autoStash`
> +	configuration variable (see linkgit:git-config[1]).
> ++
> +This option is only valid when "--rebase" is used.

This does not have to be added to this series (I don't want to break
everything at v10 ...), but I think it would be nice to allow "git pull
--autostash" even without --rebase if pull.rebase=true.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
