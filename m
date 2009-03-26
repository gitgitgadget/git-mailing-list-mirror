From: Andrew Wang <azuriel@gmail.com>
Subject: Re: Use alternate GIT servers to share traffic
Date: Thu, 26 Mar 2009 00:30:18 -0400
Message-ID: <1c7233eb0903252130q190245cavfe077749504f277@mail.gmail.com>
References: <200903252145.30226.thomas@koch.ro>
	 <alpine.DEB.1.00.0903252356160.26370@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Koch <thomas@koch.ro>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 26 05:31:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmhFx-0007o6-Rj
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 05:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbZCZEaY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 00:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbZCZEaX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 00:30:23 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:35464 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZCZEaW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 00:30:22 -0400
Received: by bwz17 with SMTP id 17so350900bwz.37
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 21:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nzGVek3lVCdj8o2i0qhNYJD0/OiB8F//PLEFpfexT7I=;
        b=Eap38pAm4ZA6q5tKmQuphIzB8CTQBOL4+0zZHbP2MRrb70fgRy/RSpaWHA+xz7IFx9
         SG15tYUSQsJ4rIgc6HQOTuU8SQruwjjffBHwY6u3MfXcF8a6G4tpDtCAtzofZbbgvcpW
         kFxKvv7GeZBisAcifeXyHtboOj85JNQEkU0M4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QwTuqU2SYpDamXAUNyllcqhJiZPNGTT1w+8sA6s4+iyH817IX5GyOj10UjcN4QslDf
         gy0+Uj4OxyaJghROg36XXB0c9TvApZOk/qbEraz3fOo+5wfhJp7vaFvHcrsEf8AGTpQw
         WgPZVTVyrqya1PpONvXqK938rRE+HnikccYQI=
Received: by 10.103.192.2 with SMTP id u2mr172172mup.95.1238041818863; Wed, 25 
	Mar 2009 21:30:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903252356160.26370@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114723>

On Wed, Mar 25, 2009 at 6:57 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 25 Mar 2009, Thomas Koch wrote:
>
>> we host a public GIT repository on our high availability company
>> cluster. Cloning the repo causes a trafic volume of 326 MB. We'd lik=
e to
>> avoid that much trafic while still leaving the GIT repo where it is.
>>
>> I could imagine the following conversation between the GIT client an=
d
>> server:
>>
>> Client: Wanna clone!
>> Server: You're welcome. Please note, that while I serve the most cur=
rent
>> state, you can get objects much faster from my collegue Server
>> CHEAPHOST.
>> Client: Thank you. Will take all the objects I can get from CHEAPHOS=
T
>> and come back if I should need anything else!
>>
>> The enduser should not need to specify anything, but only the regula=
r
>> git clone EXPENSIVEHOST line.
>>
>> Your thoughts?
>
> That sounds a lot like the mirror-sync idea.
>
> Ciao,
> Dscho
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

Yea, that would definitely fall under mirror-sync functionality. I
wrote up my GSoC proposal for implementing this to the list
(http://marc.info/?l=3Dgit&m=3D123795365411979&w=3D2), comments and
criticism welcome.

Andrew
