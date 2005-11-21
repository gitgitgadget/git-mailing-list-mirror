From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [RFC] git-format-patch options
Date: Mon, 21 Nov 2005 09:36:03 -0800 (PST)
Message-ID: <20051121173603.73700.qmail@web31806.mail.mud.yahoo.com>
References: <4381F97A.9010105@op5.se>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Nov 21 18:39:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeFaL-0000q7-Az
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 18:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVKURgF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 12:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVKURgF
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 12:36:05 -0500
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:40051 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932371AbVKURgE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 12:36:04 -0500
Received: (qmail 73702 invoked by uid 60001); 21 Nov 2005 17:36:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=cELP4ZacteCFjLSWu13r9sB2SJM0eXZm6J/VkAbS7ZZaGJfxJAfgGVYftySGjFVu+5fpn3Xk4TPB2+CD8Hnolebt78DaHkwHWGMD9SYLd7qghdTVXZKEebNt0yjQsDs1N9ywfUk9VpgqRDZ2C460dDg/Tz+mD4zUcvnfnIJGm5g=  ;
Received: from [68.221.112.229] by web31806.mail.mud.yahoo.com via HTTP; Mon, 21 Nov 2005 09:36:03 PST
To: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
In-Reply-To: <4381F97A.9010105@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12460>

--- Andreas Ericsson <ae@op5.se> wrote:

> 
> Please don't. git-format-patch is generally used to send 

Ok, so then when I want to extract a single commit into a patch in a patch format, I loosely do
(scripted):

  git-rev-list --pretty=raw --max-count=1 <commit-ish>

Then I record the parent <parent> of the commit-ish and do:

  git-format-patch [output options] <parent>..<commit-ish>

Which gives me the commit with id <commit-ish> as a
formatted patch.

Is there an alernative to this, as opposed to the two
step procedure above?

   Luben
