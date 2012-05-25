From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of
 ~/.gitconfig
Date: Fri, 25 May 2012 12:01:59 -0500
Message-ID: <20120525170159.GA4086@burratino>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: nguyenhu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri May 25 19:02:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXxu1-00070a-Uw
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 19:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756151Ab2EYRCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 13:02:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43492 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467Ab2EYRCI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 13:02:08 -0400
Received: by yhmm54 with SMTP id m54so747985yhm.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 10:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UaBM+ux9+RnKYbZjBz6FW8n90NLusyU31T/FDztiNzU=;
        b=J42XiI+SZGKmJZDdAhQyysbv8BRWtxm37otgmPC033aPAhpf8Jopi01fOtzgMYshNC
         Vo+jZQ5EAULnMFOfWnLYssGObskuK584n7tPJNAaNa8WQDjjmKZ6Tyc9XaXguDbVB3pZ
         Hk9HzhG0mvCDV3qGLcS3l6RMqS6fvcCK2pT8aJY/2LrLezDXdUfvhVUQEowHLkpuOqJg
         L5/fJpLzSDr27jFpGm6O0BbKcMHP1TxHmp4sFz+u7vpglXxBnfHk3b9H1zfJDmITFujG
         Jh514NuBaXSju4WoW/Ytx72Z5969BbVOn04/zUM1sHgpMWY5WlX8t5iI8tSannQt9BHF
         3gdw==
Received: by 10.50.104.166 with SMTP id gf6mr3527382igb.35.1337965326873;
        Fri, 25 May 2012 10:02:06 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id fm10sm1049953igc.7.2012.05.25.10.02.05
        (version=SSLv3 cipher=OTHER);
        Fri, 25 May 2012 10:02:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198484>

Hi,

nguyenhu@minatec.inpg.fr wrote:

> As you know, git stores its configuration in ~/.gitconfig file and
> in other hidden files at the root of the user's directory.
[...]
> git would store its configuration in ~/.config/git/config file if:
> - this file exists,
> - and ~/.gitconfig file doesn't.
> Otherwise git would store its configuration in ~/.gitconfig as usual.

Sounds like a worthwhile goal, so I look forward to the patch. ;-)

What other hidden files at the root of the user's directory are you
talking about?

Curious,
Jonathan
