From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7.1 3/4 (amend v2)] gitweb: File based caching layer (from git.kernel.org)
Date: Tue, 30 Nov 2010 11:21:02 +0100
Message-ID: <201011301121.03586.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <201011300009.05437.jnareb@gmail.com> <7v4oazy6pw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 11:21:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNNKt-000308-Rb
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 11:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab0K3KVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Nov 2010 05:21:19 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60342 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab0K3KVS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Nov 2010 05:21:18 -0500
Received: by fxm8 with SMTP id 8so996338fxm.19
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 02:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5S6EnORXiM8ZtSHa6NB7kSsB2G4pAKhFdQvkd19o048=;
        b=DgxF185jPSAD25/c7xEp8EIxspI4oVhibNP9L3BeYHYKODzUAImmf2uNA/J015ho89
         NF5ECKtgKbYZUfy6eWpwwMd6Yfd3gMYI6q4Y4UaxbawnIMYYQHiTvmXxHTF557Ac9RsX
         sdRWuRjIfbVINIHHxRzBh2dy8MbTAH92egHHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IYvJbIzj9sF4arrfop9mRvLzksA1L7PIqS06AoJAhjyI3YS4WyIlEYo5WET+3leN29
         7th+O1DwMsjRgGDhwU0A3M7O8MN39ORda5pjsGiMJudjMylxEHYyiJRMl5A1wTl+e3pK
         9CgwIU4MpCuZEk4xjvD2RYRfPZn6KHdI1vOoY=
Received: by 10.223.93.142 with SMTP id v14mr6520984fam.49.1291112476853;
        Tue, 30 Nov 2010 02:21:16 -0800 (PST)
Received: from [192.168.1.13] (abwm72.neoplus.adsl.tpnet.pl [83.8.236.72])
        by mx.google.com with ESMTPS id a2sm1547244faw.22.2010.11.30.02.21.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Nov 2010 02:21:14 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4oazy6pw.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162484>

On Tue, 30 Nov 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> On Mon, 29 Nov 2010, Junio C Hamano wrote:
>>
>>> Wait a bit.
>>> 
>>> This seems to match what I have already queued on 'pu', no?  Am I
>>> hallucinating?
>>  
>> Damn, it looks like my mailer included wrong (older) version of a file.
>> I'm sorry.  Below there is interdiff:
> 
> Thanks.  What I had was what I pulled from you.  I take it that you want
> me to rebase the two tip commits on the branch?

Yes, please.

Though it still doesn't pass new tests in t9501 and t9502; the problem
is more with setting up tests rather than with caching code, though.

-- 
Jakub Narebski
Poland
