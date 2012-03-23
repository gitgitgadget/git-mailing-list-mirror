From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Push from specific directory.
Date: Fri, 23 Mar 2012 10:30:19 -0500
Message-ID: <4F6C970B.2010803@gmail.com>
References: <BLU0-SMTP471329E4F80CD64A569A4F7B1410@phx.gbl> <20120322225747.GB14874@sigill.intra.peff.net> <4F6BD1E2.2050607@gmail.com> <BLU0-SMTP315865C5026D08E76594E5DB1460@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Anjib Mulepati <anjibcs@hotmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 16:31:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB6SS-0007ax-OU
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 16:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758808Ab2CWPa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 11:30:57 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62048 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758787Ab2CWPaW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 11:30:22 -0400
Received: by mail-gx0-f174.google.com with SMTP id e5so2840137ggh.19
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 08:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Htdg19WpcXVbAIjlSWt0cOapsRxkS4ynHLxqK4gnbEk=;
        b=ftNylrFepsmsefft5RmZmFE3mCHgzsuiLkw/RpP0Y/xS09LuNQDNakdr5/IcmXNeXR
         3u0+Z9JKE2OBGaCBMvUkCCU2khnXwcnEjYrsjfTNRUTW5EWaDRjANDxjRPc12FCUIn/3
         XEpnK9THpgzLiBrWxMAF/Hw2LIETfjWcI4Pag6Oum2FG/llcjtyXDce0ZMhQ6ummX3Dl
         cL3FhtKF0Hy1oMAwwHuvJYjHs3qtC7kqgvicIrogmq7GZiKfo55VrA6kViBFky343PKV
         7kR2uM86cpTd53EU+guFf88XrnomZLIyE4Vh+FSGVpLgqZIuaBqW2XsIv5iob/XsbY/j
         8s0w==
Received: by 10.60.1.4 with SMTP id 4mr14851367oei.28.1332516622240;
        Fri, 23 Mar 2012 08:30:22 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id yw3sm8018721obb.7.2012.03.23.08.30.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 08:30:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <BLU0-SMTP315865C5026D08E76594E5DB1460@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193767>

On 3/23/2012 8:35 AM, Anjib Mulepati wrote:
> I  am comparing Git with other SVN.
>
> In SVN each folders have .svn folder. If we don't wanna track 
> particular folder then there is no .svn folder in that directory. In 
> Git does we have same structure?
>
> So the example I am giving here represent two versions and one 
> non-version folder.
>
There is only one .git dir per git repo.  By default it is created under 
the top-level dir (worktree) of the repo.  If you don't want to track a 
subdir then you ignore it using the gitignore technology of git.  You 
would want to setup the gitignore before doing the init.

v/r,
neal
