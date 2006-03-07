From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Pulling tags from git.git
Date: Tue, 07 Mar 2006 06:37:36 -0800
Message-ID: <440D9AB0.4070305@gmail.com>
References: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com>	<4dd15d180603061054k36d1a434se7377ded1b3240bb@mail.gmail.com>	<440D5285.3050401@op5.se> <7voe0ilf25.fsf@assigned-by-dhcp.cox.net> <440D7A7D.8070507@op5.se>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 15:38:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGdKW-00006j-Ie
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 15:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWCGOhl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 09:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWCGOhl
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 09:37:41 -0500
Received: from pproxy.gmail.com ([64.233.166.177]:28239 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750828AbWCGOhk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 09:37:40 -0500
Received: by pproxy.gmail.com with SMTP id i75so999565pye
        for <git@vger.kernel.org>; Tue, 07 Mar 2006 06:37:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PWpkDQ+z15cn9zIAcxGrHSDBSA4weMBIAlxk/O73CPoixnmZWpdBEaGGym2irpeOGsy9oLsA+eUI7E3OrYgPI7J4TT2H0x0JC8bPsUDBjh/wazRufO4ewaYsLtPOLzsp1Y2QTCMxdt3pP6/ereKYCbvb4ejn7xlNxDH5zaa9r44=
Received: by 10.35.79.5 with SMTP id g5mr1231063pyl;
        Tue, 07 Mar 2006 06:37:39 -0800 (PST)
Received: from ?10.0.0.6? ( [67.20.67.7])
        by mx.gmail.com with ESMTP id f19sm335964pyf.2006.03.07.06.37.37;
        Tue, 07 Mar 2006 06:37:38 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <440D7A7D.8070507@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17336>

Andreas Ericsson wrote:
> Junio C Hamano wrote:
>> Andreas Ericsson <ae@op5.se> writes:
>>
>>
>>> With the git or git+ssh protocol, tags will be autofollowed
>>> when you do a pull (only signed tags, I think).  The
>>> auto-following is done by detecting tags that are fetched,
>>
>>
>> Ah, you are correct.  We do not follow lightweight tags; I am
>> not sure if we should.
>>
> 
> I'm fairly sure we shouldn't. The default update-hook prevents them (if 
> enabled), and I can't for the life of me think of why anyone would want 
> to distribute such tags.
> 
> OTOH, preventing unannotated tags from being pushed seems like a better 
> way than to not have the ability to auto-follow those same tags. After 
> all, it's better to discourage than to disallow.
> 

Before you do this, please explain why unannotated tags are not useful, 
and so should not be allowed to be pushed.
