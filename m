From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: get upstream branch
Date: Tue, 9 Dec 2008 10:25:09 -0500
Message-ID: <eaa105840812090725p6158697au2177e0de3d4e5966@mail.gmail.com>
References: <3ab397d0812082052j6a45d05dr1c863aa260826f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 16:27:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA4Tw-00079j-3j
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 16:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbYLIPZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 10:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbYLIPZO
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 10:25:14 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:30918 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbYLIPZM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 10:25:12 -0500
Received: by ti-out-0910.google.com with SMTP id b6so4198tic.23
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 07:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=boWXFnD742G7HqAhdMDdRyiLJC1E4xnK1tCRmSmrvEU=;
        b=ZJC6CxRmvARWdGoJLXR2IWJbc3A7RQPBrxqwL2Ckgb6hQDqBK7ApCBZJayAx+xg5cA
         SIWU5tKfhjKfa5PTdo8QwOV+tKypld9jP6z26x2Y3WKGn8lI9JBAIbISuP4ZMYmT94ci
         lA+/5WmUPgOYw6V0h+wggHK0VnRX+hvJFwhYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=gsKNJvOxQw/IAhcchy7eHu4dk1GhzlFOddjabX2OX9G+G1I0ILsyhwgQrk7gFfZ+ly
         8+ZBsGvNBIJbgMLIfJpW52O+xw4y+ss3fLhqaNGKNG8CVfCLjA6zbyU6IuYARCVmwJ76
         oIls1JmSv+N4qqNSbyIMvnzbELRI1XLB39tuk=
Received: by 10.65.15.11 with SMTP id s11mr202823qbi.49.1228836309934;
        Tue, 09 Dec 2008 07:25:09 -0800 (PST)
Received: by 10.65.230.19 with HTTP; Tue, 9 Dec 2008 07:25:09 -0800 (PST)
In-Reply-To: <3ab397d0812082052j6a45d05dr1c863aa260826f4@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: e3b9557c899d0be6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102634>

On Mon, Dec 8, 2008 at 11:52 PM, Jeff Whiteside wrote:
>
> Does anyone know how to programmatically get the upstream/parent
> branch of a branch?  I'm trying to write a gui, but looking at gitk's
> tcl code isn't helping me much.

Would C++ code be a better help?

qgit is somewhat similar to gitk:
http://digilander.libero.it/mcostalba/
git://git.kernel.org/pub/scm/qgit/qgit.git
git://git.kernel.org/pub/scm/qgit/qgit4.git

Peter Harris
