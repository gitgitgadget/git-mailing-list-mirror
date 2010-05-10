From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control
 end-of-line conversion
Date: Mon, 10 May 2010 12:13:58 +0400
Message-ID: <20100510081358.GD14069@dpotapov.dyndns.org>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
 <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com>
 <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org>
 <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
 <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
 <20100509070043.GB14069@dpotapov.dyndns.org>
 <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
 <20100509200935.GA22563@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon May 10 10:14:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBO7v-0004sq-5z
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 10:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454Ab0EJIOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 04:14:06 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:48223 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab0EJIOE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 04:14:04 -0400
Received: by bwz19 with SMTP id 19so1583156bwz.21
        for <git@vger.kernel.org>; Mon, 10 May 2010 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Dr4qG5qpOMlcQPAdb/NxRwVwoqlvDIo0rEuwaYlLQyk=;
        b=QvWDE2BOW+iEJHIKUXaxCtQHnS/t7/775or/BPbxCueFtIcdtwSTVj1rQPxoJmiLjd
         DhCO2oN8IfIYcaTws9klEk1mzbyzrLj3kUyysDInHm3fvqSTxvuB4ScdnBphaW/4aQGj
         SsF+uWhKrwTBeSxLvqG2vE6Bv+WuzpEjrqzkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FnwhR4XYZ/L6ZWTDyfS6P25xSmQH6SjypTRIUtzhb6MOR9reAISjEejFisMfJJ4IVX
         Xs4+JDTBwKJZz0gWxHvjahU3jDuCLEzj5GEP/PCxAyS5rhAbtVe/66FDBe3+wfZhNTff
         Gm4NY87CcnQhaejx1ngd7fvIirQu2og0eg2wg=
Received: by 10.204.16.73 with SMTP id n9mr2201550bka.21.1273479240867;
        Mon, 10 May 2010 01:14:00 -0700 (PDT)
Received: from localhost (ppp91-76-18-177.pppoe.mtu-net.ru [91.76.18.177])
        by mx.google.com with ESMTPS id 13sm1461721bwz.7.2010.05.10.01.13.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 01:14:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100509200935.GA22563@pvv.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146770>

On Sun, May 09, 2010 at 10:09:37PM +0200, Finn Arne Gangstad wrote:
> 
> So maybe, just maybe, we can make everything sufficiently good by
> repairing "core.autocrlf = {input,true}" so that git will not convert
> a CRLF already in the repo. This would make autocrlf = true a safe
> default value (and probably input too, but you'd have to "do
> something" to get a new text file with CRLF into the repo then).

First of autocrlf is safe as it is implemented now. Second, to do
something to get a new with CRLF into the repo is really stupid.
The whole point of autocrlf is being automatic and do not have the
user to worry about CRLF when he adds a new file.

The only real problem I am aware of is that some repository are not
compatible with autocrlf conversion, because they store text files
with different endings and do not have appropriate .gitatributes to
describle what text files should and should not be converted. So, each
user has to disable autocrlf in them manually and then re-checkout all
files using (rm -rf * && git checkout -f), which is confusing for many
users. In fact, you do not have to disable autocrlf, you can add a few
lines to .git/info/attributes to make it autocrlf compatible, but again
many users even not aware about this file, let alone what needs to be
added. Further, the problem amplified by the fact that you have to do
the same procedure every time when you do cloning, and though cloning
is not most common operation, it happens often enough to annoy many
users.

I believe that the right solution is to be able to enable autocrlf but
only for those repositories that are marked as autocrlf compatible by
upstream.


Dmitry
