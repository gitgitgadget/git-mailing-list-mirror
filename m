From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 0/2] Lazily generate header dependencies
Date: Wed, 6 Jan 2010 03:36:43 -0600
Message-ID: <20100106093642.GA10650@progeny.tock>
References: <4B0F8825.3040107@viscovery.net>
 <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
 <20091127174558.GA3461@progeny.tock>
 <20100101090550.6117@nanako3.lavabit.com>
 <7vwrzwnirz.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1001061024400.11013@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 06 10:36:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSSJt-0007C2-TS
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 10:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab0AFJgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 04:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755514Ab0AFJgp
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 04:36:45 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:61103 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab0AFJgo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 04:36:44 -0500
Received: by iwn32 with SMTP id 32so1471224iwn.33
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 01:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dPTbn4va3LeROelOz8Q4y8QdAGcTupqyUOtD8+l3QL0=;
        b=sJ9poIqYn28C/B7ueqf6e0uiQIHQ2Eco5H1Vbfr9tFitjiQ5zJuK8wv/mF6m0e+Zkf
         mQsJ8mF55puwJ7Esvt0DAsUWMmn/lpuFrzguJjBv4NMG5FerdEG5StDurRK6JckDlw16
         rLSPOCBatnrCkRbG+dk3lpLCIbRTyi9ikNraA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DvUOjarVecYXmlrAyCz4xd9nO/FgD0VWvk0wUj/QdZPIAZZsv2/pv3wiPl6JMfxZat
         OMC6i5Q/o13URRN1im+qgkECENDJeUkbpjqOvWsr2dZ9uYNJ6YA/53kZJB6GHtk9qPGo
         BKLfVWYs39VAvBCHPa2ScZ68nMO6eq8ETGnjM=
Received: by 10.231.146.2 with SMTP id f2mr66281ibv.23.1262770603251;
        Wed, 06 Jan 2010 01:36:43 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm19305066iwn.7.2010.01.06.01.36.41
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 01:36:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1001061024400.11013@intel-tinevez-2-302>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136257>

Hi,

Johannes Schindelin wrote:
> On Tue, 5 Jan 2010, Junio C Hamano wrote:

>> I was mildly interested in the series, but after this:
>> 
>> http://thread.gmane.org/gmane.comp.version-control.git/133872/focus=133911
>> 
>> the progress seems to have stopped.
>
> Like I said yesterday, I do not want to spend time chasing old threads.  
> But if you spend just two more minutes to summarize what came out of that 
> thread (two well spent minutes in the global time balance, if you ask me), 
> I will gladly comment.

I received some feedback (a suggestion to tuck the makefile snippets in
a separate directory and a follow-up suggestion to make the list of
directories needed for this more maintainable) but have not sent an updated
patch yet.  Hopefully tomorrow I will have more to comment on.

Apologies again for the long silence,
Jonathan
