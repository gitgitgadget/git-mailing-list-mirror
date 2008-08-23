From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: About git pretty
Date: Sat, 23 Aug 2008 01:04:09 +0100
Message-ID: <e1dab3980808221704h3c713e64n41adc631d7a79601@mail.gmail.com>
References: <94a0d4530808221624m26034923pbc1f97cb4c4203d8@mail.gmail.com>
	 <7vd4k062k2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 02:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWgd1-0002LJ-8P
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 02:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295AbYHWAEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 20:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754311AbYHWAEL
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 20:04:11 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:54096 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198AbYHWAEK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 20:04:10 -0400
Received: by wf-out-1314.google.com with SMTP id 27so918546wfd.4
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 17:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=f5rsQMtmmg/EDjKK3HuJxy5ye3KUjRFTiO2W/bwy2oM=;
        b=eVo2eeKK+TU87oi7VxxHe4ZP5DkNzpIjibxnzCXcmSZZr5JDkjIlgD5Y4thoPaW/PY
         lFjSrbU0X0S62p9Yz3woILsEJlGa1DIIWHDBAK3s+0ijKqAt1xL+v0EjpUqrZAPF/Frs
         ha40XI8VHT6BybBtMue0M3xEuIF9T8ZQoCdPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=C7Ec74eNMZfFNhJw2xtEPTupJVz2yYhrXabmy7zOIyOy0hn26qXoNfRsbXByum0ng3
         KVmtoyD1XtyZ9cywWIdpN6teRdEZm+JXppBIxy0m8qu3GZvs6NqtyXt0JyjQEjGBcsDx
         6YGGKUNHL/di+84ruuOrSTGvrY0A4YcZLNzEw=
Received: by 10.142.240.19 with SMTP id n19mr604902wfh.332.1219449849477;
        Fri, 22 Aug 2008 17:04:09 -0700 (PDT)
Received: by 10.142.136.18 with HTTP; Fri, 22 Aug 2008 17:04:09 -0700 (PDT)
In-Reply-To: <7vd4k062k2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93406>

On Sat, Aug 23, 2008 at 12:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Felipe Contreras" <felipe.contreras@gmail.com> writes:
>> It is just me or 'pretty full' doesn't exactly convey the meaning of
>> the action to execute?
[snip]
>> If you like the idea I can work on a patch.
>
> FWIW, I don't like it.

It's probably much too late to change conventions given the number of
deployed scripts, but one of the annoyances for me about git is that a
lot of the commands/options names are based on what the code does/is
written rather than relating to what a user who doesn't know or care
about the inner workings expects as output. For instance, I imagine
the --pretty gets its name because a pretty printing routine, called
pretty_print_commit in the code, was written but the name probably
doesn't make much sense to anyone who's not from a computer science
background. Likewise the options --hard, --soft and --mixed to git
reset lack any natural mnemonic structure. (I'm sure one can be
contrived, but I doubt it'd be particularly natural.) Then there's
git-fsck and gitk.

It's not remotely a big problem but it is something that I'd imagine
would have been done differently with hindsight.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
