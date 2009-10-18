From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 2/3] DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Sun, 18 Oct 2009 19:34:48 +0900
Message-ID: <20091018193448.6117@nanako3.lavabit.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
	<alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
	<7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
	<7vaazpxha4.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 12:35:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzT6S-0007Jg-7p
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 12:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbZJRKez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 06:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbZJRKex
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 06:34:53 -0400
Received: from karen.lavabit.com ([72.249.41.33]:44748 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbZJRKev (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 06:34:51 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id C101B11B8D1;
	Sun, 18 Oct 2009 05:34:56 -0500 (CDT)
Received: from 7574.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id 3L4Z0D6UI128; Sun, 18 Oct 2009 05:34:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=dF5K96I4tAX/Mos/qPKxADMtEVMAzqfGuSR1l1XbM/z7LQ6GgOwWn0lSOxB41/bRjazxxdqwq/I3A1NTLvRd4X6NjHd/xC6HPPJvblULishTeQ1Ehk+t1AH/4QdiYU1VEVry+hqPWQ7sPmvahyRzsg5fuao1UuEt3dHzwZa4YaM=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vaazpxha4.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130592>

Quoting Junio C Hamano <gitster@pobox.com>

> When 'frotz' is not a valid object name nor a tracked filename,
> we used to complain and failed this command.  When there is only
> one remote that has 'frotz' as one of its tracking branches, we can
> DWIM it as a request to create a local branch 'frotz' forking from
> the matching remote tracking branch.

In the subject you used 'git checkout -b frotz origin/frotz'. Did you forget to say '-t'?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
