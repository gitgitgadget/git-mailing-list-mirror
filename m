From: Ian Wienand <ianw@vmware.com>
Subject: Re: git to p4 conversion
Date: Thu, 03 Feb 2011 10:23:26 -0800
Message-ID: <4D4AF29E.7070509@vmware.com>
References: <AANLkTi=0TSD6p7WtsVzx=pq8=GVu+jHUdxt1bnC++CT+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Endre Czirbesz <endre@czirbesz.hu>
X-From: git-owner@vger.kernel.org Thu Feb 03 19:23:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl3q9-0003so-GA
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 19:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292Ab1BCSX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 13:23:27 -0500
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:11004 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756418Ab1BCSX0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Feb 2011 13:23:26 -0500
Received: from mailhost3.vmware.com (mailhost3.vmware.com [10.16.27.45])
	by smtp-outbound-1.vmware.com (Postfix) with ESMTP id A1CAF134B5;
	Thu,  3 Feb 2011 10:23:26 -0800 (PST)
Received: from [10.20.123.85] (coopers.eng.vmware.com [10.20.123.85])
	by mailhost3.vmware.com (Postfix) with ESMTP id 542B7CDA12;
	Thu,  3 Feb 2011 10:23:26 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Iceowl/1.0b1 Icedove/3.0.11
In-Reply-To: <AANLkTi=0TSD6p7WtsVzx=pq8=GVu+jHUdxt1bnC++CT+@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165988>

On 03/02/11 05:52, Endre Czirbesz wrote:
> I have some small (and flat) git repos, which I would like to migrate
> into a perforce depot keeping their histories. I tried git-p4 without
> any success, and I did not find a good manual for it.

What exactly did you try?

Theoretically, you could clone your new, empty, company-mandated p4
tree into a fresh git repo, get your existing code onto a new branch
in this fresh repo (it's already in git, right, so that should be
easy), then use 'git-p4 submit' to submit that branch back to p4.

> Is there any step-by-step tutorial out there? Is there any living human
> who ever made a successful conversion in this direction?

I'm not aware of an existing tutorial for this, sorry

-i
