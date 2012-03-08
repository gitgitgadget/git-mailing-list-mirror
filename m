From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git push default behaviour?
Date: Thu, 8 Mar 2012 20:49:39 +0300
Message-ID: <CAHkcotiOGaOdDvibpoiEgys3PnSPfSw0mT3DeEOix+FuboULiA@mail.gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
	<CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
	<1331203321.21444.13.camel@beez.lab.cmartin.tk>
	<4F58C977.8000400@xiplink.com>
	<vpq62efjeqd.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 08 18:49:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5hTG-0007F9-81
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 18:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab2CHRtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 12:49:41 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33443 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab2CHRtk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 12:49:40 -0500
Received: by qcqw6 with SMTP id w6so533829qcq.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 09:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q0wJaygGhtcRo6kokIgveGs3ywotdHbQ8C4nmVTEpXU=;
        b=V0Qo5FiDSG2KpOz9IPeuoAFBVOigfvrvU5zyAZbRW2TxK9PxS4mr7oetD7PkwyhYij
         uSVM63Y1mkkSo8XzC8AZmDP3u6t5DDTAGxeFrjLR0O44Yn5jBvHIJxZHTSHJomKWlckC
         pjNgWpipyI3XmBAGmZi9KKqPV/FAdyv8xvS/noMYWZbd6N4kuGuGnOZ6iq6Lvq9DHKhX
         4nmNQwHPDtfitRBptc2y5t0h1TmbKvkNrYQyTONxBy/LK75ncuy0VO/8ZA7ksjuqGqu0
         xXrwT4bONkGkp+wckS7sU7sD6JVdmxInRMPmXOiKisdDq2uJRC1B/kDMnXYmNqjZggrq
         tSOA==
Received: by 10.224.116.18 with SMTP id k18mr4190453qaq.14.1331228979976; Thu,
 08 Mar 2012 09:49:39 -0800 (PST)
Received: by 10.229.88.149 with HTTP; Thu, 8 Mar 2012 09:49:39 -0800 (PST)
In-Reply-To: <vpq62efjeqd.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192625>

On Thu, Mar 8, 2012 at 7:26 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>
> 'push.default = matching' is never a good idea if you use shared
> repository actually. It makes sense for people like Junio pushing a
> local repository to a public one, which is read-only for the rest of the
> world. But my experience is that people using such workflow are advanced
> users, and would know how to configure Git, so it wouldn't really harm
> them to change the default.

There are more people that you think who rely on the current behavior
of git push. For instance, pushing changes between different computers
for testing purposes before publishing them. When you silently change
the default value of push, you silently break their workflow. It is not
difficult to add 'push.default = matching' but you need to know that the
default value has changed, so you have to add this line to preserve the
old behavior.

Dmitry
