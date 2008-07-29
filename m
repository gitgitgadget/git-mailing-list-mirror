From: "Lee Marlow" <lee.marlow@gmail.com>
Subject: Re: Showing changes about to be commited via git svn dcommit
Date: Mon, 28 Jul 2008 18:32:36 -0600
Message-ID: <7968d7490807281732x27a3987cka664ae64351f6751@mail.gmail.com>
References: <7968d7490807281554u3954cf51qe2cd87b94284c77f@mail.gmail.com>
	 <20080728235326.GQ32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 02:33:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNd9m-0001NC-Gb
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 02:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbYG2Ach (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 20:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323AbYG2Ach
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 20:32:37 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:8534 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbYG2Acg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 20:32:36 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4752003rvb.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 17:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ho75ztkC9lrNTYgd0/0Rfld9r8G0KqZbmilNSjC7ZiY=;
        b=qVygZK4aGY7VZ7lzNqrDkL1kqDSOOuESvw+YLO4jMH8CCU16/ApnIQi9DaWuPa1gb7
         MN4Ok0VRQgM2Gy/Wr9yxsrsshf6g3nXgYkENwRQizwCf9KB7SFK7ed/6NdK6nSLR+X27
         qvXvYIJS6qY8zAFxfOJOwOHKYggY7sRi+vxxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Tw3cRoOLblj3NdRIAgPhVzs4jTQIpYEQHEOLDR1sA5bsb7Kl4MJiQh8JeRIXi6IXY4
         LnlvhbA1A+ZT/q4+T3MKv2xHRbvolMw56cIroD+iJxrRukISnf9YDfNiDu5MN1rxeq7j
         GrONfFI7ws3RXubAm3WggtIXGX9vV3q19BZik=
Received: by 10.140.201.21 with SMTP id y21mr2652582rvf.259.1217291556066;
        Mon, 28 Jul 2008 17:32:36 -0700 (PDT)
Received: by 10.141.69.4 with HTTP; Mon, 28 Jul 2008 17:32:36 -0700 (PDT)
In-Reply-To: <20080728235326.GQ32057@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90536>

Works perfectly and makes sense to boot!  Thanks, Miklos

-Lee

On Mon, Jul 28, 2008 at 5:53 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Mon, Jul 28, 2008 at 04:54:19PM -0600, Lee Marlow <lee.marlow@gmail.com> wrote:
>> $> git svn dcommit --dry-run | grep -E '^diff-tree ' | cut -b 11- |
>> git diff-tree --stdin -p -v
>>
>> Is this the real way to do it?  Do others do something similar?
>
> Depends on how did you created your git-svn repo. If you have only one
> branch with no prefix, then I would try:
>
>        git log git-svn..master
>
