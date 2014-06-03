From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v2 2/2] config: Add new query functions to the api docs
Date: Tue, 03 Jun 2014 17:35:33 +0200
Message-ID: <vpqegz6qa4a.fsf@anie.imag.fr>
References: <1401720460-6525-1-git-send-email-tanayabh@gmail.com>
	<1401720460-6525-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 17:35:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrqkd-0007CU-JR
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 17:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932878AbaFCPfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 11:35:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50183 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932345AbaFCPfn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 11:35:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s53FZV13016532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jun 2014 17:35:31 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s53FZXXk004868;
	Tue, 3 Jun 2014 17:35:33 +0200
In-Reply-To: <1401720460-6525-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 2 Jun 2014 07:47:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 03 Jun 2014 17:35:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s53FZV13016532
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1402414536.58312@XGpR5mDIcbVoGJGOpmyZ0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250626>

Tanay Abhra <tanayabh@gmail.com> writes:

> Add explanations for `git_config_get_string_multi` and `git_config_get_string`
> which utilize the config hash table for querying in a non-callback manner for
> a specific variable.

I'd squash this into the previous patch: the reader appreciates having
the documentation when reviewing the code itself (so that one can check
that the documented behavior matches the implementation).

> +the highest priority(i.e. value in the repo config will be preferred over

Missing space before (.

Other than that, this seems good.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
