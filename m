From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Wed, 23 Mar 2011 13:16:28 +0100
Message-ID: <AANLkTikPoiC9qJ5WoTrO5PyetprD2O6CpQjPDsocxaQn@mail.gmail.com>
References: <4D871972.7080008@elegosoft.com> <7vhbawno11.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1103212302000.1561@bonsai2> <7v4o6vmvzs.fsf@alter.siamese.dyndns.org>
 <20110322085027.GF14520@neumann> <AANLkTi=zbsNxLSCcWQorZCnRFuDPujqYzW7B0xJx2FHp@mail.gmail.com>
 <20110322100903.GG14520@neumann> <AANLkTik8BaAJCnCRdDNTdu=nV1Q7cFLiwOuV_4wdXUE6@mail.gmail.com>
 <20110322202518.GA30604@neumann> <AANLkTikLHRkE6aapS00q=4=4FSzjY1XQQQp=pRu12yP3@mail.gmail.com>
 <m3y646ujgy.fsf@localhost.localdomain>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jakob Pfender <jpfender@elegosoft.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, lee.marlow@gmail.com,
	markus.heidelberg@web.de, spearce@spearce.org, bebarino@gmail.com,
	ted@tedpavlic.com, tlikonen@iki.fi, trast@student.ethz.ch
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 13:16:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Mze-00017Q-PC
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 13:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059Ab1CWMQu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 08:16:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63254 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab1CWMQt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 08:16:49 -0400
Received: by fxm17 with SMTP id 17so7272080fxm.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CdPIqvJ1SHzvnu4hycy8+HtdzCbYJRfgKQlAbP1Z+j0=;
        b=cIaBOle3rOAIi1WohvyEH1MvuNgceP/JqQZRWbLf5j/GBtPZ3bUwQSRiHMN9sbiCJG
         S4bFA3loqnjU6+4v9C6WqnM834627obUJu+MtNq43adx/O8ULwztbjfM6hGiyyy5cbpq
         QwbY6Lv36k2dmXdkEz0NU3+S/Iy2nTcYiJpLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=hEU+3W/IPsghrjN4b2nKPKojaTYR4CW/T+JI4vHR/Uqm9og1P0kcRuryb1kuHLy0sm
         Rbx3YLne0AnGqzhtYxs1NYT+gasqX6ZEnz+CZVvWBNqxAZNhRhVQVzgemlHKQT87kUm1
         TXnWGtC9LaPd65U5mdZe/RfGtWZgol+W2L1Zo=
Received: by 10.223.110.4 with SMTP id l4mr593228fap.125.1300882608113; Wed,
 23 Mar 2011 05:16:48 -0700 (PDT)
Received: by 10.223.117.78 with HTTP; Wed, 23 Mar 2011 05:16:28 -0700 (PDT)
In-Reply-To: <m3y646ujgy.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169824>

On Wed, Mar 23, 2011 at 1:11 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>> 2011/3/22 SZEDER G=E1bor <szeder@ira.uka.de>:
>> > On Tue, Mar 22, 2011 at 11:28:01AM +0100, Erik Faye-Lund wrote:
>
>> > > But even so, at least 25% of the git user base is on Windows,
>> > > according to the latest Git User Survey. That makes this stuff m=
atter.
>> >
>> > The other point of view is that it will cause a regression without=
 a
>> > compensating benefit for maybe more than 75% of the user base ;)
>
> [...]
>> (Warning: speculation ahead)
>> Also, I suspect the numbers of Windows developers are
>> underrepresented, for two reasons;
>> - I suspect that Windows developers are less likely to be subscribed
>> to the mailing lists where the Git User Survey are promoted.
>> - I suspect that most Windows users use EITHER Cygwin OR MinGW, but =
I
>> intentionally picked the largest of the Windows categories instead o=
f
>> adding them up because the Git User Survey allowed people to answer
>> both MinGW and Cygwin.
>>
>> User Survey people, if your read this: please have a separate
>> operating system question next year. It's very valuable information!
>
> This information can be extracted from survey data, so there is no
> need for separate question.
>
> Prior to adding this information to GitSurvey2010 page on git wiki,
>
> =A0https://git.wiki.kernel.org/index.php/GitSurvey2010#09._On_which_o=
perating_system.28s.29_do_you_use_Git.3F
> =A0https://git.wiki.kernel.org/index.php?title=3DGitSurvey2010&diff=3D=
14112&oldid=3D12212
>
> you could get this information by going to 'Analysis' page
>
> =A0http://tinyurl.com/GitSurvey2010Analysis
>
> selecting last filter: 'F13 - OS: MS Windows (any)', writing down
> number of responses: 2671, and calculating percentage relative to
> number of all responses to Q9, i.e. 8541, and you get 31.27% of
> people using Git on MS Windows (not counting 'other, please specify'
> responses, but they are very few).
>
> Or you could have extracted this information from responses data,
> which is available on GitSurvey2010 page...
>

OK. Thanks for explaining this :)
