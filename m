From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Recover broken git repository?
Date: Tue, 14 Jul 2009 16:54:32 +0200
Message-ID: <20090714145432.GA12928@vidovic>
References: <1247577632053-3255106.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Breitwieser <florian.bw@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 16:54:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQjP3-0007dL-Hy
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 16:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbZGNOyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 10:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbZGNOyj
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 10:54:39 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:57693 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbZGNOyi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 10:54:38 -0400
Received: by ewy26 with SMTP id 26so3332774ewy.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=P4LwN0dbgxnqee7Kgrht1WaeszGaiWTKrqqR4IiguGc=;
        b=VItoA3004KARFjCzNb6XFLVYb/9J0olKpoK6s9+3+HYoA0FV7SJJr2Lvdw/fyf12JU
         HcvA5aiCTEUOCckqTuFqCnLDwuZFAPa5wvP166Vr7Ww95Ekg4EZ8hFosiaGsvCU/scSv
         bkQA9nYyc4bmVvTfFCjAT1GHbfdLNWfTmqS28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xQN6zaN/rpuDR5Alm7IM+DhSJXbWYVuIDtjuvz5z3pKGWltbBv31syxGzS/y3ZST+6
         9i9WxjcscOjzoG1+c6Cik3ASOoZ2K61u1d3kfqL+ccJdaHGld+6uT2PK24iHxeK3MTRn
         1P/k2QugLutemDa+KJrUk22eIlh9PQimu27Gk=
Received: by 10.210.16.11 with SMTP id 11mr1049618ebp.22.1247583276693;
        Tue, 14 Jul 2009 07:54:36 -0700 (PDT)
Received: from @ (ABordeaux-258-1-25-153.w92-134.abo.wanadoo.fr [92.134.144.153])
        by mx.google.com with ESMTPS id 28sm4484351eye.39.2009.07.14.07.54.35
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Jul 2009 07:54:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1247577632053-3255106.post@n2.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123253>

The 14/07/09, Florian Breitwieser wrote:

> I have problems with my git repository, attached below are the steps I tried
> to resolve it. But now I am stuck. Is there any good way to recover?

You could git-format-patch your topics, clone a new repo and git-am the
patches.

-- 
Nicolas Sebrecht
