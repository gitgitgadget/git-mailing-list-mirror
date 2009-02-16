From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT PATCH v2 00/12] Support customizable label decorations
Date: Mon, 16 Feb 2009 23:49:59 +0100
Message-ID: <4999ED97.7050502@gmail.com>
References: <1234377614-23798-1-git-send-email-torarnv@gmail.com> <200902162157.28316.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 23:51:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZCJM-00065v-V1
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 23:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbZBPWuJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2009 17:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbZBPWuH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 17:50:07 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:56512 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbZBPWuG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 17:50:06 -0500
Received: by ewy14 with SMTP id 14so2079865ewy.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 14:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=nixS7iVosUw8D1MgnKPGw2JzNNVoipqKcwutuXNGXb4=;
        b=AzqCEEGqQRIxdjOTcQN1mnUYK1W2On765CqsVurrm4kEsJuJOXE9wVdK71SCQqexB/
         eJsPayD7SX2UcwwuD0T8UdwgDlIjMtGuv4J9jOM67wLJ5G7TeKAN5slUTe8i95bdA/rr
         30Xl/y6a7euH9+DPzvXUYcoL++Fj3KUGBdMjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=IY7/upjmfs4k15hnSNNhtnqw7R9nAZFzXHhvZJGkIlEJwuo0VIhL0RDA+q7U1KwG9p
         OqL3ob5dZM1BOhqiZSRhQuQh2jh9hN7PpLjST+VTeicsGEI/gpglAC6TP0W8yYEktPVA
         DN6Idt6WC+qZy5agMnh8UqtsqDxfvHtObAQOU=
Received: by 10.210.59.14 with SMTP id h14mr1168661eba.36.1234824604238;
        Mon, 16 Feb 2009 14:50:04 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 7sm1900289eyb.58.2009.02.16.14.50.02
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 14:50:03 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <200902162157.28316.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110257>

Robin Rosenberg wrote:
> onsdag 11 februari 2009 19:40:02 skrev Tor Arne Vestb=F8 <torarnv@gma=
il.com>:
>> Known issues are:
>>
>>   - If a project has a repository more than one level above the
>>     project directory decorations will fail.
>=20
> That one *is* annoying. My biggest projects don't get decorations now=
=2E..

Ouch. I thought that was a rather rare situation, given that we only le=
t
users create new repos either in the project or the project parent.

I'll whip something up :)

How has the series held up this past week in the update manager? Any
complaints from users or other things I should be aware of?

Tor Arne
