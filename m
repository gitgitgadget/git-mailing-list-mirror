From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] mailmap: resurrect lower-casing of email addresses
Date: Tue, 07 Apr 2009 20:50:11 -0400
Message-ID: <49DBF4C3.8080103@gmail.com>
References: <cover.1238458535u.git.johannes.schindelin@gmx.de> <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de> <49D53ABF.80706@gmail.com> <alpine.DEB.1.00.0904030039290.10279@pacific.mpi-cbg.de> <7v63hmekyv.fsf@gitster.siamese.dyndns.org> <49D542FA.3070304@gmail.com> <alpine.DEB.1.00.0904030107320.10279@pacific.mpi-cbg.de> <49D54799.9010607@gmail.com> <alpine.DEB.1.00.0904030447480.10279@pacific.mpi-cbg.de> <49D6B8C8.8090304@gmail.com> <alpine.DEB.1.00.0904061114420.10279@pacific.mpi-cbg.de> <49DAB5BB.1040100@gmail.com> <alpine.DEB.1.00.0904071315460.6897@intel-tinevez-2-302>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 08 02:52:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrM1P-00062S-W5
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 02:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780AbZDHAuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 20:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755843AbZDHAuQ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 20:50:16 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:15673 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756384AbZDHAuO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 20:50:14 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2810020ywb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 17:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ALQ5eoo+vfc3CUZR+Qoov4rVtjgH+2b6DrTIU8pbPQc=;
        b=DYNupb+NRZNYUvDxdFxG03XoiTPw4U7Dc+3NeYQvVkdlf7WZ95nb+DnWxnP2w1u10Q
         CGK2nlD1Z/KUxOBuOjzmHWDQQBoVkT4N/3zRqkXQBoLh1Y8yeuXWK5+qOEWvPF9tEzOr
         5SqrPSzuNeW3x+3XbRuo4z+RaPHuDAq/K+jGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=VUIq8l5BE+JZATpzh6xDElaFoEwEsw8NKq5Lorvypr2YKZIVfvEbKLMskyLELWTFSm
         5s/K7b7bGrgceFIqjH4SIPn7JTtUAKLZZAoBt2jReJsuXJcF1jtaMMQ2xTJlZ7ekJX1w
         u2cKbds92EMbgxPw2Gpf1i+Jo0dci4v2hRoIk=
Received: by 10.100.125.9 with SMTP id x9mr1610458anc.35.1239151813560;
        Tue, 07 Apr 2009 17:50:13 -0700 (PDT)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id d29sm1826200and.34.2009.04.07.17.50.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 17:50:13 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <alpine.DEB.1.00.0904071315460.6897@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116013>

[CC list trimmed since I don't Junio is that interested in what this 
thread has morphed into.]

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 6 Apr 2009, A Large Angry SCM wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> On Fri, 3 Apr 2009, A Large Angry SCM wrote:
>>>
>>>> Sorry, this is not a flame war (and as Peff already sent a response 
>>>> that superior to my own) so I'll let Junio decide.
>>> Thanks for keeping a cool head where I failed.  My sincere apologies.
>>>
>>>> However, to keep the peace (and as a thank you for all the hard work 
>>>> to date, I'll say that I'm scheduled to be be Germany and Munich the 
>>>> first 10 days in October and I'll buy the first $100 dollars in 
>>>> drinks at any meet that participate in (as a thank you to all the 
>>>> hard work for git that has been performed) that may happen that I 
>>>> participate in).
>>> I'll take you up on that!
>> s/Germany and Munich/Berlin and Munich/
> 
> Cool!  Berlin is only 2 hours from my home, so let's meet there!
> 
> We could even use the opportunity for a little informal German 
> GitTogether... "Alles wird Git!"?

Could you translate that for the Deutsch-challenged among us?

According to the /current/ itinerary, the evenings I have free in Berlin 
are Saturday Oct 3 and Monday Oct 5.
