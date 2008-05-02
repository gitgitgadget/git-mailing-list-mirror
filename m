From: Pedro Melo <melo@simplicidade.org>
Subject: Re: Parent-less branches
Date: Sat, 3 May 2008 00:04:06 +0100
Message-ID: <A8B95683-9832-4973-B920-8546CC55F162@simplicidade.org>
References: <F26CE1A6-FE85-4AC6-BCE6-B41085A09F0F@simplicidade.org> <7vskx0wf8i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 01:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js4JL-0003nZ-0y
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 01:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936270AbYEBXEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 19:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936040AbYEBXEM
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 19:04:12 -0400
Received: from mail.sl.pt ([212.55.140.13]:45518 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S935825AbYEBXEK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 19:04:10 -0400
Received: (qmail 23257 invoked from network); 2 May 2008 23:04:08 -0000
Received: from unknown (HELO [192.168.1.67]) (melo@[81.193.202.135])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 2 May 2008 23:04:08 -0000
Received-SPF: none (mail-sl: domain of melo@simplicidade.org does not designate permitted sender hosts)
In-Reply-To: <7vskx0wf8i.fsf@gitster.siamese.dyndns.org>
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81045>

Hi,

On May 2, 2008, at 10:47 PM, Junio C Hamano wrote:

> Pedro Melo <melo@simplicidade.org> writes:
>
>> inside an existing repository I want to create a new branch without a
>> parent commit. Is there a set of commands to do this?
>
> Typically these commits come about because you created a completely
> separate history elsewhere in a separate repository and fetched and/or
> pulled from there.
>
> So "a set of commands to do this" would be:
>
> 	go away
> 	git init
>         build history as usual
> 	come back
>         git fetch ..from that other repository..

Yes, that is what I was using until today.

I was asking for a in-repo solution, without the second git init.

The following email by Wincent Colaiuta does exactly what I wanted :).

Thanks!
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
