From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-rebase.sh: Update USAGE string (No. 1)
Date: Mon, 4 Feb 2008 11:15:20 +0100
Message-ID: <200802041115.22409.jnareb@gmail.com>
References: <prvd3i9e.fsf@blue.sea.net> <zluh1sxv.fsf@blue.sea.net> <7vfxw9pnbp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 11:16:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLyN4-0005gN-It
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 11:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbYBDKPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 05:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbYBDKPi
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 05:15:38 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:17055 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbYBDKPh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 05:15:37 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1953214fga.17
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 02:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=opLItPtm98BXJlcHfBiL0D+OCsL/1XvlFXTfe8fquig=;
        b=xcka9/DOcVnBhxYm0v0Nn+DIZ7NubVb03zsCLVtfexOP6vNoSoq0W8839tPMXc4R4WUYfhxFCq6YDHX1k6snieqaLYjeSOeM04V9jCOdtBs/SNK3RPByzVt80LX3+ORjFCQ7OJEJNNWvx7G8ZYmT79EQlrD5JwfjNqfyBcfQVxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eeFXXz9CoY0Np+GkvxdzFw5bLwm9smVIGSRTmFDqX41VQo6oFF6wtN2MKE8oPvgVqqExCbxs6ipyruu/8ZPFerY4WQlfLrp8G9/LbsnN8qbW4t0PALDAANCjhqZr/CaR042nl1Xv3beJMF00+CWSZew637XnhW1cpoLY+Iy/Ah4=
Received: by 10.86.26.11 with SMTP id 11mr2828466fgz.17.1202120135684;
        Mon, 04 Feb 2008 02:15:35 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.221.201])
        by mx.google.com with ESMTPS id e20sm4884907fga.1.2008.02.04.02.15.33
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Feb 2008 02:15:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vfxw9pnbp.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72485>

Junio C Hamano wrote:
> Jari Aalto <jari.aalto@cante.net> writes:
> 
>> * Sun 2008-02-03 Jakub Narebski <jnareb@gmail.com> INBOX
>>> I would say "[--whitespace=<option>]" or "[--whitespace=<action>]"
>>> instead of introducing yet not agreed upon notation (this has the
>>> advantage of shortening synopisis, which should be short IMHO).
>>
>> The "{a|b|c}" is a used syntax. See cpio(1).
>>  
>>     cpio  {-o|--create} [-0acvABLV] ...

BTW. it is not only cpio and rpm, but also combinediff (and friends from 
patchutils), flex, gimp, jpegtopnm (and other from netpbm), ps2pdf, 
run, tail, xmlto, ip, losetup, netstat, sudo and sudoedit,...

> I do not think using {} for grouping is incorrect, and I think
> there is at least a consensus on the list that it is Ok as long
> as we consistently do so.
> 
> Unfortunately, the majority of, if not all of, our existing
> documents use () instead for that purpose.
> 
> So pros-and-cons are that (1) changing all of them to use {} is
> more politically correct (pro); (2) our use of (), as we
> consistently use them, does not hurt readability (neutral); and

Actually we are not entirely consistent here.  git-init(1) has 
  --shared[={false|true|umask|group|all|world|everybody}]
in the option description, git-rev-list(1) has
  [ --date={local|relative|default|iso|rfc|short} ]
in its longish synopsis (although in second case we could omit
the curlies, it is in separate line so reducing line length does
not matter in this case).

> (3) it is a thankless makework to replace them all to {} _and
> make sure the conversion is correct_ (large con).  

All true.

> (4) also if 
> other people make changes to documentation at the same time,
> that would add more work in conflict resolution (slight con).

Well, we sould have to document this in CodingStyle, I think, then.
 
> About the part your patch touches, [--whitespace={a|b|c}] is
> more precise than [--whitespace=a|b|c] Jakub suggested, but I
> suspect most sane people would not misinterpret the latter as
> "this part can be omitted but you could write '--whitespace=a',
> 'b' or 'c' here", so...

It probably also depends if we deperately want to reduce line length as 
not to split synopsis into yet another line (the shorter synopsis is, 
usually the better).

-- 
Jakub Narebski
Poland
