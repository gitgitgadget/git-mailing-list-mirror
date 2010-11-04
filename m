From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: .git as file pointing to directory?
Date: Thu, 4 Nov 2010 13:43:21 -0500
Message-ID: <20101104184321.GA16929@burratino>
References: <AANLkTikB4p9=EQRsAJTe4-nAw5udz2pfcRd4WPsfms86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad Larson <bklarson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 19:43:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE4mv-0001XW-JC
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 19:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab0KDSns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 14:43:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47442 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451Ab0KDSnr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 14:43:47 -0400
Received: by fxm16 with SMTP id 16so1720496fxm.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 11:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kwDqL89+/uz6Hy3u2ZtRZRBy//DUSnUULkANYq8OS6A=;
        b=aIC8GbIwg/LUXAfjfggFvnchnD00Y6gDRA/5Mn841tlTdPMkNz4HuBN3BSHwgn7epp
         8cE85h5aYv4DyCjBnO9VHmwN6bg7iCwkrobrHl7YanrZfzh4ysbfp+4xvj56Ac8gPdTX
         uM3Q4N93c3P2R5a4CUvSjxB8Jc7wGlVTKWGSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=V8VpjRynkStIjZtdxPISpnVt337ekkSqwfs5w9tekYyDaRbUpnAxGrX1frB5skZve1
         JZtWmC91vxCzKULrHtH0jILYDhelK6rwweCClXvsDmejeBr8DHHqvRpKeFIuzVbYN36m
         S+G7ftXKtGyYH35+tubkhORrvvwwa/pBXiHAU=
Received: by 10.223.108.147 with SMTP id f19mr79786fap.68.1288896226553;
        Thu, 04 Nov 2010 11:43:46 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id l23sm173836fam.19.2010.11.04.11.43.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 11:43:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikB4p9=EQRsAJTe4-nAw5udz2pfcRd4WPsfms86@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160747>

Hi Brad,

Brad Larson wrote:

> At gittogether there was some talk about having .git be a file, not a
> folder, with contents pointing to the real .git directory.  Similar to
> a symlink, but supported in Windows.

It is called a .git file.  See gitrepository-layout(5), v1.5.6-rc0~93^2~3
(Add platform-independent .git "symlink", 2008-02-20), and the recent
rebase not handling core.worktree thread[1].

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/160488/focus=160567
