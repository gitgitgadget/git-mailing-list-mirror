From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Editing git changelog automatically
Date: Mon, 27 Oct 2014 09:33:25 +0100
Message-ID: <vpq38a9lxnu.fsf@anie.imag.fr>
References: <CAM_iQpWNQbv_GTT+H5KNCqqRS3qWfBuBge4+ZTAS_WiaREku4w@mail.gmail.com>
	<1414389944.7883.2.camel@spirit>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Cong Wang <xiyou.wangcong@gmail.com>, git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 09:33:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xifk5-0002Da-G1
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 09:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbaJ0Ida (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 04:33:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49956 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230AbaJ0Id3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 04:33:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s9R8XOCn002198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Oct 2014 09:33:24 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s9R8XPSi005313;
	Mon, 27 Oct 2014 09:33:25 +0100
In-Reply-To: <1414389944.7883.2.camel@spirit> (Dennis Kaarsemaker's message of
	"Mon, 27 Oct 2014 07:05:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 27 Oct 2014 09:33:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s9R8XOCn002198
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1415003605.15624@rlcHG1nVSArB/wOFSivB8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On zo, 2014-10-26 at 22:27 -0700, Cong Wang wrote:
>> 
>> My question is how to edit dozens of git commit changelogs
>> automatically?
>
> You can use git filter-branch in --msg-filter mode.

Note that in any case, you'll rewrite the history hence change commit
identifiers. If the history is already published, it's probably better
to live with the typo than to try to fix it now.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
