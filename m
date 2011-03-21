From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: "git rm" is not a valid merge resolution?
Date: Mon, 21 Mar 2011 21:01:07 +0100
Message-ID: <4D87AE83.6080008@gmail.com>
References: <4D879882.4070608@gmail.com> <7vvczcp8w7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:01:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1lHx-0005zX-EQ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 21:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab1CUUBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 16:01:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58018 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab1CUUBM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 16:01:12 -0400
Received: by bwz15 with SMTP id 15so5320911bwz.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=B1YKct7QJFPGEziJcAxknT5FN0FFQ3DjGuAboPZC8BU=;
        b=dwBG6PnJqopiG3RiIbOggjI7BwtKRRxg46Scojxd7wUtEuvcOWNH2eSo+MnwqQ8P9h
         dPWHhshR7G2Lw8fSxxoa5ZGm7DoBFp4BahRy2uNN/ulr9w9opiEoX1mbfANjh2CCGXXB
         l5srhNApa3PrmNO/FfhOzsfTNMfQy7Rv1itCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=wRQN4AAYvhWrFQ0z+VTgAC7LD/jzNfjvmBPvHnccRyC671jPZVlJ3dn9xjoWpCZb2i
         s1Ki++SntkyD/U4acW6SAw23jCkrc+v3t2AMO6JfSD8Ebf7nhbW4tSUjsiP2hELvy7MF
         n+WrUGNmsyJnXbBdH4mCcpRFrEUHV0roQcX7I=
Received: by 10.204.141.17 with SMTP id k17mr4198558bku.41.1300737671072;
        Mon, 21 Mar 2011 13:01:11 -0700 (PDT)
Received: from [192.168.1.101] (aadh98.neoplus.adsl.tpnet.pl [83.4.85.98])
        by mx.google.com with ESMTPS id z18sm2245828bkf.8.2011.03.21.13.01.08
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 13:01:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <7vvczcp8w7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169657>

W dniu 21.03.2011 20:32, Junio C Hamano pisze:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
> 
>> git-status shows a hint that says
>>     use "git add/rm <file>..." as appropriate to mark resolution
>>  
>> But if I "git rm file" the file gets deleted. Is this really the 
>> appropriate merge resolution?
>>
>> I would expect "git rm" to maybe reset all the merge changes but
>> it seems to just delete the file.
> 
> Yes, if your side has a commit that updates a path since branches forked
> (e.g. fixing a minor bug in an implementation of a function defined
> there), and the other branch you are merging removed the path (e.g. fixing
> a higher level callers and made that buggy function no longer necessary),
> taking their removal can be a valid conflict resolution.

Please see my other mail - file deletion can also be done by "git add". 
I feel that suggesting something that is wrong in most cases is wrong :)

-- 
Piotr Krukowiecki
