From: Chris Leong <walkraft@gmail.com>
Subject: Re: Git ghost references
Date: Tue, 3 Jan 2012 19:32:22 +1100
Message-ID: <CAJ6vYjd2YLUa82tUrXq+N=7+kdVxH8ryS64mKKkwhA6K+QfcDw@mail.gmail.com>
References: <CAJ6vYjfpx-hfDsd+urp5_iS99p0RhmxohOc+TNv7SUWFnYe5wQ@mail.gmail.com>
 <4F02BAF9.1000206@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jan 03 09:33:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rhznn-0008GN-Su
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 09:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582Ab2ACIcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 03:32:47 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45724 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab2ACIcq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 03:32:46 -0500
Received: by eaad14 with SMTP id d14so8477965eaa.19
        for <git@vger.kernel.org>; Tue, 03 Jan 2012 00:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4ZLUUyUG5b2iAmrQNWGdus5ZAUncxm68mqlj7qBNb4o=;
        b=kn9o1EuZ02aqVg+yCF7cDRgQsJ/alXDM3tc/2MmNmhcPV17WlqFThARp28xXsYwWvh
         UPIfOsxNiA0VRBX3Y+siYOf6Ntte5jg+QKv0P3j+bsD9jO2/Nl4a1fmjRDr4E/zp3bkH
         TjyBjiOB+OwcbTLX9RobklYKDIGDFRI1Ad6Tc=
Received: by 10.205.134.139 with SMTP id ic11mr12275116bkc.114.1325579564486;
 Tue, 03 Jan 2012 00:32:44 -0800 (PST)
Received: by 10.205.139.5 with HTTP; Tue, 3 Jan 2012 00:32:22 -0800 (PST)
In-Reply-To: <4F02BAF9.1000206@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187854>

I did have a production file in my .git and also an empty folder left
in my remotes. Thanks heaps!

On Tue, Jan 3, 2012 at 7:23 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 03.01.2012 00:42, schrieb Chris Leong:
>> I seem to have a "ghost reference" - ie. I can check out a reference
>> that doesn't appear to exist. Does anyone know what might cause this?
>>
>> ~/gaf-cvs (project-membership)$ g show-ref | grep production
>> ~/gaf-cvs (project-membership)$ g co production
>> Note: checking out 'production'.
>> ...
>
> The most likely reason is that you have a ref 'production' directly in
> the .git directory. Perhaps you or one of your scripts created it
> accidentally using 'git update-ref production ae5b621', i.e., without
> giving the full ref path name.
>
> -- Hannes
