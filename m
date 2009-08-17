From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 20:16:59 +0200
Message-ID: <4A899E9B.7080803@gnu.org>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>	 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>	 <1250525103-5184-3-git-send-email-lznuaa@gmail.com>	 <1250525103-5184-4-git-send-email-lznuaa@gmail.com>	 <1250525103-5184-5-git-send-email-lznuaa@gmail.com>	 <4A899495.8050902@gnu.org> <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, Johannes.Schindelin@gmx.de
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 20:17:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md6lf-0008En-AG
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 20:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbZHQSRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 14:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbZHQSRD
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 14:17:03 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:55479 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbZHQSRD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 14:17:03 -0400
Received: by fxm11 with SMTP id 11so2444593fxm.39
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 11:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=9/gDlFkXIz7DZjl4n1MwwFwV9/kWew3EUfiD3m4xjZY=;
        b=QVkO6w1uHIJ639T6ttDARZDlp6IB7mXTXizfJSuejXECNadXy+nRzcTwPvPJGV+XRv
         6t29rwXm7JM7ZLRDfaDBBB5nV6Vb4GhuY25BfG3eGyaXD02vi1QMANzI1AOAZqaGiKAc
         QU4qwul/RJP3LIyqp5WnBj5kD7wX3lgzCBKKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=WGZGY+/7xc+BfKtQsd8qALhCMmKVOvzXKSnKsSkmRYMJIUzx2IsRKtDMtx5j+1SP8d
         EwJZ39RkI8zBuR+HNwmnuiW3Hv191G6rEIvyB/CvwG10h0yVbvimh2vs2Ef0i/6WfNVX
         0QaDBW4c3ngY/0YwVuBO6kzesSw/LXt9zuac0=
Received: by 10.204.34.73 with SMTP id k9mr2925704bkd.45.1250533023388;
        Mon, 17 Aug 2009 11:17:03 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 35sm5280121fkt.50.2009.08.17.11.17.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 11:17:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
In-Reply-To: <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126247>

On 08/17/2009 07:40 PM, Erik Faye-Lund wrote:
> On Mon, Aug 17, 2009 at 7:34 PM, Paolo Bonzini<bonzini@gnu.org>  wrote:
>> Also, a cleaner XML without verbosities like
>>
>> +<Tool
>> +                               Name="VCMIDLTool"
>> +                       />
>>
>> would make the patch easier to review.
>
> ...but will it make it more annoying to maintain in the long run? It
> might be painful to work with a mixture of hand-written and
> msdev-written XML. Of course, if we get some scripts in place to
> generate the vcproj-files this might not be a problem...

Yes, my remark applied only if the generation was scripted.  Otherwise, 
it would be an annoyance in addition to being subject to bitrot.

Paolo
