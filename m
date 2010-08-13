From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [PATCH/RFC v2] More readable 'Not a git repository' messages
Date: Fri, 13 Aug 2010 10:30:52 -0700
Message-ID: <4994E665-9084-4479-B44F-4D5562CE4BB0@gmail.com>
References: <i3pdkj$hut$1@dough.gmane.org> <i43v6e$q00$1@dough.gmane.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ralf Ebert <info@ralfebert.de>
X-From: git-owner@vger.kernel.org Fri Aug 13 19:31:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojy5t-0008Jy-Rs
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 19:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761897Ab0HMRa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 13:30:57 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:42833 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761879Ab0HMRa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 13:30:56 -0400
Received: by pxi10 with SMTP id 10so886029pxi.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=gYJmo9H9a/QivzD5U/BzuR0TMRGns/lSgWmbKFfJLLA=;
        b=GRNLvP3y2q+CMPsZdp+ppep77fpRx3TjgVeqzqncWIR3biQ4c9kO2S5yckxCZ6nbVH
         JNeeTdWSKZ618RmfrJFkKxDYvAdKmdkoO2PN8Ut7vW1a2mFBAqFm6c4PIo315CLKSdAa
         YJBN9RRT4KLtZLJg4RGb77k+9oLEwPfhBbwa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=WtrhRewzcnlwa7OVzgH/VDJVQH2AdfrHb6ALCje/sq1CGad+1/u1WGVA5TJopFjwEP
         89DybUNkA6g9Mfz2fbKZ4CmIV8bh3NtojUk5lweEVcBI+qAIU63xazrOX00uUMlXMGwl
         YfUS01Fv9zwrxEgA09StbBGVzLNzC+z1aPelM=
Received: by 10.114.120.9 with SMTP id s9mr2077472wac.100.1281720655836;
        Fri, 13 Aug 2010 10:30:55 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id g4sm4975947wae.2.2010.08.13.10.30.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 10:30:54 -0700 (PDT)
In-Reply-To: <i43v6e$q00$1@dough.gmane.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153480>

On Aug 13, 2010, at 10:25 AM, Ralf Ebert wrote:

> * State the folder concerned with the operation
> * GIT_DISCOVERY_ACROSS_FILESYSTEM warning goes first
> * Supressed 'filesystem boundary' warning for $HOME (crypto home  
> volumes

s/Supressed/Suppressed/

>  are common, having a git repository at $HOME is uncommon)
> * Improved wording of the messages

Josh
