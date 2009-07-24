From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH v2 2/3] Introduce git-discard
Date: Fri, 24 Jul 2009 12:24:51 -0600
Message-ID: <51419b2c0907241124q18232290u860c9d7ca7bb374c@mail.gmail.com>
References: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
	 <cf51e6aa92ea98fc9409826cc0468a01fdf7b01e.1248452530.git.trast@student.ethz.ch>
	 <51419b2c0907241102s31c2fbaeof81e2fb053465c89@mail.gmail.com>
	 <36ca99e90907241112p6cc2c875q5fa4becd1169bfd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 20:25:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUPRw-0008Vl-Vm
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 20:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbZGXSYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 14:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753838AbZGXSYw
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 14:24:52 -0400
Received: from mail-yx0-f198.google.com ([209.85.210.198]:33818 "EHLO
	mail-yx0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbZGXSYw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 14:24:52 -0400
Received: by yxe36 with SMTP id 36so217194yxe.33
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+RTv3syiIdUUBAcGIO7f21sEUXpmo04k62kdmrm5s20=;
        b=m6jjw/ruQDZ4ulNxNWFOhEm3OaInStJM9Rz37g0dQ45q56YVAyZCbZ0JGw0bxnGJIB
         0Pp5sQs7u1qCuCK/uDUFAyr939W0BbgaSeLS1yzLXJa0SwWW1bZU+Kn0Rrho1Z259Qfp
         5QWCzx5yoPWlinaoRwOZJTxzprCJKWaJbS4Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oqEWaTfxgfe4v+zaKJMI0DcXr2gGukaioOJDPef1rhKEejwn6TBsCUPSQ1Gca9+prZ
         KcWbmaxILMry54yu+6yTLoKFbUoeCnAugSgpI5UVsOPW5XGrU57fvc9xmoSoSn/s6T0d
         OvStP9BFEADmVFRck2C8tjO1ekyQPfC76VnLc=
Received: by 10.100.205.11 with SMTP id c11mr4867306ang.72.1248459891819; Fri, 
	24 Jul 2009 11:24:51 -0700 (PDT)
In-Reply-To: <36ca99e90907241112p6cc2c875q5fa4becd1169bfd3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123941>

On Fri, Jul 24, 2009 at 12:12 PM, Bert Wesarg<bert.wesarg@googlemail.com> wrote:
> You fall into the same trap as me for patch 1/3. He does not shift
> away the '--', so it is still in "$@".

Indeed; I somehow missed that '--' was silently added by git.  I guess
that's what I get for shooting off my mouth without actually trying
it.  Sorry for the noise.
