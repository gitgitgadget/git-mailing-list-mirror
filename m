From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (resend)] gitweb: Support comparing blobs (files) with different names
Date: Sat, 31 Mar 2007 01:41:35 +0200
Message-ID: <200703310141.36552.jnareb@gmail.com>
References: <200703302341.27225.jnareb@gmail.com> <7virciz6gm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 01:38:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXQfx-0007cQ-5M
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 01:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933020AbXC3Xia (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 19:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933133AbXC3Xia
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 19:38:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:24124 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933020AbXC3Xi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 19:38:29 -0400
Received: by ug-out-1314.google.com with SMTP id 44so967724uga
        for <git@vger.kernel.org>; Fri, 30 Mar 2007 16:38:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rOWXW2PLr42gDlYEfGCcn+N9XxQsOGU7AkjWniP6zzZdupFjuruDENu69oG8BH/kz/u/vNaVQYavLGtDzKQZ9SB1mzUgewLSer5yi8RbU76LYceyoVnWx1D0ZDJ557e1Oni+FdQRkcqGXR4ymC09cYwTYAUrybJkD+Pt5AZIiSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=H376bMRNqkzQYkGoWb+6Gk58URbhzhzwAf/ry8pWdmHgXnowUNF0iVjp325R3IorUGzbNA/RorA5UaFXXwi/nfkdbEAY/dUXoO/TeLNYq9mlGo0a7A787SE29/yQHEIwPHI20c56dnKXj/ZGgzSvjajVrwzWNWRsbVkndRH8WEU=
Received: by 10.82.113.6 with SMTP id l6mr5020990buc.1175297907343;
        Fri, 30 Mar 2007 16:38:27 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id w5sm9952480mue.2007.03.30.16.38.22;
        Fri, 30 Mar 2007 16:38:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7virciz6gm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43509>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Fix the bug that caused "blobdiff" view called with new style URI
>> for a rename with change diff to be show as new (added) file diff.
[...]
>> ---
>> Junio, could you apply this? It looks like it was lost in the noise.
> 
> I was waiting for dust to settle.  Ack's from people involved in
> the discussion would be nice.

I can understand that.

This patch is _a_ solution: it fixes "blobdiff" view for all blobdiff 
URIs gitweb generates now. But it is not _the_ solution, as it doesn't 
work with Martin work on adding "(base | diff)" links to allow to view 
diff between arbitrary commits, trees or blobs; which includes 
"blobdiff" view of arbitrary blobs.

So if/when Martin finishes his series of patches, this part would be 
rewritten. But it is some time in the future...
-- 
Jakub Narebski
Poland
