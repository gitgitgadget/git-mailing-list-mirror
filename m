From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: jGit Eclipse Plugin Feature
Date: Sat, 07 Mar 2009 19:40:26 +0100
Message-ID: <49B2BF9A.9030405@gmail.com>
References: <efe536470903070205w1dbff989je6dd6126d09e4a74@mail.gmail.com> <49B299B7.80009@gmail.com> <200903071845.20855.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Navarro <crshman@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 19:45:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg1WS-00063x-TW
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 19:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbZCGSkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 13:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbZCGSkn
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 13:40:43 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:63859 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbZCGSkm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 13:40:42 -0500
Received: by fxm24 with SMTP id 24so759583fxm.37
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 10:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=09Gixb7AxJtPw374HMTQ57SOVzCU409KL3zkGpYMQNk=;
        b=OiJuDWx0qvci8nHtuQF4lZyc3jP0sY5/6eQms6jpyxELByIZ4rdVrPMHlEDokpDaRo
         zEwIhbN5B+2aXg9MGuqdmlhhD6JdezEZf6rRFR/Kmrh6KI5Reum0Tqo2ycX2bn9onMKN
         sPjhpCD4fUjReBZty7tdt1tuBqBvNxrSH206k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ZQI3kvkbSXa+bu2TNlMs5Hd8IyZQlHYxH93GqtV3Ys62bQ63moqxaKMfKoeJ+Qy1ek
         RIOXXOWTDx+HJVAowDyVHxYly0PmV2trj7TuPzCToerZZfsDrErTNAqZUtLoHF5utN6F
         1P+lMQ38riSZYmFvJfObuB8mNQgEtndHCoTVo=
Received: by 10.86.82.6 with SMTP id f6mr2813293fgb.42.1236451239033;
        Sat, 07 Mar 2009 10:40:39 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id d4sm1268579fga.5.2009.03.07.10.40.38
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Mar 2009 10:40:38 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <200903071845.20855.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112560>

Robin Rosenberg wrote:
> l=F6rdag 07 mars 2009 16:58:47 skrev Tor Arne Vestb=F8 <torarnv@gmail=
=2Ecom>:
>> Robert Navarro wrote:
>>> Hello,
>>>
>>> Sorry about my last "subscribe" email, skipped over this part in th=
e
>>> wiki...."You don't even need to be subscribed to post, just send an
>>> email to: "
>>>
>>> Anyways.....I wasn't sure where to post this but I'll give it a sho=
t
>>> here.....I know there is an eclipse jGit plugin in the works and I
>>> wanted to know if it would be possible to get a remember or recentl=
y
>>> used servers feature added to the push/pull feature.
>> I have done some initial prototyping of a Remotes View. I'll see if =
I
>> can bring that to life somehow.
>=20
> I assumed the feature is about the push dialog. If we have a remotes
> view it'd be nice to see it there too.

Yepp. I imagine something like a list of remotes, which can be
referenced at any point a remote is needed, like the push dialog.
Wizards that need a remote, can display the list of the existing
remotes, with a "create new" option, which would launch the page from
the "create new remote" wizard (similar to the "Add new CVS Repository"
stuff). Something along those lines.

> Where should it remembered? In the workspace or .git/config?

Good question. Will need some thinking :)

Tor Arne
