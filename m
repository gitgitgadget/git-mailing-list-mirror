From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Use config file or file for repository owner's name.
Date: Wed, 30 Jan 2008 19:36:31 -0800 (PST)
Message-ID: <m3bq728y4o.fsf@localhost.localdomain>
References: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br>
	<7vwsprj0sv.fsf@gitster.siamese.dyndns.org>
	<20080131023629.GB7778@c3sl.ufpr.br>
	<7vsl0eg16c.fsf@gitster.siamese.dyndns.org>
	<7vabmmg0cb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 04:37:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKQEf-00055Z-CF
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 04:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676AbYAaDgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 22:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756402AbYAaDgg
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 22:36:36 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:31115 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793AbYAaDgf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 22:36:35 -0500
Received: by fg-out-1718.google.com with SMTP id e21so449999fga.17
        for <git@vger.kernel.org>; Wed, 30 Jan 2008 19:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=L4BO5m54cASoy6O5w5UuJYxaolLdQtxe63nYs04gskI=;
        b=gHDmhiH10y28Cm/bnIcodpDeTHcxfkxlRM4VnfFlTHvxE7QI2H/Lt9qAsTm3zHbHshcZ9AaZK1L05EYSH5uQ/jjXkngiujK5BmfujR4SUFbOYtaxpHfuaSlnFB/RldVX4Wo/xB85Rr6bOmRkvw2qL/3CpjP8JCFLFdfklcBg85s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=X30WVLUNO/2R3y/NUWqfJDDuFfo9nMWraq/aR71MD2a3v7STU+FknHvoF5IGli8gwffGpi2IuNLwNGEgpcMYUkW4h6NNdaXTafK3Ul25e50wKqrC9JgN2fxaAGoruwBiSEi2bnqKhIKsAgxhno3htE+hWxYUqXZ9lqPGyv64i5s=
Received: by 10.82.114.3 with SMTP id m3mr2836306buc.24.1201750593420;
        Wed, 30 Jan 2008 19:36:33 -0800 (PST)
Received: from localhost.localdomain ( [83.8.211.195])
        by mx.google.com with ESMTPS id 1sm3380679nfv.3.2008.01.30.19.36.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Jan 2008 19:36:31 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m0V3aRmm010641;
	Thu, 31 Jan 2008 04:36:27 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0V3aOK4010638;
	Thu, 31 Jan 2008 04:36:24 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <7vabmmg0cb.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72097>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:
>> ...
>>> Opening the extra file has same problem as the description file. And, as
>>> gitweb allow us to create  "description" and "cloneurl" file there is no 
>>> problem having another file to open instead finding out who is the owner of
>>> the directory asking to the filesystem.
>>
>> We heard the same argument when cloneurl was added, and a
>> newcomer who does not know that may rightly use the same
>> argument.  But I think we should work towards _reducing_ the
>> number of such ad-hoc one-line-per-information files, not using
>> existing ones as an excuse to add _more_ of them.
> 
> Rephrasing to be constructive (but remember, this is all post
> 1.5.4).
> 
>  * we would need for historical reasons to keep supporting
>    description and cloneurl for some time.  There may be some
>    others, but the goal should be to deprecate and remove these
>    ad-hoc one-file-per-piece-of-information files.
> 
>  * we also need for historical reasons to keep supporting some
>    other stuff found in $git_dir/config of the project.
> 
> If the config reading interface in gitweb is reasonably fast and
> cheap, we can move the existing description/cloneurl to gitweb
> config when deprecating them.  New ones such as "owner" would
> naturally fit there.

Currently gitweb parses repo config file _once_, using one call to
git-config -z -l.

We could simply add description to the projects_list file, but it will
be a bit backwards incompatibile change.

We have to call at least one git-for-each-ref per repo to get last
update date, by the way.

> If the config reading interface is too slow (somebody has to
> bench it on a large set of repositories), maybe we would need to
> optimize _THAT_.  If it turns out to be unreasonable (e.g. we
> may really want to keep the implementation that spawns "git
> config" to do the work, rather than writing and having to
> maintain a pure Perl version of config parser inside gitweb,
> which is a reasonable position to take in the longer run, but
> spawning a process per repository may be too expensive).

While IIRC cvsimport or cvsserver has its own config parser in Perl,
but which accepts only limited sensible subset of configuration syntax
(and IIRC uses separate config file).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
