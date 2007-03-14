From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Make gc a builtin.
Date: Wed, 14 Mar 2007 08:55:05 +0100
Message-ID: <8aa486160703140055s2b03c2aeu1c85dedac59b664b@mail.gmail.com>
References: <11738375021267-git-send-email-jbowes@dangerouslyinc.com>
	 <20070314060727.GC20978@spearce.org>
	 <7vodmwfg2c.fsf@assigned-by-dhcp.cox.net>
	 <20070314074440.GC12710@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"James Bowes" <jbowes@dangerouslyinc.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 14 08:55:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HROKZ-0007vO-Hm
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 08:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933880AbXCNHzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 03:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933873AbXCNHzJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 03:55:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:24821 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933880AbXCNHzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 03:55:07 -0400
Received: by nf-out-0910.google.com with SMTP id o25so111629nfa
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 00:55:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lX/bMsxvFczsCfDbe/kRXSCDPeA6GqL5uDOCrrqUJxAbBlgRRPCoGxzheAcw0cpRaIQJEUHHiiLz+KlPWK1+mgcnvy8NLHEefQlyd6oIordjDydlH87FcoIMe0vQaIDWSwNDQUYAca0k+ZnGTF23awVWiyBqpxz9VybAyprj3YE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l9VaWALLrNasBtUT6jibSp7i+QzjOv68OPdYbVknD5PLAkio+2pQ2IcUTY/bvrQEIoGParwPxVotqQIvza/Irc7DG6AVbijE5ULhuVcXAJngv7HA+5ary0zDjQZS2RegviNCA7IR0iyQm2CyoQWo3cg/ufRKofzE6eyZba7ya+Q=
Received: by 10.78.201.15 with SMTP id y15mr970055huf.1173858905689;
        Wed, 14 Mar 2007 00:55:05 -0700 (PDT)
Received: by 10.78.69.4 with HTTP; Wed, 14 Mar 2007 00:55:05 -0700 (PDT)
In-Reply-To: <20070314074440.GC12710@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42182>

On 3/14/07, Theodore Tso <tytso@mit.edu> wrote:
> On Wed, Mar 14, 2007 at 12:19:07AM -0700, Junio C Hamano wrote:
> > >> -test "true" != "$pack_refs" ||
> > >> -git-pack-refs --prune &&
> > >> -git-reflog expire --all &&
> > >> -git-repack -a -d -l &&
> > >> ...
> >
> > I do not necessarily think so.  This is not even a performance
> > critical part of the system, so if there _were_ no other
> > constraints, I would rather keep scripts like this as scripts.
>
> I agree with Junio; I think the scripts are much more readable and
> easier to understand; In fact, it would be nice if the script were
> preserved somewhere, perhaps as comments in the .c file.
>

Or move them to contrib/examples, as was done with git-resolve.sh.

Santi
