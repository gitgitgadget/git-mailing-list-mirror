From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: Experimental TDB support for GIT REFS
Date: Wed, 2 Jul 2014 10:11:10 -0700
Message-ID: <CAL=YDW=pHB4sjpxjYvO_w=RadK4Rhq6Zp+pc+NAqWT3hWjkWXg@mail.gmail.com>
References: <CAL=YDWn-CGZGr5bXNTiZmzr4-w_8CERx3r2bmLWbczqJ0Sn7dg@mail.gmail.com>
	<CAJo=hJu3QD09JccSvUrpnNSpFE5ppDHEzozkKyZZAyutvCQTGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 19:11:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2O3w-0000Mc-7X
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101AbaGBRLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:11:12 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:37803 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756985AbaGBRLL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:11:11 -0400
Received: by mail-ve0-f174.google.com with SMTP id jx11so11366381veb.5
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G3RE22qRrARhVCqhOQTeIXoobyV/0dKFY3rvD8LKnX4=;
        b=R8SXZ4Hc/Xe+u937uR1CiutTTfPyNss3ocCZQJBiwzIMdjN8dzrkIO1XWlu2U10fgN
         PtUdcn7g+2a+4xN6TO68QRhlEB/AaDkox5drkcw6o+LoilbRmyoJeYmX25CMzlfYvd38
         7V2hVX81ET8YhvRl3s0Vqku8G5dlr+basggSbQaNLmz++QH5VxRh1a2pe7TwqLXSzzIF
         TOEIH+YT8dGdC58Cz3kUTie5hlLJMQ8PW8/F7uu3vkFNnqFQT856tiOVTa/YRLfV0AtG
         HsVOeisfwCXe5NCELYSFc0S32/mF+nMxH0yBIOBfyc0iB9g954TB+OKxy6i98xDGuyMt
         AVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=G3RE22qRrARhVCqhOQTeIXoobyV/0dKFY3rvD8LKnX4=;
        b=JufRvkxHHWjexYosTEqQp4XTI0Osf46nKSLYdMYO0lgDsffx9fN417pXf5h5/tTpQj
         qkfdFsugVMpj+CJ0mMF3qmr6BCgK0KjBuBBqF8hu+yrxli0oDRAfZweCCgCJg5H4Ogpy
         Vy3asAfStET7ltb6JuEwXV0EP8n4/AMgFI8nc+g+0uoH1K0AHX89ov1VylHuHbuXiwF0
         DR5s0rjUQnfkNGcFOnmDXSlMsT9mJ+zh6hY+9k8hyhs+Af1uFxa1jUShI7SAAjrbSXMn
         dVIm0a3KsrArf599HHC8S4FqEe06pSLHc6o/vI2NZgCRoDvs7XfUTdrSvX6LCTyZbC+w
         VVhg==
X-Gm-Message-State: ALoCoQlcPz52tk+am5EX6EcXM8FuucEauzBdRfy3o0A1tVjtH6Vj12fO2yiVBjud1EsNbD4KLg88
X-Received: by 10.52.53.36 with SMTP id y4mr1028355vdo.56.1404321070430; Wed,
 02 Jul 2014 10:11:10 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Wed, 2 Jul 2014 10:11:10 -0700 (PDT)
In-Reply-To: <CAJo=hJu3QD09JccSvUrpnNSpFE5ppDHEzozkKyZZAyutvCQTGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252801>

On Fri, Jun 27, 2014 at 5:37 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Fri, Jun 27, 2014 at 2:30 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>> List,
>>
>> One of my ref transaction aims is to make define a stable public API
>> for accessing refs.
>> Once this is done I want to make it possible to replace the current
>> .git/refs/* model with a
>> different type of backend.
>> In my case I want to add support to store all refs and reflogs in a TDB database
>> but once we have a pluggable backend framework for refs, if someone
>> wants to store the refs
>> in a SQL database, that should be fairly trivial too.
>>
>> There are a few series queued before this becomes possible, but is
>> anyone wants to test or play with my "git can use TDB database" you
>> can find an implementation of this at
>>
>> https://github.com/rsahlberg/git/tree/backend-struct-tdb
>
> Interesting! But the link 404s :(


Yeah, sorry but there were issues :-(   Issues solved now though and
refactoring done.

Please see
https://github.com/rsahlberg/git/tree/backend-struct-db

This branch adds a refs backend that communicates via a domain socket
to a refs daemon.
The refs daemon in turn interfaces with the actual database.

My branch contains one hack refs daemon that uses a TDB database for
the refs storage.
This daemon is only about 600 lines of code, most of which is
marshalling and socket handling and only a small amount of
TDB specific code.
This small daemon should make it easy for folks to add arbitrary
database interfaces easily.
Taking refsd-tdb.c  and modifying it to instead attach to a SQL
database should only take a few hundred lines of changes or so.


To build the daemon and start it :

$ gcc refsd-tdb.c -o refsd-tdb -ltdb
<create /var/lib/git and /var/log/git>
$ ./refsd-tdb /var/lib/git/refs.socket /var/lib/git /var/log/git/refsd.log

Then you can inspect the database with
tdbdump /var/lib/git/refs.tdb


You can then create a repository that uses this database :
$ git init --db-repo-name=ROCC --db-socket=/var/lib/git/refs.socket .

Then further commands will operate on the refs tdb.

See this as a prototype to experiment with and see the direction of
the refs transaction and pluggable backend support.
There is a lot additional work and cleanup that needs to be done
before this will become production code.

(yes I know we should not do hand marshalling and unmarshalling for
the PDUs on the domain socket. We should use some lightweight encoding
library like XDR and rpcgen or similar.)


Please test, comment and have fun.

regards
ronnie sahlberg
