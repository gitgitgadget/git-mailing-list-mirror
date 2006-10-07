From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: using quotemeta
Date: Sat, 7 Oct 2006 11:23:23 +0200
Message-ID: <200610071123.23654.jnareb@gmail.com>
References: <20061002201256.89409.qmail@web31809.mail.mud.yahoo.com> <200610061438.50965.jnareb@gmail.com> <7vr6xkzpak.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 11:55:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW8tI-0006Sv-Oz
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 11:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWJGJyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 05:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWJGJyT
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 05:54:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:25502 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750758AbWJGJyS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 05:54:18 -0400
Received: by ug-out-1314.google.com with SMTP id o38so416261ugd
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 02:54:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VwQZXU/eapD+XLdIYKh887OJVfL2lp3TD8Y5Tx174iVtsdbz5qUE+xcJHFP+Ddfbwr8YZKt2daS4KG9tilqDyiDOo8s81Wp6m9NtUt2GDsRip5RqmS4BoZ2vfn7P6812zwp2nxn7eb1Nyar4sx48FJtpmcB+M/Rxn381q+L6iZI=
Received: by 10.66.220.17 with SMTP id s17mr4363541ugg;
        Sat, 07 Oct 2006 02:54:16 -0700 (PDT)
Received: from host-81-190-22-223.torun.mm.pl ( [81.190.22.223])
        by mx.google.com with ESMTP id 27sm3229702ugp.2006.10.07.02.54.16;
        Sat, 07 Oct 2006 02:54:16 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vr6xkzpak.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28465>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> I'd rather add (and use) separate subroutine for quoting/escaping
>> values in HTTP headers, or to be more exact for the filename part
>> of HTTP header "Content-Disposition:". This way if we decide to
>> not replace all characters outside US-ASCII in suggested filename
>> to save with '?', but only qoublequote '"' and linefeed '\n' characters,
>> or even implement RFC 2047 to do the encoding (of course if browsers
>> can read it), we could do this in one place. 
> 
> Sounds sane.  quote_filename?

Luben Tuikov used  to_qtext  in
  "[PATCH] gitweb: Convert Content-Disposition filenames into qtext"
  Msg-ID: <20061006191801.68649.qmail@web31815.mail.mud.yahoo.com>
  http://permalink.gmane.org/gmane.comp.version-control.git/28437

-- 
Jakub Narebski
Poland
