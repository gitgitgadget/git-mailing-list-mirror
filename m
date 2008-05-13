From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: git pull/merge master on other branch
Date: Mon, 12 May 2008 20:12:14 -0700
Message-ID: <94ccbe710805122012t5ef9f8bev502e1933f2f8a8da@mail.gmail.com>
References: <g00nb3$dlm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "SungHyun Nam" <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 05:13:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvkwu-000409-Rm
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 05:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261AbYEMDMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 23:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754953AbYEMDMP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 23:12:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:64950 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261AbYEMDMO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 23:12:14 -0400
Received: by wa-out-1112.google.com with SMTP id j37so3847824waf.23
        for <git@vger.kernel.org>; Mon, 12 May 2008 20:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=1HpNOih3jALUIhXw6Uv9RMF4RgYLb3qpFodVzQHfy/A=;
        b=YbbV83dD46Jvd0JPiNnL0xgssJw2vz5yxm2S0p/oFoJ6uWONDLzuQTwp17vHfU3Ej3msbohE4JJmdACqm0IafIXOQBCkh30hbbJhrhkiDMVbpPK+2nozpO9dPRKR/yiuZ2R40H3xkd+vzDJKRt/BEXOZtJJkAaM6Nl3ZERPrmeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=SJfL37KEovQUAJ2Zye+E49DaJ7JtWe4bWCdKlwAffPbQ1mHCcyAdycjpG4GxETc29kC/58NBBfMiEWSthf3AdrEfiBrJoh6U40SH6Ip1OIWiqQGLpnjdafUo+wfWiJT1AJ5dxrGsypNQblqerU6Jr1CFHT7ltUxsGGmMyjkO6MI=
Received: by 10.114.156.1 with SMTP id d1mr8561842wae.120.1210648334224;
        Mon, 12 May 2008 20:12:14 -0700 (PDT)
Received: by 10.114.81.12 with HTTP; Mon, 12 May 2008 20:12:14 -0700 (PDT)
In-Reply-To: <g00nb3$dlm$1@ger.gmane.org>
Content-Disposition: inline
X-Google-Sender-Auth: 06a017d951489f0b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81983>

On 5/8/08, SungHyun Nam <goweol@gmail.com> wrote:

>  How I can pull origin into master without switching to master
>  branch?
>
>  Thanks,
>  namsh
>

To do this, one would use the "push" subcommand, with "." as the repository.

git push . origin/master:master

I could have sworn I answered someone the exact same thing a while ago...
-- 
Kelvie Wong
