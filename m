From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: 'git config' vs 'git repo-config'
Date: Sun, 4 Feb 2007 11:23:47 +0100
Message-ID: <e5bfff550702040223h56f1524x9e6c460445874063@mail.gmail.com>
References: <e5bfff550702040138r6580c36agf86e8f8191a40021@mail.gmail.com>
	 <7v8xfetft6.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550702040200y4f09070fia3716ca949fddac7@mail.gmail.com>
	 <7v4pq2tet5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 11:23:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDeXG-00030i-SK
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 11:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbXBDKXt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 05:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbXBDKXt
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 05:23:49 -0500
Received: from nz-out-0506.google.com ([64.233.162.236]:8523 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbXBDKXs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 05:23:48 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1333167nze
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 02:23:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o5xgNwmIJagyMHutQJWic0RgTdbk50Q+KP7UPlqrb5JHXmWooptk3os9jcI2NqNLE3fJYIKaykToyyWN+qEgug1S9If+XibKHl/dUn9runP7Pu3tvJ23QZY7XaqdJDei55WIVzUUwPn8CK3Xy1ibjDpoS0oFP9DUQ+p36qhDA5s=
Received: by 10.115.76.1 with SMTP id d1mr508284wal.1170584627707;
        Sun, 04 Feb 2007 02:23:47 -0800 (PST)
Received: by 10.114.61.6 with HTTP; Sun, 4 Feb 2007 02:23:47 -0800 (PST)
In-Reply-To: <7v4pq2tet5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38679>

On 2/4/07, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> >
> > qgit needs to handle the text codec information 'i18n.commitencoding'
>
> I thought you already fixed the header parser.  Is that a news?
>

The parser is fixed from some week already.

Codec info is shown to user when opens settings dialog and could be
manually set by user there. If not present utf8 is assumed.

> I wonder what it has to do with the command deprecation/removal
> schedule...
>

I plan to release a point release after git-1.5 is out, so I'm
wondering if renaming git-repo-config --> git-config also in qgit.

BTW  'git-repo-config' seems to be currently used also by StGit
