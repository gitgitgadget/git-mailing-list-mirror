From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH(amend)] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 23:25:03 +0700
Message-ID: <fcaeb9bf0703110925j6518a52ex68fad8f23a55e5c@mail.gmail.com>
References: <20070311043250.GA21331@moooo.ath.cx>
	 <fcaeb9bf0703110542t49bb3e77kb164ba7bfee1a6ed@mail.gmail.com>
	 <20070311155649.GA29663@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Matthias Lederhofer" <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 17:25:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQQr9-0001Ck-7J
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 17:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933808AbXCKQZH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 12:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933811AbXCKQZH
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 12:25:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:7772 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933808AbXCKQZG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 12:25:06 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1934521uga
        for <git@vger.kernel.org>; Sun, 11 Mar 2007 09:25:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a5pg4gECnaT2B36Un6zYr7/CqMaHhM6zRWLnwmbvAK4XQjwviEqo8karPRRwV6eUhejKuSZYlnkt/+e/OE2iJght3wH26UDWLSDFYOz0Np9IXBxUo2boyLqxM/X2H0WuU24jMrBtN2ZR6M5AK0YnhkV/4OIvNqA4zpcZu1qx7CM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lIh0Fkjjm+TSQWRooLhUhMyyrDR4ywnoavIQDxYroZZt5pvNCqPUucQVqgIkmt+C5bgbJeAnuLQbqRfHc/FFXrI18NjIsHrr0rvk6nSTLBg2tp5fZ0SQpqL4qIGbSTUJdCkxrQnYTliZMDKtexmsAWztu5uqNb9fZ5r89Apy9Oo=
Received: by 10.115.88.1 with SMTP id q1mr901413wal.1173630303613;
        Sun, 11 Mar 2007 09:25:03 -0700 (PDT)
Received: by 10.115.19.15 with HTTP; Sun, 11 Mar 2007 09:25:03 -0700 (PDT)
In-Reply-To: <20070311155649.GA29663@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41939>

On 3/11/07, Matthias Lederhofer <matled@gmx.net> wrote:
> This environment variable can be used with GIT_DIR to
> specify the toplevel working directory.  When GIT_DIR is not
> set this variable is ignored.  As for GIT_DIR there is also
> the option git --work-dir which overrides the environment
> variable.
>
> Signed-off-by: Matthias Lederhofer <matled@gmx.net>

Works for me.

-- 
Duy
