From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Be tolerant to repos without .git/remotes/ or .git/branches/.
Date: Fri, 2 Feb 2007 23:03:22 +0000
Message-ID: <b0943d9e0702021503v6ae3851agdf6158eb4a386af8@mail.gmail.com>
References: <20070202225900.30628.17382.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 00:03:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD7RH-0002ei-L2
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 00:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946129AbXBBXDY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 18:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946153AbXBBXDY
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 18:03:24 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:42347 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946129AbXBBXDY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 18:03:24 -0500
Received: by an-out-0708.google.com with SMTP id b33so742376ana
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 15:03:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rqGdTr0hoemGMA5JXHBXG+H3honYIH4v1Bz4l2TgF7ua/4Tc+mhE2w43llp/ogQ9GzeGFbRrl+EesJ433pYE7llEbyq7pZrNjZfJklT5mNyJb8x2Q8ndtoqNjvsN4ao9LFDLrx4ui7Gvx7F8X81jjIW1csE5BylyvE/IyhUWmeg=
Received: by 10.114.132.5 with SMTP id f5mr431544wad.1170457402855;
        Fri, 02 Feb 2007 15:03:22 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Fri, 2 Feb 2007 15:03:22 -0800 (PST)
In-Reply-To: <20070202225900.30628.17382.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38539>

On 02/02/07, Yann Dirson <ydirson@altern.org> wrote:
> __remotes_from_dir() was not robust against non-existent dirs.
> This a Git 1.5 compat issue, since repos do not have .git/remotes any
> more.

I already included the same patch from Pavel Roskin.

-- 
Catalin
