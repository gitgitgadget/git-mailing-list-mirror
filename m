From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 26 Nov 2007 22:14:53 +0100
Message-ID: <200711262214.54291.jnareb@gmail.com>
References: <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <85lk8k24ju.fsf@lola.goethe.zz> <alpine.LFD.0.99999.0711261511240.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:15:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwlIU-00014s-PU
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 22:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbXKZVPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 16:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbXKZVPA
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 16:15:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:24938 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbXKZVO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 16:14:59 -0500
Received: by nf-out-0910.google.com with SMTP id g13so882510nfb
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 13:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=qu+gzQT27NxAXbhCHjtEjhTHfz030jxZURhw2F1RFoU=;
        b=bDu+zBx8hNbmnOJ+sYz++ozfY5UneBQCqKSZkAbqT2wjaVVdi5Sz23mrGohsa4eXgTblm0aoAqbRP0N9StYIghzP4h3cRh61lFD4EwtDsh0vxP6Vr6VZ9nbFy+sG4RDl967Vqqsnz1pUf3sZ4sISDaOsQjhRVMRCHLce2YzwF0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MJBRpgPX2RSVgFlOqPqo6kNIbU6IhQzJol0ZKyPSHmokwSwM/bH7YqU+TETe7LyGMTTMcnjGjeNNDiV1hYBxMByfolXTeqoYCU8YWtRo0kNntCPoEz5LdDRrkYoFfS4RJ5Nr/ZhO1AYO6shROUqnXvVhRDPE8WqOWxaLcgZq/jE=
Received: by 10.86.84.5 with SMTP id h5mr3079225fgb.1196111697210;
        Mon, 26 Nov 2007 13:14:57 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.221.183])
        by mx.google.com with ESMTPS id 3sm2721725fge.2007.11.26.13.14.54
        (version=SSLv3 cipher=OTHER);
        Mon, 26 Nov 2007 13:14:55 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.0.99999.0711261511240.9605@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66124>

Nicolas Pitre wrote:
> On Mon, 26 Nov 2007, David Kastrup wrote:
> 
>> Nicolas Pitre <nico@cam.org> writes:
>> 
>>> [ I get really really annoyed when your replies to me aren't directly 
>>>   addressed to me, Jakub.  Told you so repeatedly in the past as well.
>>>   Why are you the only one on this list apparently not able to use a 
>>>   proper email setup? ]

It is about proper _newsreader_ setup, in fact...

>> X-Injected-Via-Gmane: http://gmane.org/
>> 
>> And Jakub by far is not the only one using gmane for reading and writing
>> to the list.
> 
> It is strange, though, that Jakub is the only one I've noticed who isn't 
> able to do me the courtesy of addressing me directly when replying to 
> me.

My responding [sometimes] only to list is combination of several
issues.

First, newsreader I use, namely KNode 0.10.2 in Kontact 1.2.3 from
KDE 3.5.3 does not make it easy. By default it replies only to list
unless Mail-Reply-To header is used (which shouldn't IIRC). I have
to click reply by e-mail button to send reply via email... and it
adds only last author, from  From header. The rest I have to add by
hand.

Second, something is rotten^W broken between GMane and VGER; if I add
git email address to the list of addresses to send to, VGER rejects and
refuses to send to git mailing list. I have to send also to newsgroup
(gmane.comp.version-control.git) to send to all git mailing list. Now
it looks like two mails are actually send: one to CC'ed addresses, one
to git mailing list, and sometimes people when replying me forget to
reply also to git mailing list.

So third, when I don't think I have something significant to contribute,
and I don't necessary expect answer, I send email only to git mailing
list (news message only to GMane newsgroup coupled with git mailing
list, actually).


Sure, one of solutions would be for me to change newsreader, for example
to Gnus (as people using Gnus doesn't seem to have the same problem
I have), but I think you do know that it is not easy to change habits.

[cut]

Nevertheless, mails are sent to git mailing list, so they should go
to you too.

-- 
Jakub Narebski
Poland
