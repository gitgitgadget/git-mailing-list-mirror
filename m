From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: FEATURE REQUEST: git tag -- add option to display SHA1 values
Date: Thu, 4 Mar 2010 13:01:04 -0500
Message-ID: <32541b131003041001m5db1b84dr9cc38c6a87fe1ad5@mail.gmail.com>
References: <878wa8atdr.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Mar 04 19:09:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnFUD-0003Wt-Sr
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 19:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab0CDSJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Mar 2010 13:09:21 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:58523 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab0CDSJT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 13:09:19 -0500
Received: by ywh35 with SMTP id 35so1058801ywh.4
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 10:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=u27IxfqsnZmPz1yga/whjG1b5B83pv1gkdd3VTro67o=;
        b=bELzaxkHol9wY7Oj09SttPqvJaPPoSSXQSZRkZ6H3A5AKYxqckq93McAULO8SR2tk0
         2Pd4yihhfYI/E6lBT7vzzo590K5rRrtvDWqqK6/WwVNXbHs8Up4dnjhpwWjNyvc1ondD
         2QUkF1HS3uqLNQ94Gzg8fgc+aduggTEWRZWG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=krwHhEafHIWSB0MjymsbeaACGjad2mmZwiVlMh2pIIc7RjxyYEDBKRysLgcm3ioTC+
         FjOBrmr2hw6hBrXTGHMWICnSvN4ZAAlvbw0ojVd6oFqiEfLERy7gwy+fZMgEUmAyi6Ag
         CAeKvHeTyLuFXzss6GLHHJ7x13of5KyYPiMRs=
Received: by 10.151.118.2 with SMTP id v2mr44681ybm.47.1267725684427; Thu, 04 
	Mar 2010 10:01:24 -0800 (PST)
In-Reply-To: <878wa8atdr.fsf@jondo.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141536>

On Thu, Mar 4, 2010 at 12:28 PM, Jari Aalto <jari.aalto@cante.net> wrot=
e:
> It would be nice if there were option to list the SHA1 values easily =
for
> every tag:
>
> =A0 =A0$ git tag --sha =A0 =A0 =A0 =A0 # or -s short option
>
> =A0 =A0release/1.0 =A0 =A0 =A0 =A0 3a162d7086a7da0f9621530cca5996668d=
1442e3
> =A0 =A0snapshot/20100125 =A0 e7b2b55a1bc2e59b5bf4fc92bc5eaf8ec25031a3
> =A0 =A0...

Try this:

      git show-ref --tags

Have fun,

Avery
