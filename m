From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH decompress BUG] Fix decompress_next_from() wrong argument value
Date: Sat, 12 Jan 2008 08:42:14 +0100
Message-ID: <e5bfff550801112342w4faee040nad294f3962160180@mail.gmail.com>
References: <e5bfff550801111247l1ccf171ene5b53b8d6841a864@mail.gmail.com>
	 <7vfxx3290v.fsf@gitster.siamese.dyndns.org>
	 <e5bfff550801112306g6b8127dft80484c9fd8554992@mail.gmail.com>
	 <7vir1zwlcw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 08:42:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDb12-0002Tc-2D
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 08:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536AbYALHmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 02:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758011AbYALHmQ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 02:42:16 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:28946 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbYALHmP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 02:42:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1168576rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 23:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4sqwWlRj/ZlNvdRhEpIyFNOCfF91oCESqWjsITnpalw=;
        b=g663ejRllrDEHWJdoN3ZESRJkO90+Z9ysYF9kG/NYOirPNJ1WXBVK6S8+18pqgsmoOe6mQ8ntOnZ7RRDcIqX7I9Y7PboNv9PZdDd2/P8wx6qGDuMDTR7irLRP3w3Rpu2KYGUWZLZw6VVghKqJGRexSSMJRsqRnn7aMQ39biKW74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xqm90yRZG/I7qsFREOQuaumbB4t1W/wAm15NSMGyHArayVK9t4sgs4Jvzjlb/J+6VEoWs99+tebLFNzXmYh9b6WTd7MgBDVrqNuoAHahafWCBrKAWTfWRcJclPdG+Dbxmd+e4DDpa6bdkicViqFW0AnL/r80IY0nwDhCAg8o0GI=
Received: by 10.141.185.3 with SMTP id m3mr2536894rvp.167.1200123734085;
        Fri, 11 Jan 2008 23:42:14 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 11 Jan 2008 23:42:14 -0800 (PST)
In-Reply-To: <7vir1zwlcw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70285>

On Jan 12, 2008 8:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> By the way, I was looking at the earlier two series from you
> (compress and decompress), and noticed some of them were corrupt
> with linewrap.  As I think they are good clean-up patches, I'd
> like to apply them as one of the first series post 1.5.4.  As
> such, this request is not urgent at all, but please resend with
> a clean-up when 'master'/'next' reopens.
>

Sure.

Do you prefer patches differently organized or I can keep the same
patch contents (of course with squashing the bug fixes in) ?

Marco
