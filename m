From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: copy selected history between repostories
Date: Fri, 18 Jul 2008 13:12:30 -0400
Message-ID: <32541b130807181012o3b56c413g31667baca1732b01@mail.gmail.com>
References: <18533605.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: luisgutz <luis@xmos.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 19:13:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJtWO-0003Ra-Gg
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 19:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757326AbYGRRMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 13:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757431AbYGRRMc
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 13:12:32 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:22590 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757034AbYGRRMb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 13:12:31 -0400
Received: by qw-out-2122.google.com with SMTP id 3so178139qwe.37
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 10:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jB4DGpDLHWLofmWfoEriN8wp66B36buXVL5Wog5D8Hs=;
        b=qSe/kVCzXNCE8POliHAQCr5f70rVtobLvkEDc0VNkQxfgpPvf200mjhFKT+qIy9ywt
         YSk5Ow4z8Z79TI+dxfP99Mew18QeAQbGg6bmmoeAi5aUbdcWGaXbtvXkLEHCYr2RIpVB
         TX2ssTc3FIWZsMQjRpFF2VRIgge69Br2fF1m8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FoQBQPzauA3b2KLRFphIlvJBIlVshkf5WX+3dmiKo+i4E4LzMqWMldZjUyI359DNGZ
         cIMIGNG8OJvKf1wSt/sqDrEhUlS85oYewrNftossdVVbMzRvNli7FWJJ0ezGHigbvNQb
         KFvyOF8Iy0VW+623trD4GZ5o2GpKeVyx3aiVU=
Received: by 10.151.14.5 with SMTP id r5mr412942ybi.230.1216401150851;
        Fri, 18 Jul 2008 10:12:30 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Fri, 18 Jul 2008 10:12:30 -0700 (PDT)
In-Reply-To: <18533605.post@talk.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89059>

On 7/18/08, luisgutz <luis@xmos.com> wrote:
>  Is there any way to import that directory into repoA with all it's history,
>  but NOT the history from the other commits?
>  Another way of putting is this: can I make git forget the history of all
>  other commits but those from this directory?

Try cloning the repository, then running git-filter-branch with the
--subdirectory-filter option.  It works quite nicely.

Have fun,

Avery
