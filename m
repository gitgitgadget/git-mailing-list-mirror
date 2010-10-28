From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Detect merge/rebase conflicts without changing the worktree?
Date: Wed, 27 Oct 2010 19:01:15 -0500
Message-ID: <20101028000115.GC30490@burratino>
References: <AANLkTikuyGcK-j_hT2WxJiYVX784nPehZS8=F05N_eGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 02:08:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBG2u-0004mc-RH
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 02:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757542Ab0J1AIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 20:08:39 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56029 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388Ab0J1AIi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 20:08:38 -0400
Received: by ewy7 with SMTP id 7so1203282ewy.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 17:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wNOfbXpGgN3RZKkM8aoM0bD9FvmmPLl/YbLPaAFiv5k=;
        b=mI7XYzcPg+tvarBnUkB/PqafcgJU9BVT1Fu9pzB54s4ynXPARbN/r+CI4h/9nh4oL7
         OW5d+WuJVBKX5w2iHVLLRXp69X33wkigT+RR4vv6Mmvtb5eTK3aD6vLiskJAVWe03uRF
         r4GQGK+HcY/e507nIENbuPHP43N4Ys4nTALYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZnrzkhP3Ix43x7BpEi3RR6tXlWREwsY2uu3zEgUwdZRloBHhpWaLBY2z68O1z9JL0F
         054cvzkDNkbMc8DHnj9AdDZbW6PbU1y3hximULKOKkv6WZecY9ALBDYn7bL6Kx3NbPfs
         P5Kpun8u3MdEbACLekh49dZsQfNQlyD49+458=
Received: by 10.14.37.10 with SMTP id x10mr8204278eea.30.1288224081831;
        Wed, 27 Oct 2010 17:01:21 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q58sm299130eeh.9.2010.10.27.17.01.20
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 17:01:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikuyGcK-j_hT2WxJiYVX784nPehZS8=F05N_eGQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160138>

Hi Klas,

Klas Lindberg wrote:

> What is the recommended way to detect merge/rebase conflicts without
> actually modifying the worktree?

You might like "git merge-tree".
