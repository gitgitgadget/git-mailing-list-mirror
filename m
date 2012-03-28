From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Sharing nested subparts of large repository?
Date: Wed, 28 Mar 2012 04:52:21 -0500
Message-ID: <4F72DF55.6000202@gmail.com>
References: <1332693502389-7403743.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: LordSmoke <dslice@morphometrics.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 11:52:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCpYL-0003Pg-V1
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 11:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757923Ab2C1JwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 05:52:25 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64381 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519Ab2C1JwY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 05:52:24 -0400
Received: by obbeh20 with SMTP id eh20so1131280obb.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jK+wxtjGU8EjzjO/OM3CNKKSuu4Wf5Z3SlFN5d9QHAw=;
        b=U0kfcuq1pLJgHFwuYemY8uF/9lBBS9iJvraEU2ADB9503A3F67UkzZeAFaXRBkDK4K
         1r4jszehigOdRYe7y4TTaS6v8IDxLVqvNtrYSuK48M1gT1NTZXIoXwjto700HpYb+5Sm
         5wdYMaaSp4fuSJtwEoYGHVMrAYxifE8RW+6I8gh/q7yGCSJbGZnMaKHSN+4RCb1+bhRu
         MXQeKWJWsjb5kRh5sDRzkWgmFiei1gqqkGJbiO4BbXDq0HGBj7qvJevi0/HY349H9atf
         xzZ/XpBvv/XfuscxzP5bYsF9uDiyJ9iCW9pCA0sSlvE0KVSS5olXrxnNZ92rVXB0og6M
         HK/A==
Received: by 10.182.159.41 with SMTP id wz9mr36394373obb.69.1332928343903;
        Wed, 28 Mar 2012 02:52:23 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id d8sm158775oba.17.2012.03.28.02.52.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 02:52:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <1332693502389-7403743.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194116>

On 3/25/2012 11:38 AM, LordSmoke wrote:
> I've been using git for a couple of months to get used to the system.
> Basic stuff - a few larger project repositories in unique
> directories, commits, pushes to a remote repository. Mostly as a kind
> of backup system.
>
> However, my ultimate goal is to share part of one large project
> currently being managed with git with my developers. I want them to
> have access to source code and test data, but not my manuscripts,
> correspondence, whatever.
>
> I also want to make a portion of what I will give my developers
> available as open source, e.g., on github, but not all of it. Just
> the stable, non-developmental parts. NOT the our development stuff
> and not the parts being used for private contracts.
>
> Submodules seem promising, but the examples are not quite what I am
> looking for, as far as I can tell. They talk about isolating
> submodules that depend on a larger project. I want to make available
> the larger project while keeping nested submodules (so to speak)
> private.
>
It sounds like maybe your superproject has all the submodules and their
superproject has only some of the submodules.  You can also have a 
superproject just like theirs so you have a superproject with everything 
(because your special) and another superproject like theirs (so you can 
pretend to be just like them).

I'm not a submodule expert, but I'm pretty sure you can do that. 
Whether or not that matches up with your current structure of various 
git repos or not I don't know (enough details).

v/r,
neal
