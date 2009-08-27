From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v5 6/6] fast-import: test the new option command
Date: Thu, 27 Aug 2009 12:44:54 -0700
Message-ID: <fabb9a1e0908271244w3b775ca8qecd8a7e285ecb78e@mail.gmail.com>
References: <1251396736-928-1-git-send-email-srabbelier@gmail.com> 
	<1251396736-928-2-git-send-email-srabbelier@gmail.com> <1251396736-928-3-git-send-email-srabbelier@gmail.com> 
	<1251396736-928-4-git-send-email-srabbelier@gmail.com> <1251396736-928-5-git-send-email-srabbelier@gmail.com> 
	<1251396736-928-6-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0908271944540.6501@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.clatworthy@canonical.com>,
	Matt McClure <mlm@aya.yale.edu>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Aug 27 21:45:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgkuV-0003mz-HC
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 21:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbZH0TpS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 15:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbZH0TpR
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 15:45:17 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:36675 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbZH0TpQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 15:45:16 -0400
Received: by ewy2 with SMTP id 2so1541084ewy.17
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LzQftQCJz7wu8MDZDZxbSeSMq9rxKbvzyo/SSCUE9X4=;
        b=MX8FukfJs36WRQ8westRS9vY4efofsWsz2XqyO8LFCmNzEzvuI+w+rA54wyuWz6456
         TnI+9S+vHNePlUUrx7pTswG+e09UMen+m9jN93sMkHqoame+vqm0iYnvADNkiy2pyT+Z
         owmNegh2eoxvWDlbexhS9D9fZXqW+oMF8o6kU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VghVov0GQjEQcQ7DmrWzuP4d8wkXbekCo1UcbNL3anYMMZOw6SdzDKWQUTUat4ICbq
         urI/o4rvfZeEMPSZqUjLnN9tA2GLnOQwpyRYrEUk6TEXjXfg8jv8tedFCQGg/C3wy6Fg
         maSHnYU4/gg7bJrFsEV58iWYR0V8fTJXLq4DU=
Received: by 10.216.2.201 with SMTP id 51mr41320wef.17.1251402314924; Thu, 27 
	Aug 2009 12:45:14 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0908271944540.6501@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127202>

Heya,

On Thu, Aug 27, 2009 at 11:46, Julian Phillips<julian@quantumfyre.co.uk=
> wrote:
> Don't you now need all tests of the option command to start with a "f=
eature
> git-options" command?

Yes, that was the second reason for v5a, fixed there.

>=A0(and perhaps have a test that the feature command is required too?)

Done.

--=20
Cheers,

Sverre Rabbelier
