From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: fatal: git write-tree failed to write a tree
Date: Sun, 1 Mar 2009 19:23:03 -0500
Message-ID: <81bfc67a0903011623qc1f47fas57c3c8cea2a47eba@mail.gmail.com>
References: <81bfc67a0902280825t507e385bvd25c846add2a299c@mail.gmail.com>
	 <alpine.DEB.1.00.0903012210230.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 02 01:24:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdvxW-0002NK-1n
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 01:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823AbZCBAXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 19:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754962AbZCBAXJ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 19:23:09 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:63525 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbZCBAXG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 19:23:06 -0500
Received: by qw-out-2122.google.com with SMTP id 5so3348655qwi.37
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 16:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6mN1wzV4jg3x4QEEbPIIfCLpA3UpjSymskQ+RwlK/jw=;
        b=WqhG4trFQOMSduCttow24cyX/8TsvcMQVO5M+dQmLqOSs+KOBBbkSfPM3IIqkqZVrB
         aGhxmKPv3IH4kzGbzA4CfJ+qqNwY4dr2Y0OLd0PaT34WE9COya7pO5KJrr7s0xkdJfwM
         B4ubo3+tj8MDGE+7Ndnnak5hypWnypJ3YseQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ai+T16JOl+K0qWmiiM0IlSWzNEGzCvvB5TtaXqgBtcLLvDUOfavaKPjsfU+Q9+a48A
         +V0BtzuNlK8xS9uHa5wulD+BVgIAwsrgnNpZAnbd9qu59ezQV0hScyCc/qVeKsmcXueq
         4OOJU0yVQqmOP3G1Lp4YIa7flnVA+vh4XxTIM=
Received: by 10.229.74.77 with SMTP id t13mr2678635qcj.58.1235953383598; Sun, 
	01 Mar 2009 16:23:03 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0903012210230.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111898>

On Sun, Mar 1, 2009 at 4:10 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> A tree cannot contain unmerged files.
>

I didn't do that, git did. I've tried running git reset --hard HEAD
(and git status shows a clean tree before hand).

so how can I resolve it?

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
