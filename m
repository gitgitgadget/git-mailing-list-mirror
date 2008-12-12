From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Fri, 12 Dec 2008 23:08:39 +0700
Message-ID: <fcaeb9bf0812120808y656c0c6bx9d1c44ea00aeb7b9@mail.gmail.com>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
	 <alpine.LNX.1.00.0811301509070.19665@iabervon.org>
	 <fcaeb9bf0812060926r2ee443bfl3adb3f2d1129e5b8@mail.gmail.com>
	 <alpine.LNX.1.00.0812061238260.19665@iabervon.org>
	 <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com>
	 <alpine.LNX.1.00.0812071455020.19665@iabervon.org>
	 <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com>
	 <alpine.LNX.1.00.0812081223140.19665@iabervon.org>
	 <fcaeb9bf0812110504u1acfb612he3edae1df3774045@mail.gmail.com>
	 <alpine.LNX.1.00.0812111520490.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 17:10:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBAaV-00035F-NG
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 17:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757407AbYLLQIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 11:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757538AbYLLQIm
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 11:08:42 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:2168 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757133AbYLLQIl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 11:08:41 -0500
Received: by fg-out-1718.google.com with SMTP id 19so732424fgg.17
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 08:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+VCflO+rYnTEk/basX2cf5Rkx/i6hDHCzbprEid86vA=;
        b=Tsg/XvAZDb3hcaPdj0tOIklT02Y89ew521FlIgmfITUT0VA1Aa2VP5oJF9TKeysyYf
         4ZjPHyQQQrAn9D8iM4muhDUPgj5IGyNaJwMGXwj7Wt/zndMFtl5C0p30Fy9Yi5XIO1hq
         MpJ6hSho4XiyNbf9xPEShFVu9fwhVy78ZpOtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Mxbb+D721BMPF/njiB0e0gYTIU9CDGWkAUqUmvDIS2Q2We1X+m5x+rxcx3vFP65vGM
         XqGgFfNdRr+gFmLOa1lljX0XbaZ7Cm6eqBjFsdyMFzpMiRDBwt2V9NcWOyBz5+vK9jGC
         +O6ULLwuuJAQsGnmVIht8FKHokFx3icxavOVY=
Received: by 10.86.4.14 with SMTP id 14mr2099974fgd.27.1229098119554;
        Fri, 12 Dec 2008 08:08:39 -0800 (PST)
Received: by 10.86.87.14 with HTTP; Fri, 12 Dec 2008 08:08:39 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0812111520490.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102910>

On 12/12/08, Daniel Barkalow <barkalow@iabervon.org> wrote:
>  > Well, if you set core.defaultsparse properly, those files should
>  > appear/disappear as you wish (and as of now if you define your
>  > checkout area with "git checkout --{include-,exclude-,}sparse" then
>  > core.defaultsparse should be updated accordingly). I don't say
>  > core.defaultsparse is perfect.
>
>
> Right, so in order to get reasonable behavior, the user must use
>  --{include,exclude}-sparse. I think that this should be the *default*
>  behavior, and probably the *only porcelain-supported* behavior, because
>  otherwise it's confusing.

It's pretty hard (or intrusive) to enforce such behaviour. How about
showing files that does not match core.defaultsparse in "git status"
along with instructions how to add them to core.defaultsparse? That
way people can keep it consistent and less modification to current
code.
-- 
Duy
