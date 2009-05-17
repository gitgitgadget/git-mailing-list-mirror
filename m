From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (May 2009, #02; Sun, 17)
Date: Sun, 17 May 2009 20:27:20 +0200
Message-ID: <200905172027.22374.jnareb@gmail.com>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org> <m3zldcjc76.fsf@localhost.localdomain> <7v1vqnipc0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 17 20:31:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5l8T-0008Sq-TU
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 20:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbZEQS10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 14:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbZEQS10
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 14:27:26 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:38745 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbZEQS1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 14:27:25 -0400
Received: by bwz22 with SMTP id 22so2836528bwz.37
        for <git@vger.kernel.org>; Sun, 17 May 2009 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=TxMmrhzlP4W/DrN9fl0jCaL3dKKqy4cHS2PvszjcPAI=;
        b=oYUeCGxECPnbncxssvvJ5gLIN1lLj2CrN+nJbOaxASJxxv85nVvqc3vFMxasgKCvzz
         1w4PkcqVIC8+w/t3rwQGKuMh8V4DFZ8TYcCP/FaU9f0XIdf0BfPbOZuoZQNi4tKEMh7b
         JtoyKYhd5zRC+B7rJ4onGg7AbOozs9YYbv7I8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=eaeadVnYs7bXk/QF0/y3/9Jz97AW8m5rth3o8exDw1S/jMgF1/bRzfRsYKCHuCLRSz
         55Javx8HIp2sDNxKXxUlIKoJwEjys6GPBYn8gq5Il+NssBDEwxZJUYcJGAXYhge0t73F
         ANcubQYFbubojWbva+0ClUySl3VjI5bt1x5f0=
Received: by 10.103.182.3 with SMTP id j3mr939299mup.115.1242584845779;
        Sun, 17 May 2009 11:27:25 -0700 (PDT)
Received: from ?192.168.1.13? (abvz49.neoplus.adsl.tpnet.pl [83.8.223.49])
        by mx.google.com with ESMTPS id y2sm959875mug.13.2009.05.17.11.27.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 May 2009 11:27:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v1vqnipc0.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119405>

On Sun, 17 May 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> * jn/gitweb-cleanup (Mon May 11 19:45:11 2009 +0200) 8 commits
>>>  + gitweb: Remove unused $hash_base parameter from
>>>    normalize_link_target
>>>  + gitweb: Simplify snapshot format detection logic in
>>>    evaluate_path_info
>>>  + gitweb: Use capturing parentheses only when you intend to capture
>>>  + gitweb: Replace wrongly added tabs with spaces
>>>  + gitweb: Use block form of map/grep in a few cases more
>>>  + gitweb: Always use three argument form of open
>>>  + gitweb: Always use three argument form of open
>>>  + gitweb: Do not use bareword filehandles
>>
>> Why "gitweb: Always use three argument form of open" is twice here?
> 
> Perhaps you sent in a malformed message and I did not notice nor hand
> munge it?  Let's see...
> 
>       Message-ID: <200905110329.40666.jnareb@gmail.com>
> 
> Yeah, that's it.

Ooops. I have put v2 of 'gitweb: Localize magic variable $/' as a reply
to a wrong post, and forgot to massage the email... still, shouldn't
git-am pick up "Subject:" from a body of email?

Well, it is in 'next' already, so resend wouldn't help...

I'm sorry about that...
-- 
Jakub Narebski
Poland
