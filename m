From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/9] t7006: test pager configuration for several git
 commands
Date: Tue, 13 Apr 2010 17:07:37 -0500
Message-ID: <20100413220737.GA1676@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
 <20100413021734.GB4118@progeny.tock>
 <4BC4107E.20101@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 14 00:08:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1oGv-0005RA-SD
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 00:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab0DMWHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 18:07:48 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61208 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424Ab0DMWHr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 18:07:47 -0400
Received: by gwaa18 with SMTP id a18so810084gwa.19
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 15:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GsKF8RvSa0aZIcv66T/ypdjidiXYvWiw8uLw6ldUnhw=;
        b=c+fsIZe4b8laqN8y/VMqh/MEXAVFoGfxf7YEEZdw6CgD2xWrsmLcW04/1uMo4kzEaK
         OQ5Z1ujeLJkzRQv+4d31IPedvET/4qpI/9Bdht7eWdsW0QwbQ0PQlEI6XBo4m4CS2XaY
         ivm8eztakbm/ZFgUG69V6YIClm2MvI4ecgu+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jUBtqxwqNDLyx1VHZiHudvcYEXYPIDu1EVlpFt+Hph9aN+MOLqNq9lHBBrZuuMHBke
         M5BIuWLIRGEs60YSsf6Dr99252tEfocr8eniQ+0nFGFurU4xk4AWwS6coub7ILIMWhBg
         j622+FPP+eIRpTT4YmFcB/p1xP9WOL3TTN7kg=
Received: by 10.100.26.37 with SMTP id 37mr11183086anz.72.1271196463347;
        Tue, 13 Apr 2010 15:07:43 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1510952yxe.37.2010.04.13.15.07.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 15:07:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BC4107E.20101@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144834>

Johannes Sixt wrote:

> The intents of the test cases would be much easier to follow and to review
> if this were written as, for example:
> 
> test_default_pager        'git log'
> test_PAGER_overrides      'git log'
> test_core_pager_overrides 'git log'
> test_core_pager_subdir    'git log'
> test_GIT_PAGER_overrides  'git log'
> test_default_pager        'git -p log'
[...]

Good idea.  This would also make the expected result much easier to
change test-by-test.  Will do, thanks.

Jonathan
