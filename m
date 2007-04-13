From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 3/3] Teach 'diff' about 'nodiff' attribute.
Date: Fri, 13 Apr 2007 13:54:55 +0100
Message-ID: <200704131354.57056.andyparkins@gmail.com>
References: <7vodlsd4wc.fsf@assigned-by-dhcp.cox.net> <200704131230.41594.andyparkins@gmail.com> <461F6D74.63EF2769@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <J.Sixt@eudaptics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 14:55:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcLJK-0006FU-PI
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 14:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbXDMMzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 08:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbXDMMzJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 08:55:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:22333 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbXDMMzF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 08:55:05 -0400
Received: by ug-out-1314.google.com with SMTP id 44so536188uga
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 05:55:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bwZ9TKCTxUtYUtGSUUgH1ZfqxdKk+oyGb9aXgJpr2+siOiemeBBKp6OKpcY46eRRnpFRC32rAGvnr3qMe/020okOomy2e72c1erRhrcC8SHP+3qudSj6P+uEyMSzVOfxblyYS8zNsZAwakwQ1JmrN/D47Pst1QbQmQHJRI3WA8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Dw1WrPdT3A5fehBR5ILtJJLLQA2dR9cCdjcrA2xxqHsqE4hrA8+U14wGIBGX6wjufVWFFTMgBTVRTzg5zPcntp5iJC9BM8Ql03zEpb91HiBQPPhas7Qx6POD90X6RGL5ffoSRg9O87oQxHh/28O2j2SpQtjLoCSW4X861DRmLmE=
Received: by 10.66.219.11 with SMTP id r11mr1990858ugg.1176468904330;
        Fri, 13 Apr 2007 05:55:04 -0700 (PDT)
Received: from ?192.168.11.214? ( [84.201.153.164])
        by mx.google.com with ESMTP id q40sm5195301ugc.2007.04.13.05.55.03;
        Fri, 13 Apr 2007 05:55:03 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <461F6D74.63EF2769@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44405>

On Friday 2007, April 13, Johannes Sixt wrote:

> Yet in Junio's introductory message, the example was
>
>         *       crlf !nodiff
>
> and it made me think: huh? And then again: huh?
>
> I don't mind if you call me dumb now, but even an intelligent person

Wouldn't dream of it.

> will have to think a second or two about the meaning. That's plainly
> not necessary. In particular, where there can be no difference
> between "diff" and "!nodiff".

As I said, I wouldn't like to make the call.

I understand your point - however I think I understand why Junio chose 
nodiff as the attribute.  I would imagine that git /wants/ to show a 
textual diff for everything as its default.  In that case, the 
attribute that you would assign to the least number of files 
is "nodiff".  Mostly you want diffs, so the attribute implemented is 
for the special case and is "nodiff".

If I've understood the attributes system correctly, it's worth bearing 
in mind that "!diff" is not the same as "nodiff".  The not in "!diff" 
means "supress the attribute diff", not as you would traditionally 
imagine "not-diff".  In this case it doesn't matter because there are 
only two possibilities for the diff engine - show the diff or don't.  
However, more attributes might get added that aren't so simple.

Junio - This makes me think that perhaps "!" is not the right symbol for 
this - that's going to get read by programmers everywhere as NOT, 
rather than suppress.  Perhaps it doesn't matter, I might be 
over-thinking this.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
