From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-svn and local only topic branch
Date: Tue, 1 May 2007 19:29:51 +0100
Message-ID: <200705011929.57466.andyparkins@gmail.com>
References: <8b65902a0705010940pb3bfb16u624d470068351624@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 20:30:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hix7F-0000vl-D3
	for gcvg-git@gmane.org; Tue, 01 May 2007 20:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbXEASaQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 14:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbXEASaQ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 14:30:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:41861 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbXEASaN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 14:30:13 -0400
Received: by ug-out-1314.google.com with SMTP id 44so102603uga
        for <git@vger.kernel.org>; Tue, 01 May 2007 11:30:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Fr3gu7fSxkhIsB2n5AeGh3POHG1YuZJWe4gbPYDmue2kESpGe6kJaTfb0CtjiWeJgnK69ueL9+2uz0ewgQGZVCFbObc65opT2vTq4sxxN11EujZrsWklQdzzC/M3wR+CTTh7SQf9SppMWoKr3e7guDIFiBpU7F5PQBHFgQ/JrsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=D8txFXHfMtkXkF5B8D31WNjWMTBg7CkzSkWx0bI450uY5LF0gF0UJ3SIGVT15RSu2/smKbkG+5keVdI8x9PKjsr0uzOcz8Y4PVjOPZxnblxsPhTG3kpw9Oa9FwEGkazhL//raru7I5KU/CvgIcFn8xDYtpyIDbz7Cdrz73mHqqM=
Received: by 10.67.40.12 with SMTP id s12mr511911ugj.1178044211633;
        Tue, 01 May 2007 11:30:11 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id e1sm69649ugf.2007.05.01.11.30.08;
        Tue, 01 May 2007 11:30:09 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <8b65902a0705010940pb3bfb16u624d470068351624@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45967>

On Tuesday 2007, May 01, Guilhem Bonnefille wrote:

> o--o--o--o (upstream, remotes/upstream)
>          \
>           o--o--o--o (topic)
>
> Is there a way to do what I want?

No.  Subversion doesn't do merge tracking.  What you're asking for would 
require that.  While git-svn is good, it cannot give subversion 
abilities it doesn't have.

It's an easy trap to fall into because git makes it so easy that you can 
forget that not everyone else can do it.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
