From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: Stacked GIT 0.4
Date: Tue, 12 Jul 2005 09:29:42 -0400
Message-ID: <42D3C5C6.9060609@gmail.com>
References: <1120899939.7125.4.camel@localhost.localdomain>	<42D3A415.5000709@gmail.com> <tnxfyukjhdn.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 15:31:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsKpv-0007Sh-P3
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 15:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVGLN3x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 09:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVGLN3x
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 09:29:53 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:51193 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261422AbVGLN3r (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 09:29:47 -0400
Received: by zproxy.gmail.com with SMTP id 8so508228nzo
        for <git@vger.kernel.org>; Tue, 12 Jul 2005 06:29:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Agm0izA/M7zvE/q1s/SwSmNuHBg6ubG5/ih+ZO2q/C2Bvu+4z0iwoCGJE444GWeZ6EJnGQd16tw3IuSrw68sSNJYLyfcPmB9eogMYjRuIv4x+fi68AThZzae3Ajb5d6X4W2peE7Tsomu2MtUKlYD5wwIZxSa1ZtAOTlvjK68QqA=
Received: by 10.36.222.28 with SMTP id u28mr1909646nzg;
        Tue, 12 Jul 2005 06:29:44 -0700 (PDT)
Received: from ?192.168.2.80? ([69.159.204.165])
        by mx.gmail.com with ESMTP id 7sm2759390nzn.2005.07.12.06.29.44;
        Tue, 12 Jul 2005 06:29:44 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxfyukjhdn.fsf@arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas wrote:
> Bryan Larsen <bryan.larsen@gmail.com> wrote:
>>template files for the "series" output of export, to put it into a
>>format that "sendpatchset" understands.
> 
> 
> I thought about integrating sendpatchset into stgit but it is much
> simpler to just generate a control file (especially if you want to
> review what you're going to send). Is the subject line always the
> first line of the patch description?
> 

I haven't been using "the Linux way" for long, so I'm probably the wrong 
guy to answer, but for my current set of patches, the name of the patch 
would be the right thing to put in the Subject line.

But my current set of patches is really small, so if you implemented the 
"first line" convention, I'd be happy to switch to it.

Bryan
