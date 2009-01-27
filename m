From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: friendlier names
Date: Tue, 27 Jan 2009 11:17:17 -0800 (PST)
Message-ID: <m37i4gy2z6.fsf@localhost.localdomain>
References: <87mydc6a2r.fsf@mcbain.luannocracy.com>
	<20090127153837.GB1321@spearce.org>
	<7vwscgy56b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 20:18:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRtSR-0001jJ-Vp
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 20:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755722AbZA0TRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 14:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755638AbZA0TRW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 14:17:22 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:55990 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331AbZA0TRV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 14:17:21 -0500
Received: by fxm13 with SMTP id 13so1805282fxm.13
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 11:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=6g5cqasD0BaatpCEPpJqQ625f/e39qJm85rY8w8YQak=;
        b=lgaWmyNjXeeyQB8RirB+QDFt471YpRstvF9aJiNQQIGMQW9QcObhXzFuVVBVA7UplI
         Lz5CnzSnJpWa4evT/N61QSyEEWTRVWiFZHjpnFZCObYUFkZS3XNLfinHt7Ujt+jouuzX
         e8XYM2xrLk20WQaLk1XxdD8weyvXTyVbF4TK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=PPkJDnbYRlB8iSO0LlpVpGZFyd6shD7PN95tNq/KjfQrVaTEqkpSKJYzBY6xl0r8RW
         HeKyTMTmz/9yHXHASAePVnMlrhEKRvuF/LAg5RHuFduXI7ddu6tNJgb1OmyKnNtEeU7n
         Io2vJXpWB6TRHX0KD05TuSvuiqoDs/ggaLV+U=
Received: by 10.223.110.11 with SMTP id l11mr262189fap.50.1233083838688;
        Tue, 27 Jan 2009 11:17:18 -0800 (PST)
Received: from localhost.localdomain (abvq8.neoplus.adsl.tpnet.pl [83.8.214.8])
        by mx.google.com with ESMTPS id z10sm25421788fka.13.2009.01.27.11.17.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 11:17:17 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0RJGUlG003987;
	Tue, 27 Jan 2009 20:16:40 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0RJFvDa003982;
	Tue, 27 Jan 2009 20:15:57 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vwscgy56b.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107384>

Junio C Hamano <gitster@pobox.com> writes:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> David Abrahams <dave@boostpro.com> wrote:
>>> 
>>> For example, why couldn't the "index" be called the "stage" instead?
>>> That, along with knowing that "git add" was a synonym for "git stage"
>>> would have flattened the learning curve considerably for me.
>>
>> Historical reasons...

[...]
> The way to update the cache was called "update-cache" then "update-index".
> Because it usually is much rare to actually add a new entry to the index
> than updating an existing entry in the index, the command had a safeguard
> against "update-cache a-newfile" without explicit request from the user to
> say "oh by the way I know I am adding new entries".  "git add" came much
> later to give you a shorthand for "update-index --add".  Updating existing
> entries in the index was still done with "update-index".
> 
> Later Nico taught (after much discussion) "git add" to also serve as
> "update-index" for existing entries in the index.
> 
> We could have called it "git update-index" when we did that switch-over,
> because the operation is exactly that --- updating the index.
> 
> But the name somehow stuck.
[...]

It is a bit of pity that "git add" was overloaded to also add new
contents and not only add new file (and its contents!), instead of
having new command "git stage" to be porcelain version of 
"git update-index" porcelain.  And perhaps "git resolved" to only
mark resolved entries (so e.g. "git resolved ." would not add new
files, nor add new contents of files which were not in conflict).

Now we have to explain that "git add" adds new contents... OTOH
it is perhaps good idea to emphasize differences between Git and
other lesser^W SCMs. ;-)  And introduce "git add -N"... 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
