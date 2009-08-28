From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Fri, 28 Aug 2009 13:05:22 +0200
Message-ID: <46a038f90908280405o1e86bf4fo60eb07957ce9158a@mail.gmail.com>
References: <87praj90n8.wl%catap@catap.ru>
	 <1251228341-29434-1-git-send-email-catap@catap.ru>
	 <4A97B1F3.5060408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Kirill A. Korinskiy" <catap@catap.ru>, gitster@pobox.com,
	git@vger.kernel.org, peff@peff.net, B.Steinbrink@gmx.de
To: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 13:05:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgzGu-0003fC-St
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 13:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbZH1LFW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 07:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbZH1LFW
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 07:05:22 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:55519 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbZH1LFV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2009 07:05:21 -0400
Received: by ey-out-2122.google.com with SMTP id 25so410819eya.19
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 04:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uJXPy8455rxb6FWxzxqdmgFHqmzgx7/msSL81MkxZas=;
        b=YVtFbU09QU3e4821VF0gwmWEQPQbln3tkYtTXNlgAX9IgbptP4r1tXKnRIpXSmUAwm
         h8jqLJIKHjqHg30eA9ZrRas3jE36QCXMJtH0vVS+WV5UN2IcdBqpoOXZfOJbqNt24Kv4
         SiA8GyznLODFoq2lqqmi3nETdUpAS15xPbsWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UcJHIiELNlDeHypIp/7UbN/FAZawsEBUQGEWOSdpYmCXOwzhRnkNEM0gq38PRX/iWM
         2o+ZoQ4jrXiYeEFdUbk9Cdaef+nEf3h0Ph0Jg4Os7OsY4+JJYvwMhO3KGrcVqhF7LzX7
         BXJC8FjphG43wOx71Mm0cjwg3UjxY6w/jmWGw=
Received: by 10.211.158.8 with SMTP id k8mr1084750ebo.38.1251457522894; Fri, 
	28 Aug 2009 04:05:22 -0700 (PDT)
In-Reply-To: <4A97B1F3.5060408@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127289>

On Fri, Aug 28, 2009 at 12:31 PM, Tor Arne Vestb=F8<torarnv@gmail.com> =
wrote:
> Glad to see this topic being revised. Here's the original discussion =
for
> reference:

ISTR that early git supported this -- maybe just on the HTTP
implementation? I sure remember writing

   git clone http://host/foo.git#branchname

and getting a cloned repo where 'branchname' was tracking
'origin/branchname', and was checked out as HEAD.

It would have been dropped by the switch to C builtins :-/

cheers,



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
