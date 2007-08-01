From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Wed, 1 Aug 2007 15:20:56 +0200
Message-ID: <81b0412b0708010620g776fb89ei574ece00ac45bf30@mail.gmail.com>
References: <200708010216.59750.jnareb@gmail.com>
	 <alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
	 <7vodhrby6f.fsf@assigned-by-dhcp.cox.net>
	 <20070801092428.GB28106@thunk.org>
	 <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0708010620h6bf44aarb35da301db967855@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 15:21:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGE8P-0008Ny-3e
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 15:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761758AbXHANU7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 09:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761683AbXHANU7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 09:20:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:57793 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761608AbXHANU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 09:20:58 -0400
Received: by ug-out-1314.google.com with SMTP id j3so204284ugf
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 06:20:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZcisLXCSbwgmNZ+PgE5ETSDM0n9GbdfSGnyD/B7z6ywMLCH8dYUqudDx1rOZ1uk4IrcpxZAc3Y1JxVQBDZjvhg6C1nwrEbIZI+omOdymLfVvqu5/zHCgY8O5dTHRD4b6W+OyPFwPH2vNoWt5hnaIL+iyYk54qrLiBaxwlBanMD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q5mfeNTy4xtiO7AmCj4mHZ7Y6MblAKp1J80BcwKYsWbNe4Guk9cGhZuEFb8ZVr3gFHbEFqjFnTbvSEU1Uj9ndLexODygLex1HFYasbIqOlSYYm6arqi7CKUqgUBm3HBbOGk7zJIAA3vFdk6/tacHbFTXtmkHwAQE611PzmKOnw4=
Received: by 10.78.204.7 with SMTP id b7mr184962hug.1185974457194;
        Wed, 01 Aug 2007 06:20:57 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 1 Aug 2007 06:20:56 -0700 (PDT)
In-Reply-To: <81b0412b0708010620h6bf44aarb35da301db967855@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54434>

On 8/1/07, Alex Riesen <raa.lkml@gmail.com> wrote:
>             if ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
>             then
> +                   echo >&2 "Hardlinks not supported. Falling back to copy"
>                     l=l
>             fi &&

Err, the other way around, of course.
