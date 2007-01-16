From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-show ignores --pretty
Date: Tue, 16 Jan 2007 11:21:36 +0000
Message-ID: <200701161121.38876.andyparkins@gmail.com>
References: <200701161058.15725.andyparkins@gmail.com> <200701161114.07073.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 16 12:21:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6mNu-00084a-Uh
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 12:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbXAPLVp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 06:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbXAPLVp
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 06:21:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:26918 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbXAPLVo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 06:21:44 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1640804uga
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 03:21:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NoBSSsyAZ5q2rIGNebfx1hl/2Bhs9BVq/PIguBGs2/ckcBZcfhP5mE5ThiKE3be8Oe8rdronAXLf5r7Np7U77CFV45zJDmNtud7aw3s7q+vV8pQvw+z+7suwY/5FxSphB3YgxNJHsqe1aUl4FxKvn4/Q1JizlYsNpuxcBo0zreg=
Received: by 10.67.21.11 with SMTP id y11mr7222044ugi.1168946502444;
        Tue, 16 Jan 2007 03:21:42 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id e1sm8407780ugf.2007.01.16.03.21.41;
        Tue, 16 Jan 2007 03:21:41 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <200701161114.07073.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36931>

On Tuesday 2007 January 16 11:14, Andy Parkins wrote:

> You always get the diff, which could well be intended.  Is that the case? 
> If it is, is there a way to surpress the diff?

The answer is "yes"; found in man git-diff-tree (which I'm sure you knew, but 
I'm just terminating the thread in an answer, for the next soul that comes 
looking).

 git-show -s HEAD

Suppresses the diff output.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
