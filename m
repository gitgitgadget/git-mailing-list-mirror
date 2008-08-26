From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 07:12:23 -0400
Message-ID: <48B3E517.2040409@gmail.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>	<1219664940.9583.42.camel@pmac.infradead.org>	<48B3715D.7020608@gmail.com> <20080826091701.2e4e3ff4@hyperion.delvare>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, users@kernel.org
To: Jean Delvare <khali@linux-fr.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 13:13:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXwUO-0000kQ-P2
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 13:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641AbYHZLM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 07:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756609AbYHZLM2
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 07:12:28 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:45903 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213AbYHZLM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 07:12:27 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1113101yxm.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 04:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=XXPxsQIO6dfqPaH/DiPM4Zg5QWBn42HKi8EafUZCVXE=;
        b=T7oCEbG2uBzFR1a6jwkkmOfYgZJMbqGCU0A2HMp7fGbrHfsoV4CRSJtNJ7xoueDIGb
         V1XEdfz+qf28uf9UgCgiw3Kr1Ksw291r7Z60cLkxSPEmTvHn3MfW5gdK0UMzFcnSRU9h
         k6AP1joTvfoEPUDXLKKoNyL+mtKdsaSCHv5KQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=dNnvQOd0c2nRPqcP7f+LmHlE2wOuwl0inHBx8Ni4Yg0640hO49Gr93FHhxwXQVhunA
         cK2F9saBrbj3KKQTL8CjxiHGxfJreufkzlvVcOQOAvoWlnOUOsNinaOXcevM1rV0pUCC
         B7R4NGiJDTPkUD8N7hU5nnfHItZL8iFFxlYiw=
Received: by 10.150.51.6 with SMTP id y6mr8980406yby.222.1219749146379;
        Tue, 26 Aug 2008 04:12:26 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id q26sm6687623ele.8.2008.08.26.04.12.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Aug 2008 04:12:25 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20080826091701.2e4e3ff4@hyperion.delvare>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93733>

Jean Delvare wrote:
> On Mon, 25 Aug 2008 22:58:37 -0400, A Large Angry SCM wrote:
>> David Woodhouse wrote:
>>>   (C) Just don't do it. Leave the git-foo commands as they were. They
>>>       weren't actually hurting anyone, and you don't actually _gain_
>>>       anything by removing them. For those occasional nutters who
>>>       _really_ care about the size of /usr/bin, give them the _option_
>>>       of a 'make install' without installing the aliases.
>> Acked-by: A Large Angry SCM <gitzilla@gmail.com>
> 
> Such statements from anonymous people have zero value, sorry.
> 

Do some research; I haven't been anonymous since 2005.
