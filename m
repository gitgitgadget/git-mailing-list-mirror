From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 0/2] teach am and rebase -q/--quiet
Date: Sun, 14 Jun 2009 00:16:32 -0700
Message-ID: <4A34A3D0.9020407@gmail.com>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com> <7vfxe3vil9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 09:16:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFjxL-0003WZ-7V
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 09:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbZFNHQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 03:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbZFNHQe
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 03:16:34 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:15268 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbZFNHQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 03:16:34 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1208659wfd.4
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=1q77chhGRoEyf3K8ZoAzt/62pNlso7A7HTO7u0Jy5d0=;
        b=AW4m/0qkoZx6SHCtPwyzSWvvqT7oRSWSQkdCTApRCxl7rZMdEepJi+BsTQGWSh/+t8
         LyIuDkLCB+y15OLH+tUTN0MFZbwd/etNwtXEDt1iy0DdTh5lFjRGCtHr5XWtPh7ELB/a
         7MdhhXNPxAPcx7e8JLP4qINlDB905UFrTEeCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=U7tSD60KEwIuxgnw6QjRPKzIwjMet3s5ynoOHQR5fU4lsrkZdCNT1hFkmfhTE3HyAt
         UGbwvcASFoHbrYKaaxyzNFRpmLpfCYlShM78GDQnbiUGQxhHa9o4KN/FLC/h4YDkZxiE
         zbmrzeijwZugHd8jPdNaBmcAw1QxEejE6Wpik=
Received: by 10.142.147.15 with SMTP id u15mr2277816wfd.47.1244963795601;
        Sun, 14 Jun 2009 00:16:35 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id 30sm5280026wfd.21.2009.06.14.00.16.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 00:16:34 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <7vfxe3vil9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121541>

Junio C Hamano wrote:
> Perhaps you would want to do the same for "stash apply/pop" that runs "git
> status", listing untracked files and whatnot?

This sounds fine for a follow up, or even a v2. I'm curious though,
would adding say() to git-sh-setup be a good idea? Otherwise I'll be
adding a say function another time.
