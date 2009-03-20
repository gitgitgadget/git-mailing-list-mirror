From: John Tapsell <johnflux@gmail.com>
Subject: Re: Adding History
Date: Fri, 20 Mar 2009 05:25:25 +0000
Message-ID: <43d8ce650903192225wdd2c46ai7954afbb0034ba53@mail.gmail.com>
References: <loom.20090319T173541-173@post.gmane.org>
	 <20090319174732.GS23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Roger Garvin <yoyodyn@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 06:26:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkXFy-0001te-I6
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 06:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbZCTFZa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 01:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbZCTFZ3
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 01:25:29 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:10193 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbZCTFZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 01:25:28 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1036968wff.4
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 22:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9OdMaAZOvB9tBDsAB0FpqQiMbNDygcrv9/VY+agfnn4=;
        b=ozy5EmtwqYp8uQyCkcwL09/pyxmXwFr2tyRUtc8tkYS1PZYEfiG1gRzeOiWSSJuCW7
         bYoF6SFYCnIkqvOosU0SN36Hmoxhf7s93CV9PusfDOSzgLxh/hGcQj8XlFteeIgo3Sr8
         i+6LjyEH2Mkaj8n9kquf8SCHVyQZ0dW5z/ZD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=c5Barse8ZZJ3zZ7ZjXHdXSyRPTxQ6HoS1IQTkLDzvkbNWj7U2IpaU/VuAFZzkSgYH8
         B8kcabEQYhBV+AUnRh5ZMhDUW3LztxB1QgDkAOODTuJRqoWLsuDFUdRPUhSQeUMzAB8G
         SCZudM8rrQIgti4CdaEjz8UxHUNjWu+3LZClY=
Received: by 10.142.135.13 with SMTP id i13mr1315574wfd.8.1237526726026; Thu, 
	19 Mar 2009 22:25:26 -0700 (PDT)
In-Reply-To: <20090319174732.GS23521@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113895>

2009/3/19 Shawn O. Pearce <spearce@spearce.org>:
> Roger Garvin <yoyodyn@gmail.com> wrote:
>> Is there a way to add history to a repository?
>> We have just started using git, where before we had nothing but back=
up
>> directories all over the place. =C2=A0We created the git repository =
using our
>> existing source directory. =C2=A0Is there a way to now go and add so=
me of the backup
>> source directories to the history? =C2=A0Or would this break all the=
 SHA1 of the
>> current objects?
>
> Right, you need to change the SHA-1 of all of the commits in order
> to insert history in the past.
>
>> I am not sure it would be worth it at this point. =C2=A0But we are
>> still pretty early in our use of git so now would be the easiest tim=
e.
>
> You have two options:

Couldn't you just create import the whole tree and then rebase on top o=
f it?
