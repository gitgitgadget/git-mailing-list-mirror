From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fwd: Error with git-svn pushing a rename
Date: Fri, 15 Nov 2013 14:53:16 -0800
Message-ID: <20131115225316.GF27781@google.com>
References: <CAM-uYMgy8duxdGY8rbCJv9To3FFMAUDv22nnzbQ+e3QrTCLLpQ@mail.gmail.com>
 <CAM-uYMigCTK=j3HkyT0F=jtDoDERdtkpZiTXRvBhSHJW3edJ-w@mail.gmail.com>
 <CAM-uYMiK4wkQyGJLemSAbNwHJNoH-k8Zv0W2yBtnTCbsFLj8Fg@mail.gmail.com>
 <5285CE6C.2030609@futurelab.ch>
 <CAM-uYMgn4SGqurqRG-RDiicLxpf9NfTPUvNn9FaFUUbxFRJsZw@mail.gmail.com>
 <5286235D.9060602@futurelab.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benjamin Pabst <benjamin.pabst85@gmail.com>, git@vger.kernel.org
To: Andreas Stricker <astricker@futurelab.ch>
X-From: git-owner@vger.kernel.org Fri Nov 15 23:53:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhSGT-0002r7-6P
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 23:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab3KOWxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 17:53:21 -0500
Received: from mail-yh0-f51.google.com ([209.85.213.51]:61069 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab3KOWxT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 17:53:19 -0500
Received: by mail-yh0-f51.google.com with SMTP id t59so2186145yho.10
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 14:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4/HCx0yipDK71JphXlTm4/7I+PQoGdxFnjSRhwubfOM=;
        b=qNw+ZvBhQcwaj04dpSGa9GgzUUs+n3skM9ThuEJgO8UdPbgo7nFYozUHH4cZJGES74
         ybxbykGBI4eVjVTjigcMuCiRP+S4jUz59tfUQb0hmxvWMQeeWO3mt5PllZbbvxWJZdZe
         2kpsU6nOTcqoYbpxOIfdrzaPFpFDtIxFft7gOcndtvIXG1COYdU0do71xWIESVXFeue5
         w0+l4e3zRq517C6IevY3+zZhYbilQ7SdhVd/2ZvX4WvTbp7Ib98R5ei/JVsdOa5E7lcN
         sohaQHL5WXOmUyJ0H77tHhQc+x5ZAgeCnAJ2BOQ1c1PDh2l9AXdshx246ig4Y1O1H7JM
         C0Zg==
X-Received: by 10.236.57.41 with SMTP id n29mr1415500yhc.225.1384555999162;
        Fri, 15 Nov 2013 14:53:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id g25sm8025593yhg.6.2013.11.15.14.53.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 Nov 2013 14:53:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5286235D.9060602@futurelab.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237918>

Andreas Stricker wrote:

> svn, Version 1.7.10 (r1485443)
>
> I tried to reproduce the problem with git version 1.8.4.2 and
> Subversion version 1.8.4 (r1534716) with a fresh and pristine
> subversion repo and a git-svn clone of it: I didn't manage to
> reproduce the rename issue. Then I switched subversion back to
> 1.7.10, created both the repo and the git-svn clone, switched
> againt to 1.8.4.2 and then got an error. Unfortunately I didn't
> check if the subversion perlbindings were regenerated, so I'm
> not exactly sure.
[...]
> It looks like a fresh git svn clone may fix the problem.

Yuck.

Can you give an exact sequence of steps (including "Upgrade Subversion
at this step") to reproduce the problem?  That would help immensely
--- if at all possible, I would very much like to keep existing
git-svn repos working on upgrade.

Thanks for your work so far on this.

Sincerely,
Jonathan
