From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Fri, 9 Oct 2009 10:09:22 +0200
Message-ID: <fabb9a1e0910090109o3ea0c08eo7991fbab34311381@mail.gmail.com>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org> 
	<1255065768-10428-2-git-send-email-spearce@spearce.org> <fabb9a1e0910090101g2de58824p6cfdea86c98e0191@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 09 10:15:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwAaW-0001XR-6R
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 10:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582AbZJIIKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 04:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754822AbZJIIKV
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 04:10:21 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:54018 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbZJIIKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 04:10:19 -0400
Received: by ewy4 with SMTP id 4so391397ewy.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 01:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=DSptchd7Oz9+smnWprhg3GNZfOh/JJqQUJ5rvkO7cCY=;
        b=RYTfqEDlBWvpjA6WOanlZ8gPhEaIEbMM9eRJKDYfpoFKaccac2Dej7dD8lh5Z6+XR1
         Cbbc0ukcbJ6VCQnvamglYO+yRUGMw2jQ0BxnyVlT1iq3QlvW7TuN0beAAuRRFDYB6ZNG
         3X7OXLe59DCcSnHIsv0zk6oNMHSnQpA+UcWrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tuI6ZgYpmd/ippenVjOHXjt98w0G4yeZx+H6CnoohgcU/XjUiashoXYFxjTozTB4fs
         ZVjXQ+rwz+iooCvs8G9dCONLXOpIv4BNT/UhD3S3QX2J/UorUFBw1MjSz5qpJdg9Ucol
         ccm4UUd7AZEDw0X+/Lr46k6m+DmPdGZR8dIr4=
Received: by 10.216.89.139 with SMTP id c11mr820035wef.198.1255075782126; Fri, 
	09 Oct 2009 01:09:42 -0700 (PDT)
In-Reply-To: <fabb9a1e0910090101g2de58824p6cfdea86c98e0191@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129752>

Heya,

On Fri, Oct 9, 2009 at 10:01, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> + (c) Send one $GIT_URL/git-upload-pack request:
>
> I don't think you documented what $GIT_URL/git-upload-pack means.

Ah, I didn't realize until I read 4/4 that this is just a regular
request to the 'http://<host>:<port>/git-upload-pack' url, I was
confused by the need to query
"http://<host>:<port>/info/refs?service=git-upload-pack".

-- 
Cheers,

Sverre Rabbelier
