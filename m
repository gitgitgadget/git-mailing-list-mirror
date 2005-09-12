From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: hmm, can't we give the "root" a parent?
Date: Mon, 12 Sep 2005 14:27:43 -0400
Message-ID: <4325C89F.1030406@gmail.com>
References: <20050912181101.GA22221@vrfy.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 20:28:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEt24-000077-MH
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 20:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVILS1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 14:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVILS1t
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 14:27:49 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:15475 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932129AbVILS1s (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 14:27:48 -0400
Received: by wproxy.gmail.com with SMTP id 71so417207wri
        for <git@vger.kernel.org>; Mon, 12 Sep 2005 11:27:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=nUPazW0rBrxgwUUPNsMovgPhJXGdCOnZOH+qtZ7onFSeHwe/ubtmozSyIqyFk/vc3lKWV55viqQKZUe1uyKtZSU79MBPB7rbY6759AB7dliusvTMbwSZzYdhsVu/MkwqU8ooLaVYRRUOSFMVu2ZdY9Lt6E2G0a4LP3pEvl3ipjg=
Received: by 10.54.37.21 with SMTP id k21mr2831263wrk;
        Mon, 12 Sep 2005 11:27:45 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 65sm730445wra.2005.09.12.11.27.44;
        Mon, 12 Sep 2005 11:27:45 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050912181101.GA22221@vrfy.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8412>

Kay Sievers wrote:
> Can't we teach the git tools that a "root commit" (one without a any
> parent) is not visible as a "root", if let's say:
>   .git/parents/<root-commit-id> -> <fake-parent-id>
> 
> does connect a "fake" parent to the "root"? This way we could add any
> older Linux history to the current tree. Combined with "alternates" it
> could live in a complete different repository too.

Already done. Search the following for "info/grafts".

http://www.kernel.org/pub/software/scm/git/docs/repository-layout.html
