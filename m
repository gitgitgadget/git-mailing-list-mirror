From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 18:36:40 -0400
Message-ID: <46a038f91003181536ib3b74f8o40603a4cee13d62b@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 23:37:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsOL7-00015l-9N
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 23:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538Ab0CRWhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 18:37:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38236 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab0CRWhC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 18:37:02 -0400
Received: by gwaa12 with SMTP id a12so1098795gwa.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 15:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=eq8BKrpgs+g+pkVq42GImyRUFJLFe+GnC7R+OJx8YFg=;
        b=tj84BWQcaF8PLuWBmHbAW3rWIWrqCAXYbgLVEg06So6weAfsVYfJyco1Ul+gyrNulM
         I3GqLXOM/+vz1oesOHYV/oFp6jlkum/GzKLklYcpEYJyeQpZVwHqIeNQ5LB86xqekO+x
         8Q/UOig5kMfiJFSPmXAeMFfsiSKkrZEWXOG7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YwLb0WnCmRUzin5ChzkYcYGJqyEQdApuXPEIbZ8YrUXiwGXtqoeLzByERnh4lfVNuq
         q5nxsfsik6l6zT2/CbJqdQjeLa3k1XLkvaJ3HxJB+kHuics1qvax3aggrBXfpn3wZPj8
         6n951Q3OqaNQJSbcnEs1vKzUGuZr9TvOfSQ/g=
Received: by 10.101.108.6 with SMTP id k6mr5278957anm.162.1268951820282; Thu, 
	18 Mar 2010 15:37:00 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142532>

On Thu, Mar 18, 2010 at 1:27 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Even shorter version: NO.

One thing we all forgot to mention here is that even if it was a good
idea (which it is not), implementing it means a flag day: changing in
the pack format, wire protocol and APIs, messing up with compatibility
with users of pre-flag-day git, and rippling out to all the GUIs,
frontends and integration scripts out there.

A veritable mess that would reberberate for years.

Any proposal that touches the core git datamodel... better implement
something that is outrageously wondrously good and impossible to do
any other way.

My guess is that people that parachute into this list and propose
datamodel changes haven't thought this aspect through.

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
