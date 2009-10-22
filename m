From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2009, #04; Wed, 21)
Date: Thu, 22 Oct 2009 12:01:26 -0700
Message-ID: <4AE0AC06.1060906@gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <m3ljj3es02.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Mark Rada <marada@uwaterloo.ca>,
	Nick Edelen <sirnot@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 21:01:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N12uq-0004F4-RC
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 21:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955AbZJVTB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 15:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbZJVTB3
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 15:01:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:41510 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbZJVTB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 15:01:29 -0400
Received: by fg-out-1718.google.com with SMTP id 16so3707344fgg.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=DwHeMr/q/d8epYn+DFewbcuUsz6dQ7XpZyFc7ltxh7Y=;
        b=ZvGEoMP0qh3B1EPunmQc4qbiXLpTJmrczq+JGYyz7HWtHY5JossV0DEKThsOCH2A7N
         0qlH0ToknLOYed2/yMblGjJChq0X3kZM4lhdNdgehlwih3YadIYGjRJQn/L8Qsev+CXy
         Eb0vJ42AMQuZcPys14mrZDTECcB2Y3Uqpu9sk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=rjrcDZ6pDCP4TmOBKluSylkd3j/u7PgULNMkg3GVGndtxaFMLrjVq6bcb3WvR1+/ZT
         nDJrR2Mb1XE6Ht42p3rd6mq/8hp9TeyowrXIzoBBWc+MZV1mkjGmCI8IecH6allu53s6
         IlcMtpDBd1moDsM59mhmBAhhPJQsoiVVSC4eg=
Received: by 10.86.8.36 with SMTP id 36mr331835fgh.7.1256238092788;
        Thu, 22 Oct 2009 12:01:32 -0700 (PDT)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 4sm1656951fge.9.2009.10.22.12.01.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 12:01:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <m3ljj3es02.fsf@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131042>

Jakub Narebski wrote:
>> * sb/gitweb-link-author (2009-10-15) 1 commit
>>  - gitweb: linkify author/committer names with search
>>
>> Soon in 'next'.
>>     
>
> Is this version that uses title attribute to show that this link is
> different in that it leads to search results, not an action view?
>   

Yes.
