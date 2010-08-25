From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bug report: %h for abbreviated hashes broken after 1.7.1
Date: Tue, 24 Aug 2010 23:14:40 -0500
Message-ID: <20100825041440.GH11619@burratino>
References: <AANLkTinR6_DFD_MbFRbtyJKPhZG1Os0ro=4TcC2h_xZo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Todd A. Jacobs" <tjacobs@si2services.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 06:16:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo7PZ-0000Nz-RB
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 06:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550Ab0HYEQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 00:16:25 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57578 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab0HYEQY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 00:16:24 -0400
Received: by gwj17 with SMTP id 17so55209gwj.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 21:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uIqhHDB/ATdXhV5WxhSzcv2xrU7/WQfDwb/5qHyR6z4=;
        b=PR58+oH8T0blNx0CH7XFba+k/gHgqYmPl1Dk+BInx4GAWCP7xp2eABXgQ2n+x/37MR
         kx6e4KLheT+MIbM7Hsjjb5ZAOHg081OBMkUOJLeK+ja4DDp3gIDlocSePPfbvXJP4TNh
         jIz//2+PPWMUmdM+CKmkgzyfymHoDm9TOnsXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EOmqosqoOOl9nLIdTGxDcxRuVyxb2LXjlOvTAzObd6/Fde2devLwYDOO9IDKA50M+9
         3Jh6dDmyDMPcgo7ysZibdtDp5cEviKhfzjoVB4fO0EfFGbt/6ZkCzJd2mygyZV2szE1x
         tYK35IBdTS8lJNrieeUiq/LVsmbDlOaVoCRfI=
Received: by 10.100.252.18 with SMTP id z18mr429729anh.83.1282709782824;
        Tue, 24 Aug 2010 21:16:22 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n7sm699276ane.21.2010.08.24.21.16.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 21:16:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinR6_DFD_MbFRbtyJKPhZG1Os0ro=4TcC2h_xZo@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154412>

Todd A. Jacobs wrote:

> Checking 'man git-log' still says:
> 
>     %h: abbreviated commit hash
> 
> so this seems to be some sort of regression in how pretty formats are
> being expanded. It looks like commit
> 35039ced9296786bc0971bf5385c0d6f6ea5ea1e was supposed to fix this, but
> it apparently still isn't working in the latest tarballs available on
> kernel.org.

$ git log --oneline v1.7.2.2..35039ced9296786bc0971bf5385c0d6f6ea5ea1e
35039ce archive: abbreviate substituted commit ids again
$

You might also be interested in the section "Repositories, branches,
and documentation", from the note from the maintainer sent to this
list from time to time. [1]

Hope that helps,
Jonathan

[1] http://git.kernel.org/?p=git/git.git;a=blob_plain;f=MaintNotes;hb=todo
