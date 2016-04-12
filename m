From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: 0 bot for Git
Date: Tue, 12 Apr 2016 09:23:32 +0200
Message-ID: <vpq60vnl28b.fsf@anie.imag.fr>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 09:23:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apsfn-0001D1-QK
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 09:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092AbcDLHXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 03:23:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36840 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755962AbcDLHXi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 03:23:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u3C7NVJ4014463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 12 Apr 2016 09:23:31 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3C7NW2m014935;
	Tue, 12 Apr 2016 09:23:32 +0200
In-Reply-To: <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	(Stefan Beller's message of "Mon, 11 Apr 2016 21:29:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 12 Apr 2016 09:23:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3C7NVJ4014463
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461050613.13883@FsuTUU4kWdT46FRvoNozVw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291248>

Stefan Beller <sbeller@google.com> writes:

> Hi Greg,
>
> Thanks for your talk at the Git Merge 2016!
> The Git community uses the same workflow as the kernel. So we may be
> interested in the 0 bot which could compile and test each patch on the list.

In the case of Git, we already have Travis-CI that can do rather
thorough testing automatically (run the complete testsuite on a clean
machine for several configurations). You get the benefit from it only if
you use GitHub pull-requests today. It would be interesting to have a
bot watch the list, apply patches and push to a travis-enabled fork of
git.git on GitHub to get the same benefit when posting emails directly
to the list.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
