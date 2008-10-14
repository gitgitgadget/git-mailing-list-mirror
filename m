From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: retrieving a diff from git
Date: Tue, 14 Oct 2008 19:01:03 +0200
Message-ID: <81b0412b0810141001w46227afam70123237025a2d4d@mail.gmail.com>
References: <20081014145112.GR22427@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Folkert van Heusden" <folkert@vanheusden.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 19:02:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpnHp-0004An-Sa
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 19:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbYJNRBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 13:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbYJNRBI
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 13:01:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:19229 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbYJNRBH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 13:01:07 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1427529wri.5
        for <git@vger.kernel.org>; Tue, 14 Oct 2008 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8p+VpCbyZr78kMD8jgt/DBEAg5Zwa/hJWHpc85Bi3j0=;
        b=fubIbeH0K0PzY4AzoX5yCN14ilhVQpPScWzyTHrz9CEgLTDVMS/pvfUZGXPMfebJZi
         MvjK8erO1I1QC83FvclUk9ICdBlbFhVIvVirKh6C3/zCoOnNBvYi4KPRYlSqeT5qbW85
         iZ5ZPWoxVMokKl+c9MiMH+pC5U6upnL+YmaWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PKZVc2L/FsOJQlIhEkFbb+p2O2c/U4LWO4oArYushxtRO4GfQZQg5RNPYtZ0KU4eew
         TKfPQhOlYL9N/BEC7QZr+A4fuLm4bNcZJik9kqWlsd/x44xD+KZt0XxknZkWjGSL1lWn
         y9W4Yxxkm7yzOtF4tyT7fRv0IW8NPFMu8VpSE=
Received: by 10.100.178.7 with SMTP id a7mr496010anf.2.1224003663650;
        Tue, 14 Oct 2008 10:01:03 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Tue, 14 Oct 2008 10:01:03 -0700 (PDT)
In-Reply-To: <20081014145112.GR22427@vanheusden.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98200>

2008/10/14 Folkert van Heusden <folkert@vanheusden.com>:
> How would I retrieve the 'kmemcheck' patches from git for the 2.6.27
> kernel? I browsed to the url
> http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Fx86%2Flinux-2.6-tip.git...
> but could not find how to retrieve that diff.

Well, you can of course just click on "commitdiff" (and "raw" afterwords)
for every commit, but ... Have you considered using Git for that?
