From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Mozilla version control requirements and git
Date: Sun, 3 Sep 2006 13:19:41 +1200
Message-ID: <46a038f90609021819v6d427f0eh69bc13b30ef6b692@mail.gmail.com>
References: <9e4733910609020731k25ce3a0aw7a84542f8cd516f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 03 03:19:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJgeQ-00069s-Vy
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 03:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbWICBTo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 21:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWICBTo
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 21:19:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:42272 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751828AbWICBTn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 21:19:43 -0400
Received: by nf-out-0910.google.com with SMTP id o25so834077nfa
        for <git@vger.kernel.org>; Sat, 02 Sep 2006 18:19:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LLKANwfy8CGGaHQvALQHlnxA0EXUrCKXXB79stti5re3Aa8K9JXr14yfZ8cwlho9n0tpb/MfFxUAZ49LfWRgbkTj92ivQiXjJ4c0ijF1/tRMGFAettCvSTb8neuS/7SNY7wHcKaymbJIErlAzYlqa/GbfiSwC6nXaagidu+FUYI=
Received: by 10.49.8.1 with SMTP id l1mr4832428nfi;
        Sat, 02 Sep 2006 18:19:41 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Sat, 2 Sep 2006 18:19:41 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609020731k25ce3a0aw7a84542f8cd516f6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26361>

On 9/3/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> The Mozilla people have a web page describing what they are looking
> for in a new version control system. How does git stack up?

Hi Jon,

you've been playing with GIT quite a bit by now, so I guess you know
the answer ;-) Is there anything in particular you are wondering
about?

The one item that sticks out for me as not there is ACLs, but access
controls can be implemented in hooks for direct pushes. Maintain an
.htaccess-like file and have a perl script to check it on pushes to
the repo.

Oh, and "partial tree pulls for localisers". Perhaps git-cvsserver can
help there? Localisers can just use TortoiseCVS and get a checkout of
the language pack subdir.

cheers,



martin

-- 
VGER BF report: U 0.544429
