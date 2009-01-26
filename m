From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Translations [of Documentation] in Git release?
Date: Mon, 26 Jan 2009 16:31:17 +0100
Message-ID: <200901261631.18157.jnareb@gmail.com>
References: <60646ee10901250941s34f7accem1b74fc201e895a41@mail.gmail.com> <m3hc3mxn9d.fsf@localhost.localdomain> <Pine.LNX.4.64.0901261426350.7798@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Dill <sarpulhu@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Jan 26 16:33:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRTSN-0006DC-FN
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 16:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbZAZPbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 10:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbZAZPbe
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 10:31:34 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:12376 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbZAZPbd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 10:31:33 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1280313eye.37
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 07:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ExawDnWCF51tdB5MEptLpI+n06Qf9h1ebWh0nJTh68s=;
        b=dzwuxWrKEWrgiFr9OE8utCOsiPUNgiramBqsoeo7afaYkCJw11pT3OsA1ztUhxvLio
         Ffp/SKLBxnU35dCDCMemH+GEa4FpYmIkGh8MIav1qGFAkSl9HySxsBho/C2NhYHfOnPo
         OOCl5PQPZqBotUG886sXoIP0Ql5s3cznppTiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZwtnD7/YPsf052dLp/URk8IXmd+oF81gfxXQPKxNR7VTL8b5xonaxMZH7fNsOAxf05
         qmcmnUg7LAPP5RWwUTHrvaDJruouzqAlUnv7JXBsiDU/ryecEwh2/qu0I0wa7nAhQqcd
         5RuIk5Ohwjj4ZdKnaDAG6pPPDvRh6sje8Y1S8=
Received: by 10.67.106.13 with SMTP id i13mr1334643ugm.7.1232983890112;
        Mon, 26 Jan 2009 07:31:30 -0800 (PST)
Received: from ?192.168.1.15? (abvk161.neoplus.adsl.tpnet.pl [83.8.208.161])
        by mx.google.com with ESMTPS id 34sm4595128ugh.10.2009.01.26.07.31.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 07:31:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0901261426350.7798@ds9.cixit.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107219>

On Mon, 26 Jan 2009, Peter Krefting wrote:
> Jakub Narebski wrote:
> 
> > With GUI translations we just use gettext conventions. I don't know
> > any such convention for docs:
> 
> There is a lot of documentation being translated using PO files. po4a -
> http://po4a.alioth.debian.org/ - is a nice starting point for that.

I'm not sure if XLIFF wouldn't be better format to use to translate
_documents_.  Gettext was meant to translate, I think, not very long
messages in programs.

Also I am not sure how much support this idea has. True, in last Git
User's Survey[1] 63% to 76% wanted (parts of) Documentation... but that
was out of 325 people who answered this question, with 3236 responses
to survey in total, so numbers are more like 6% - 8%.

[1] http://git.or.cz/gitwiki/GitSurvey2008
[2] http://translate.sourceforge.net/wiki/

-- 
Jakub Narebski
Poland
