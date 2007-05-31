From: "Dave Hanson" <drh@drhanson.net>
Subject: Re: Breaking up repositories
Date: Thu, 31 May 2007 06:55:15 -0700
Message-ID: <9fb1551c0705310655r234eca96md32ce157b98eff46@mail.gmail.com>
References: <31e9dd080705302350x7752c1f0p3dee2f0d35a97b56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jason Sewall" <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 15:55:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Htl7f-0002Dz-Qh
	for gcvg-git@gmane.org; Thu, 31 May 2007 15:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102AbXEaNzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 09:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756093AbXEaNzS
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 09:55:18 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:55223 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755958AbXEaNzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 09:55:16 -0400
Received: by nz-out-0506.google.com with SMTP id n1so173187nzf
        for <git@vger.kernel.org>; Thu, 31 May 2007 06:55:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=G0SrwDmmkMRBiy4ZzwJZSQ4uK+G2Brt+eYmxYa6IBAMf6gpun5B8G7743JPlr4rCGJE+NIbQ4Df6ECwWCw0hWJ5vYSOcDTzDxBzDfJcg1DGIgZ82F3FJiCBDGPfKTnqx869rn08uNiqJIswKDeDOPmOofsR3ULT1RTfnlX6YyrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=QzwSmCRKHlrPa0J8lwxM094yS3vTPzfFhPrEHT+ngPUz8iWVtUjTxiLOqRtAdjJSL64Mp6sR15JEET7cScpCtQY/XHjXn4b8MuRUcadsT/53ASLZUfEMJwfbEzvKNaxDDXHZeLnOBOjul6gZeyRMWbn8B9n1xDDcj23QWdX8H2Y=
Received: by 10.143.3.4 with SMTP id f4mr30407wfi.1180619715892;
        Thu, 31 May 2007 06:55:15 -0700 (PDT)
Received: by 10.143.10.21 with HTTP; Thu, 31 May 2007 06:55:15 -0700 (PDT)
In-Reply-To: <31e9dd080705302350x7752c1f0p3dee2f0d35a97b56@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 08adb083ba92e511
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48811>

I had similar problem; I split my monolithic repo, monolithic-git, as follows.

1. When I did the git-svn, I ended up with git branches for each
project in my svn repo. I think I created these by hand, but I don't
recall.

2. To split project foo into its own repo, foo-git, from monolithic-git, I did:

mkdir foo-git
cd foo-git
git init
git pull ../monolithic-git foo

>From then on, I worked in foo-git. Eventually, I pitched
monolithic-git. I suspect there's a better way to do this...others
will surely chime in.
dave h
