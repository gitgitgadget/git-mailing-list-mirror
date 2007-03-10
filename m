From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-log --full-history renamed-file
Date: Sat, 10 Mar 2007 06:14:02 +0000
Message-ID: <200703100614.04526.andyparkins@gmail.com>
References: <87lki6umts.fsf@rho.meyering.net> <7v8xe53ok5.fsf@assigned-by-dhcp.cox.net> <est24q$p4n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 07:17:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPutE-0003jd-L1
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 07:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767828AbXCJGQx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 01:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993183AbXCJGQx
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 01:16:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:60907 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993179AbXCJGQw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 01:16:52 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1586750uga
        for <git@vger.kernel.org>; Fri, 09 Mar 2007 22:16:51 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lMMV9HmfH7+93hvreLA86pZQCzlRemlnqzCAQqxZRS43AL2Bi9eHiM2/i8uEA6Zn05pj3ckyG0vx/WIsoqSPc0HeBssMtazwg8jfZf3NmJNJxN45Tg5XmWuICHf6to5PI7T97GGiGz5u6Ivwy3amFZ/gKlMe2Z5ldjvJOR3xLmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Wcbp4RX7TWHhCnQz01Jvs4NQPy+6TyTB+APQVRrWRbvVuzxlNiv/YGii+rLT/4wrNm5+9htw9JAju5rsi2VScA3SjhFofD++W4rco2DH6ADrICYsVGWS7KLaPgdajGNVZzxnBE661thokfM3/G4jnJG1q7wLHUVGuKmFkQkHbVE=
Received: by 10.67.101.10 with SMTP id d10mr11390215ugm.1173507411556;
        Fri, 09 Mar 2007 22:16:51 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 24sm5358515ugf.2007.03.09.22.16.50;
        Fri, 09 Mar 2007 22:16:51 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <est24q$p4n$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41852>

On Saturday 2007, March 10, Jakub Narebski wrote:

> By the way, while it is fairly easy to follow one file, it is hard
> to follow directory or glob... and there is a trouble that one file
> might come from two files (as concatenation for example; but I don't
> think git can detect it with default values of rename detection
> heuristics).

That's not rename detection then though.

I know git is clever and has potential to be able to do rename detection 
even when it was rename-and-modify.  For me though, I always like to 
make the job of the VCS easier by doing the rename in a separate commit 
from the modify.

I'd really like it if git would deal with the easy, 100% rename case, 
even if it didn't deal with the 
rename-two-files-to-be-one-file-and-modify-the-result case. 



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
