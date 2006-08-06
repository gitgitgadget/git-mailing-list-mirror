From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: GPF in index-pack
Date: Sat, 5 Aug 2006 22:44:11 -0400
Message-ID: <9e4733910608051944v5af7e552wd6909b9773dd516e@mail.gmail.com>
References: <9e4733910608051805j1192d910hf55393f1dbe1e472@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 06 04:44:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Yck-0005TQ-EN
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 04:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWHFCoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 22:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWHFCoM
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 22:44:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:35964 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751482AbWHFCoM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 22:44:12 -0400
Received: by nf-out-0910.google.com with SMTP id k26so71058nfc
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 19:44:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q7/Kk55tLyau/4gt+LNlGgZQiJmedsyuk4jwxvSs1f6/E2fXoRKHM54GoI08D/izojhHdn0Tly8Ehur4a+vP39xtEVxTGXBrzCEmU8RHZNMdY9hDDVh24f3IXSuSW+BwsBTFhDziQYkiIs8NOukP41eZd0NNLefktN3+H30lhSk=
Received: by 10.78.158.11 with SMTP id g11mr2026679hue;
        Sat, 05 Aug 2006 19:44:11 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Sat, 5 Aug 2006 19:44:11 -0700 (PDT)
To: git <git@vger.kernel.org>
In-Reply-To: <9e4733910608051805j1192d910hf55393f1dbe1e472@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24952>

Process size is 2.6GB when the seg fault happen. That's a lot of
memory to build a pack index over 1M objects.

I'm running a 3:1 process address space split. I wonder why it didn't
grow all the way to 3GB. I still have RAM and swap available.

-- 
Jon Smirl
jonsmirl@gmail.com
