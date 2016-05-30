From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP-PATCH 0/2] send-email: refactor the email parser loop
Date: Mon, 30 May 2016 21:29:39 +0200
Message-ID: <vpqinxv4a58.fsf@anie.imag.fr>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
	<20160527201436.GA16547@dcvr.yhbt.net> <vpq8tyujkb0.fsf@anie.imag.fr>
	<7423b133-cec4-e633-f1ef-70ccc6a6cc02@grenoble-inp.org>
	<vpq8tyshh8f.fsf@anie.imag.fr>
	<0abbc11b-5741-ee2e-292c-245c2b974f8e@grenoble-inp.org>
	<vpqfuszaapu.fsf@anie.imag.fr>
	<f80f8c1b-6a69-1356-d300-82b7c5af5821@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <e@80x24.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon May 30 21:29:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7Ssw-0007el-Is
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 21:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161968AbcE3T3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 15:29:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48087 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161960AbcE3T3x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 15:29:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4UJTbnA020192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 30 May 2016 21:29:38 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4UJTdc4011977;
	Mon, 30 May 2016 21:29:39 +0200
In-Reply-To: <f80f8c1b-6a69-1356-d300-82b7c5af5821@grenoble-inp.org> (Samuel
	GROOT's message of "Mon, 30 May 2016 20:28:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 30 May 2016 21:29:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4UJTbnA020192
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465241381.28056@Z/Gjh4RSHtxQfNNqG/R84w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295929>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> Can we consider this feature obsolete and remove it?

We're usually quite conservative with backward compatibility. If we
remove the feature, we may want to announce it in the next feature
release and actually remove it in the one after (unless we get valid
objection in the meantime).

I'm all for dropping a feature that no one uses if it turns out to be
the case.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
