From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Standardize python shebangs
Date: Wed, 07 May 2014 06:11:53 -0500
Message-ID: <536a14f9de982_675a167130cb4@nysa.notmuch>
References: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com>
 <CALKQrgc=Xa767S8ZTTYnXjHTfLOg_fDG+aT4cVqpvx4HMhO03Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 13:22:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whzvy-0004TR-L9
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 13:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbaEGLWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 07:22:42 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36221 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187AbaEGLWm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 07:22:42 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so986542obc.18
        for <git@vger.kernel.org>; Wed, 07 May 2014 04:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=IJq1OEm8/mejAGJlCRAZ42EK4e2Bz0YzSNSLOpHY7pM=;
        b=FAR3+eSCuXpf/G512DeQp/1OuOJgPVh7AJdz7xa4yVfe0AqfYm+fWnMxIlVwtEbFDd
         dwQco/5/5jfPCpHANp6eJU2ku6o5p1BSDFuBt79HdQolY+B8G/MVn8W9dCPinvUWB++u
         PtbavBgA7XH7k64CNJD8Wr/WVObd3hImxmgZH6R8qtmA3Tal1UoEW4CatPkK4lb90uK7
         sqAQ3cAV4/TQ4vV/j+1c3MZXSr1EFtjeSuEfnBO/cLaTxAwso3I0FNMEOFvWS5lfxRxG
         uIqcKav/SBfBWDlsFuLidVqbmiM3ZnUn58E9FVDD1q7Nn0pEuhXVg0KuBWuoJvZ5y6mn
         x0/Q==
X-Received: by 10.182.78.100 with SMTP id a4mr14790717obx.56.1399461761570;
        Wed, 07 May 2014 04:22:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 10sm33826540obq.18.2014.05.07.04.22.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 04:22:40 -0700 (PDT)
In-Reply-To: <CALKQrgc=Xa767S8ZTTYnXjHTfLOg_fDG+aT4cVqpvx4HMhO03Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248296>

Johan Herland wrote:
> On Wed, May 7, 2014 at 12:03 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > It's better if all our scripts use the same '/usr/bin/env python'.
> 
> Only if they are source compatible with both Python2 and Python3. See
> PEP394 <URL: http://legacy.python.org/dev/peps/pep-0394/ >. Otherwise
> (for python2-only scripts) '/usr/bin/env python2' is the way to go.

It doesn't matter. People and aistributions have to change them anyway.

-- 
Felipe Contreras
