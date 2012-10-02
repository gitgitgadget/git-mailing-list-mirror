From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Tue, 2 Oct 2012 10:49:37 +0200
Message-ID: <CAB9Jk9B9MBkm1_N+Ejc+KqunHL7S8czXH1NGyu-71Z1XidjLSA@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 10:51:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIyB6-0006Vg-4c
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 10:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab2JBIty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 04:49:54 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:61945 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab2JBIti (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 04:49:38 -0400
Received: by vcbfo13 with SMTP id fo13so6643395vcb.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 01:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4L9dCcrY6f2Iv8NklD7ZK/+RUrX+DEvltCbT/DqsOlg=;
        b=DLi6/Znc1IVLupQBrh6Zj/gQPfZ9Oxss8+6EAzRrjKKATPZJl2E9tNuhwFM6qJntuw
         9vYpOL9MSm89P/jKqVzi7RlfstOlllVRguzzuzmn3c095qHn0B8IVUSnct0DecUAibis
         ri7f0KkkD84/zD118SoJE30KLBm8LGaePEUA1rwyJWsTt3P0LLO3XvaIxTtArj/PwniD
         JMgJZrkAQgV9LROd9KEEkv9OVSZPC+BeXdq23j0tExaNm4J7gtn/KA0/XV6lmhh2GbV/
         OSZDp9fTbpRyIBpvNmWMP7pfR1VevclbNWxQ3nnB5RYJQWPM4wKm47JOlK7L0gS8PH8V
         1iKg==
Received: by 10.52.90.2 with SMTP id bs2mr7941105vdb.23.1349167777493; Tue, 02
 Oct 2012 01:49:37 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Tue, 2 Oct 2012 01:49:37 -0700 (PDT)
In-Reply-To: <506AA51E.9010209@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206793>

Hi

having such  a time-dependent behavior is not nice. It means that the user must
know it, and wait patiently before issuing the command, or in a script
add a sleep
before the command.
The choice is then between adding a warning in the man page ("please
wait at least
a second before executing the command") or adding a sleep inside the command
itself.
Obviously, the second alternative looks much more appealing.

Thank you
-Angelo
