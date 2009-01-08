From: jidanni@jidanni.org
Subject: Re: X-Debbugs-Cc didn't make it to git@vger.kernel.org
Date: Fri, 09 Jan 2009 03:36:58 +0800
Message-ID: <87ljtlk2sl.fsf@jidanni.org>
References: <87ej0qf3gx.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 507475@bugs.debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 20:54:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL0i6-0004ZV-9G
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 20:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbZAHThF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 14:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753908AbZAHThE
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 14:37:04 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:33371 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752807AbZAHThD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2009 14:37:03 -0500
Received: from jidanni.org (122-127-32-114.dynamic.hinet.net [122.127.32.114])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id D76FC119E30;
	Thu,  8 Jan 2009 11:37:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104955>

>>>>> "j" == jidanni  <jidanni@jidanni.org> writes:

j> Bummer, on
j> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=507475
j> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=507476
j> I used X-Debbugs-Cc, and it says Report forwarded to git@vger.kernel.org
j> but I don't see them here on nntp:gmane.comp.version-control.git .
j> Perhaps they got filtered out?

Why of course,
$ git checkout origin/todo
$ GET 'http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=2;mbox=yes;bug=507475'|./taboo.perl
43 Delivered-To: submit@bugs.debian.org
matches /^[-\w_]*:/ && m!Delivered-To:!

# These are Majordomo's  global  majordomo.cf  as used at
# vger.kernel.org.

So forget about any X-Debbugs-Cc reaching any kernel.org list.
