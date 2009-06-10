From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: EasyGit Integration
Date: Tue, 09 Jun 2009 23:43:14 -0700 (PDT)
Message-ID: <m3hbyo4mis.fsf@localhost.localdomain>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	<alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
	<4A2F0B8A.9010203@vilain.net>
	<7vws7khlvj.fsf@alter.siamese.dyndns.org>
	<4A2F1FD0.8060303@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 08:43:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEHWu-0001Zx-NO
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 08:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbZFJGnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 02:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbZFJGnO
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 02:43:14 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:39037 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbZFJGnN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 02:43:13 -0400
Received: by ewy6 with SMTP id 6so673976ewy.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 23:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=4XJ5ReA1cnkrjn/PgE233thMLaes625Z8Wva8oDQ3EQ=;
        b=wVGWG7d0XDYPso5DSl92JNBLfCru/7hRoM9NidWFownfcqz60coAKp5uActvasFohi
         i/n8iaz+Q2WwaCWhXYkS48owtSbwVqv3JyiszCWFjb5Bd81ZgxJZrE8eyu5pGdLWF/PU
         yOOaHfn09VMMzEfi+GxtLGquXIVOx5dzkLKg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=HNk9+Y/lkCn9OQ2LWReaBuJ7K/YnGxmfyK9FVw0gqH48OvWVdwicv20kUJhFKuY97n
         dJUTLYZB5lQO6mUWMmL+z0DYwi+NTP3aj1DJPPquB6AeZQ1ebBUMTdZaGCpNuFKOcM95
         3C4hQrcz34BXIJTEvogFMSq4QD5lpRn20T4vw=
Received: by 10.210.144.8 with SMTP id r8mr3085299ebd.63.1244616194663;
        Tue, 09 Jun 2009 23:43:14 -0700 (PDT)
Received: from localhost.localdomain (abvn21.neoplus.adsl.tpnet.pl [83.8.211.21])
        by mx.google.com with ESMTPS id 10sm1400135eyz.51.2009.06.09.23.43.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Jun 2009 23:43:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5A6hAhl021960;
	Wed, 10 Jun 2009 08:43:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5A6h7q8021957;
	Wed, 10 Jun 2009 08:43:07 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A2F1FD0.8060303@vilain.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121252>

Sam Vilain <sam@vilain.net> writes:
> Junio C Hamano wrote:
>>
>>> I think as long as there is a deprecation cycle, and that users can
>>> select the old behaviour (either via an alias or a config option), then
>>> we shouldn't upset many long-time users of revert. Do you agree?
>>>     
>>
>> I actually don't.
>>
>> I do not think introducing "git revert-file" (or "git revert -- path") is
>> a problem at all.  But "git revert $commit" has been and is an integral
>> part of the established git workflow, and I do not see a point in changing
>> it to mean something else, with any deprecation period.
>>   
> 
> Ok. Off-hand I can't remember why we excluded "git revert -- path" as
> workable. Whatever that reason was led to the group of core developers
> coming up with these "clearly" "_inferior_" names.

"git revert -- path" is perhaps not unambiguous (but for the fact
whether it reverts from index, or from HEAD), but "git revert <rev> -- path"
can be understood as "git cherry-pick -R <rev> -- path" i.e. reverting
changes to given file or files in a commit.

And we have "git reset -- file", don't we.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
