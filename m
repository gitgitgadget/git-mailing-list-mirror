From: Ricky Egeland <rickyegeland@linea.gov.br>
Subject: Re: Cleaning up history with git rebase
Date: Sun, 31 Jul 2011 18:44:43 -0300
Message-ID: <317AAE40-449B-4280-AEF1-10EE93FDB9FF@linea.gov.br>
References: <0111E44E-B85F-4C90-8052-E52BA9CD3D17@linea.gov.br> <34ca77f818944acb9f5c6f19d91df73f-mfwitten@gmail.com> <CAMOZ1BvRDSkzJmASNFQvZ-SVBUXZHw6CyfLP4SJqK8CwaMMDUA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Patricia Bittencourt Egeland <pbegeland@linea.gov.br>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 23:44:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qndoa-0001Gr-VG
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 23:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814Ab1GaVos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 17:44:48 -0400
Received: from mx1.linea.gov.br ([200.143.212.2]:43987 "EHLO mx1.linea.gov.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656Ab1GaVor convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 17:44:47 -0400
Received: (qmail 16521 invoked from network); 31 Jul 2011 21:44:44 -0000
Received: from unknown (HELO [192.168.1.103]) (rickyegeland@[189.36.169.239])
          (envelope-sender <rickyegeland@linea.gov.br>)
          by mx1.linea.gov.br (qmail-ldap-1.03) with SMTP
          for <mfwitten@gmail.com>; 31 Jul 2011 21:44:44 -0000
In-Reply-To: <CAMOZ1BvRDSkzJmASNFQvZ-SVBUXZHw6CyfLP4SJqK8CwaMMDUA@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178281>


On Jul 31, 2011, at 6:33 PM, Michael Witten wrote:

> On Sun, Jul 31, 2011 at 20:21, Michael Witten <mfwitten@gmail.com> wrote:
>> Why are there conflicts anyway?
> 
> Oh...
> 
> I guess there were conflicts when the merge commit was made in the
> original repository, and these conflicts were resolved by the merge
> commit itself. Hence, when rebase tries to split up a merge by dealing
> with just the non-merge parents, you end up having to deal with the
> conflict again.

Yes, I thought it was something like this going on, too.  In the pre-rebase history, when there is a commit with "Conflict:" and listing file which is in the sub-repository history, this is a point where rebase stops with a conflict.

> Shouldn't rebase take this into account?

Not sure.  Seems that it does not, it makes me resolve the conflict again.

-- Ricky
