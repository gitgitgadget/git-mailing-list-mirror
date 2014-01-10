From: Dan Kaplan <dank@mirthcorp.com>
Subject: Re: A question about the error: svn_fspath__is_canonical
Date: Fri, 10 Jan 2014 11:22:13 -0800
Message-ID: <CABRpx=3vf-bwtA8_2ndPYo+fWCNiHQdSbLRGFWts4Wp3uN6yDA@mail.gmail.com>
References: <CABRpx=1CvB55zeL1L8QOvyfbJCaG9FK+HEz-iK9cFGrnxmOJtg@mail.gmail.com>
	<20140110191650.GF4776@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 10 20:22:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1heu-0001xs-Qb
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 20:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479AbaAJTWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 14:22:17 -0500
Received: from mail-qc0-f171.google.com ([209.85.216.171]:62207 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757244AbaAJTWP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 14:22:15 -0500
Received: by mail-qc0-f171.google.com with SMTP id n7so2772693qcx.2
        for <git@vger.kernel.org>; Fri, 10 Jan 2014 11:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirthcorp.com; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PGhIKAG61zAEOJd2ye+53vr6ZYJDl0/7fTyYf8JVMGo=;
        b=gt4n2Y4ei+jh7QQ0HGcycl6LKkiroQ1SXdNIJ6sb+on2yd8Rt2u1TND2PGLonWEGFI
         c2mIuBKc3+adVi1z65vs5hdMGWIqz9njM/QKa1JdeN7mAi8ZkOnbxzFjHRx3jpKWYilU
         Vnp1jrK8QnZD08bfZD8w/mnR80wqQ6135I+Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=PGhIKAG61zAEOJd2ye+53vr6ZYJDl0/7fTyYf8JVMGo=;
        b=QVJ3R+JblBjKskVVxzWlu22g+1UqrDQzSflaJqJDTPSgeGpl5EnS22vATxuOgfU19f
         Af8c0QCafYECr6RHoeEKzrGAVIz2QvQJUSOFsHe+NkFOQRYpy5fwj1hZiba2KdOLLKqr
         LHjAdrCLeVCNNEgSvUw/a1vea8Ww74s451byiswktWNapXbLH7eBvPFWDBhp11THPaHR
         iyZjhjpgwgtQDL9TlYAsPmxycugIvDtNtRU6px2Hs/7O28W3Q/6gvcCGSVMzpHXl5S3G
         evkXxrl1NtrU9pNPZYHhO7suqLJEnBJ+7mW7zaQkBeRyGP5IBq4mtN1EploR4mDrYuKL
         HJbA==
X-Gm-Message-State: ALoCoQkE49p9TgrO7u9caLugj7th3woBeGdVjCOlpS1WnrwaplNNJ9J8UCt+Nz65qEd3NRjQYKNqMQERo0aJtA+txiohY/JrIa6Zt5UrSs2rDKuKACG7rkE=
X-Received: by 10.49.104.210 with SMTP id gg18mr10711154qeb.54.1389381733965;
 Fri, 10 Jan 2014 11:22:13 -0800 (PST)
Received: by 10.96.76.5 with HTTP; Fri, 10 Jan 2014 11:22:13 -0800 (PST)
In-Reply-To: <20140110191650.GF4776@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240310>

Because I'm on cygwin, that's a little intimidating to me.  I've never
compiled sources on cygwin.  Do you think it'll still work?

On Fri, Jan 10, 2014 at 11:16 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Dan,
>
> Dan Kaplan wrote:
>
>> My environment is probably different from most.  I'm using cygwin.
>> This makes it very difficult to use different versions of
>> git/svn/git-svn, but I'm interested in learning git more so I'm
>> willing to try whatever it takes.
>>
>> $ git version
>> git version 1.8.3.4
>>
>> $ svn --version
>> svn, version 1.8.5 (r1542147)
>>    compiled Nov 25 2013, 10:45:07 on x86_64-unknown-cygwin
>
> You have three choices:
>
>  A) upgrade git to latest "master"
>  B) upgrade subversion to latest "trunk"
>  C) downgrade subversion to a version before that bug was introduced
>
> (A) is probably simplest.  E.g., something like the following should work:
>
>   git clone https://kernel.googlesource.com/pub/scm/git/git.git
>   cd git
>   make -j8
>   make test; # optional, to verify that the git you built works ok
>   export PATH=$(pwd)/bin-wrappers:$PATH
>
> Now the updated git is in your $PATH and you can use it.
>
> See INSTALL in the git source tree for more details.
>
> Hope that helps,
> Jonathan



-- 
Thanks,
Dan

-- 
CONFIDENTIALITY NOTICE: The information contained in this electronic 
transmission may be confidential. If you are not an intended recipient, be 
aware that any disclosure, copying, distribution or use of the information 
contained in this transmission is prohibited and may be unlawful. If you 
have received this transmission in error, please notify us by email reply 
and then erase it from your computer system.
