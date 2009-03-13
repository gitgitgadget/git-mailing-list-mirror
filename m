From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Sat, 14 Mar 2009 01:48:04 +0530
Message-ID: <ab9fa62a0903131318u47abdc68qefe971bb6d76e8e6@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.10.0903110931070.13653@asgard.lang.hm>
	 <ab9fa62a0903111007w4772b234x8e6fd19cdc7fc595@mail.gmail.com>
	 <alpine.DEB.1.10.0903111223470.16753@asgard.lang.hm>
	 <ab9fa62a0903111302j46c46c2q96af497fa2ac513e@mail.gmail.com>
	 <alpine.DEB.1.10.0903111307050.16753@asgard.lang.hm>
	 <ab9fa62a0903120542s45b1ceebwddab932891c47cf0@mail.gmail.com>
	 <alpine.DEB.1.10.0903121100360.16753@asgard.lang.hm>
	 <ab9fa62a0903121123v35004215hbb64f0ad65399d9f@mail.gmail.com>
	 <49BA2A4E.3030506@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Fri Mar 13 21:25:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiDx8-0001VG-0N
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 21:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbZCMUY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 16:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753534AbZCMUY0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 16:24:26 -0400
Received: from mail-gx0-f165.google.com ([209.85.217.165]:37374 "EHLO
	mail-gx0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbZCMUYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 16:24:25 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Mar 2009 16:24:25 EDT
Received: by gxk9 with SMTP id 9so354988gxk.13
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fEvOEJrdRSGC4dOT1yIs/vpQ3wSrYvi48tn28RSFnZc=;
        b=KJtJ4UvrjS0EIKnLYlX7pwur9aMNqk7wAfi+O+jwCW0g4JMT9gnHiOqR/dQ6ibpi2N
         zoX7RQ6x9Ng9c+SluLe56XsrPFhtP3i8hb17OBjnvxrMX5cavyfHXK29vB8oqniBKnP9
         PG0lj6K644xQDaZQdPegGEtXgLHCSWUqNPurA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qOGOb/uEnKdegGU/OIfG4YZJW7L3oXs1M5oi5/AYFqnqsMKWtk5hNOOYcqsYvBuNIx
         pJwQAuyk1g8VE1lJ7oTC+g+508GTv0ic4vGXdwM71i4bWDNTG4b1zfkM+ye8rvSozC1D
         BR17RCFnl3L3iCxfFpKuld/qbjib0E9QCbR/E=
Received: by 10.231.12.12 with SMTP id v12mr377793ibv.43.1236975484488; Fri, 
	13 Mar 2009 13:18:04 -0700 (PDT)
In-Reply-To: <49BA2A4E.3030506@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113222>

On Fri, Mar 13, 2009 at 3:11 PM, Rogan Dawes <lists@dawes.za.net> wrote:
> saurabh gupta wrote:
>>> exactly. and how you mark the conflict to have it be valid XML is
>>> going to depend on details of the type of file. there are probably
>>> a few basic methods that will work the vast majority of the time,
>>> but with some details needing to be configurable.
>>>
>>> for example, if the XML document is a ODF document, it may be
>>> possible to add 'revision' tags around the conflict that are
>>> already understood by the editor.
>>
>> Exactly. This includes the work to modify the xml tags and add
>> contents to represent marker in the best way.
>
> On the XML topic, one last thing to keep in mind is the DTD/XSD which
> governs the file.

This is another point of thinking. A merge helper changing an xml file
may need to modify the schema file also accordingly. Or, by proper
implementation, the need of changing the schema file can be escaped.
:-|


-- 
Saurabh Gupta
Senior,
NSIT,New Delhi, India
