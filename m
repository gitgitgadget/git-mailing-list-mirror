From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t4015-diff-whitespace broken on cygwin's bash
Date: Fri, 13 Oct 2006 14:56:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610131454490.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0610130212uca8371fg92db5081a8175cb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Oct 13 14:57:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYMal-0002hS-IZ
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 14:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWJMM4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 08:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbWJMM4o
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 08:56:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:37841 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751671AbWJMM4o (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 08:56:44 -0400
Received: (qmail invoked by alias); 13 Oct 2006 12:56:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 13 Oct 2006 14:56:42 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0610130212uca8371fg92db5081a8175cb3@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28839>

Hi,

On Fri, 13 Oct 2006, Alex Riesen wrote:

> It seem to cut off the last CR from text-here. I.e.
> 
>  cat <<EOF >x
>  ...
>  CR at end^M
>  EOF
> 
> becomes just "CR at end" in the output file, that is ^M (aka CR) stripped.

I can confirm this problem. Strange. I always thought that "cat << EOF" 
was meant to copy verbatim. I think it is a bug in cygwin.

The only sensible workaround I can think of is to put the files into a 
directory t4015/ like t4013 does.

Ciao,
Dscho
