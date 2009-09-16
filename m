From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [msysGit] [PATCH 02/15] Add define guards to compat/win32.h
Date: Wed, 16 Sep 2009 12:10:18 +0200
Message-ID: <4AB0B98A.6090006@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>	 <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com>	 <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com> <40aa078e0909160242s4110ca8fj1e44e1e228676704@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org,
	lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 12:10:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnrTQ-0006cs-B2
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 12:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504AbZIPKKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 06:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282AbZIPKKn
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 06:10:43 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:61445 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbZIPKKm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 06:10:42 -0400
Received: by ewy2 with SMTP id 2so1264363ewy.17
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=uJMQ1Noc7ympTbeA44/IcYwaOrcLJgoBTna6N8NA130=;
        b=Fidpnqk/KCx0adb9gXoD7uzo+S3hxodmRwbrxVsvts3SA6G2JjnCfcQhxL4zUSaUGZ
         t/M4z8DZW/TtPuHpLre5MPIzBDYfHH1bJu2sIidYff0byKGlDg1lMQzG/eij7OxXdEqO
         CvYcVX8EVxzcZjcfppG8OJQ0t3FBYDe2rQKxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=oanDAvKyYXUFozvQWN9m9i+VU/P43AmHt/aT3nABjutGwt/1MV1B6O3K/Lde8/U1SJ
         lhrWp9sdOV+r3mL28VZsBZGWzqEsL+DOdgQZAj8sPUm/939m+abpwJUTV/iFWD4kTzAi
         A4+BRhhD9S929T0CBj77E1BZVXPyREDGu7aMQ=
Received: by 10.211.154.18 with SMTP id g18mr9844092ebo.70.1253095845384;
        Wed, 16 Sep 2009 03:10:45 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm1660491eyd.16.2009.09.16.03.10.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Sep 2009 03:10:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <40aa078e0909160242s4110ca8fj1e44e1e228676704@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128636>

Erik Faye-Lund said the following on 16.09.2009 11:42:
> On Wed, Sep 16, 2009 at 10:20 AM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
>> --- a/compat/win32.h
>> +++ b/compat/win32.h
>> @@ -1,3 +1,6 @@
>> +#ifndef WIN32_H
>> +#define WIN32_H
> 
> Aren't these usually called "include guards" instead of "define guards"?

Yup, of course they are. *thump*

--
.marius
