From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 10:03:43 +0100
Message-ID: <fabb9a1e1002120103j3f37d417ka5b7b7ca3ae8edd@mail.gmail.com>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com> 
	<20100212080620.GA31719@dcvr.yhbt.net> <alpine.DEB.1.00.1002121000290.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Wong <normalperson@yhbt.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 12 10:09:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfrWy-0005bG-8d
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 10:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883Ab0BLJJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 04:09:38 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:47307 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab0BLJJg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 04:09:36 -0500
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Feb 2010 04:09:36 EST
Received: by qyk9 with SMTP id 9so593322qyk.22
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 01:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=/q24h7du6dBBzxXExOMYZ5ll6XabBLSmfivNUoJH2JA=;
        b=SijlwtI5bOpvyosWLaTmESbGwcpNU0skciDR9BvbjlEBVRM4iVSr9k7ug45WD+Wd0o
         rHY1Gof0NF+CAlupUG9c6bHLEQ9QA4RHNeuil9hpHVj71l6VaDBXOTaZYtee6ZWYiM0d
         8yTtLfVDqGDhtrkuaZbD3UZHhW+yKm4lWYj94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fxQn+zFU49vGu+OuLeIqGKrN6/3GeTSaVwqaWteCpGZT7xbyTkRmrAGsTBlGQBcT4A
         sBB+KjBWvg9Fiu3VaQA/Y66bZCZs0yxCZ6CIpnNXJrxI9Nw/wcOkHXwUyejbUAmgnJqx
         jlDUjcV6ICHnOAXw1oNusDy7TSRxzj+38sFm0=
Received: by 10.224.59.70 with SMTP id k6mr537801qah.243.1265965443139; Fri, 
	12 Feb 2010 01:04:03 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002121000290.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139665>

Heya,

On Fri, Feb 12, 2010 at 10:02, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Would it not make sense to implement git-remote-svn as a C program? That
> should help matters especially on Windows, where git-svn is very slow due
> to its using MSys (which is a stripped-down Cygwin, as you know, jumping
> through hoops to bring some POSIX-iness to Windows).

It would very much be sense to do so, perhaps we should update the
wiki to say that implementing it in C is strongly preferred?

-- 
Cheers,

Sverre Rabbelier
