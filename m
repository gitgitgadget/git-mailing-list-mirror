From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 resend] bash completion: add basic support for
 git-reflog
Date: Thu, 16 Dec 2010 01:15:28 -0600
Message-ID: <20101216071528.GA3753@burratino>
References: <20101216145608.000004df@unknown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 08:15:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PT847-00088p-3e
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 08:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724Ab0LPHPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 02:15:46 -0500
Received: from mail-yw0-f66.google.com ([209.85.213.66]:64274 "EHLO
	mail-yw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab0LPHPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 02:15:45 -0500
Received: by ywi6 with SMTP id 6so644693ywi.1
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 23:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2zHLfYYJOpKcuqtrFCVMmARP801mxI8OdYXjlwWmrmY=;
        b=r9UXQAUsNghpL9BfL5MqqtXn/32PpZyO32kYtE3Ws0gvXrhmJspcvPjz01JZgrNb8r
         y3naz0VPGE3YVLWmpwWuJjo+ccV6hiL3ujMwyqDpa4YoHPGCe9fImVs/qPsZHxnnITxy
         sJfyOIKSJUdqSogaEpJXGvIViSeYr02Ft8o/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a3BPsrB/iPH0BnHwJ72AOIFHK0LCUatoa+q/UkiXx6n1Lft6Ry+VkjKeYDXgt4o3AL
         V98MH/sqqK2JH1UVKTMXriMxNevyVXx3dNFi4pf8y5PYAyrHF4Cp4i988odaTkuSXMMT
         yTiL8AMAnr+kOCz3G5p3Gz/oDQySGr2zcv3P4=
Received: by 10.236.110.33 with SMTP id t21mr7503316yhg.2.1292483744630;
        Wed, 15 Dec 2010 23:15:44 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id e74sm1303781yhc.5.2010.12.15.23.15.42
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 23:15:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101216145608.000004df@unknown>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163803>

Tay Ray Chuan wrote:

> "Promote" the reflog command out of plumbing, so that we now run
> completion for it. After all, it's listed under porcelain (ancillary),
> and we do run completion for those commands.

Good point.

[...]
> Even get-tar-commit-id (I've never used this before) is treated
> better than reflog.

It's handy from time to time. :)

Thanks, and sorry to miss the point before.  The patch looks good.
