From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCHv3 1/4] Refactor print_state into get_state
Date: Mon, 12 Nov 2012 23:59:52 +0530
Message-ID: <CALkWK0=7JrE90TH=DLzBvybuaJQuOoXOfZO71OTsUGzDQ8bLMw@mail.gmail.com>
References: <1351553513-20385-1-git-send-email-hordp@cisco.com>
 <1352487385-5929-1-git-send-email-hordp@cisco.com> <1352487385-5929-2-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 19:30:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXymF-0002Pd-EJ
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 19:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab2KLSaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 13:30:14 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48604 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab2KLSaN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 13:30:13 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so6543641obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 10:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3ghxTngPp2oJ1VHIMDNv7fOXDKRPi5AtZBp1Jx1KtZo=;
        b=l0Z83x42qJYjoLTJTx+ReH9t7CfNAd4g5xKywZgJtXBHioFJP9msuOAgV9FxnpwSWf
         Pl7bVk/sjWSVmKCMu2RN0buPNfFRoEAY5EfVbApgDorj6QRCJdMsRJn+r3xQqZt0nOjI
         8fhZ+ylrYm0N6lhe6z4C/jKbiQdYuUtbvU3w1GXc6apvzYLn8jVmMJr7jbYao+z3uIIw
         o64fpltAWuupbvEQugmZPo2FNT4Br+bhiMIHKa2EyDQdJVct/59LbUxR2QeGJ83YXKSZ
         Ewd7WG/HaY5NutcxDt6DAMGYlx9Ugk58wrguhn1AaNjaDtXsjs6lNDGtedX7BRnItwF7
         Q8BQ==
Received: by 10.60.170.200 with SMTP id ao8mr15130521oec.104.1352745012380;
 Mon, 12 Nov 2012 10:30:12 -0800 (PST)
Received: by 10.76.168.40 with HTTP; Mon, 12 Nov 2012 10:29:52 -0800 (PST)
In-Reply-To: <1352487385-5929-2-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209508>

Phil Hord wrote:
> Recently git-status learned to display the state of the git
> sequencer in long form to help the user remember an interrupted
> command.  This information is useful to other callers who do
> not want it printed in the same way.

Nit: Please mention that "Recently" refers to 83c750ac to save future
readers the trouble of running blame.

Thanks.

Ram
