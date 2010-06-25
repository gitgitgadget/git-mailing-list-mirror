From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: FR: Clone just the desired subdirectory
Date: Fri, 25 Jun 2010 16:30:18 +0200
Message-ID: <AANLkTiks9r5IpwPyCHxGEDqkiBB3rLiWK8zwLcxSB-9P@mail.gmail.com>
References: <AANLkTilyvCWyWzqPGxtg9tkRM5SjXxbt50P5zImlxCHD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Laszlo Papp <djszapi@archlinux.us>
X-From: git-owner@vger.kernel.org Fri Jun 25 16:30:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS9va-0007Lb-1h
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 16:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756409Ab0FYOal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 10:30:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34869 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab0FYOaj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 10:30:39 -0400
Received: by iwn41 with SMTP id 41so2052430iwn.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 07:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=mFDGC2WDlI8msBHW7drEdDor2lyD1gVKzKxOlKEdrEk=;
        b=E6TByj5B5CD7btB+iEectz3QCXn0bB20mMtClMbm505WAE++Td1nSYjVTdo4/mzvOi
         JQ7YnzRm0eiqkqswjH5mOjembQlvsMYolPDEbgKT/a5+8gV51tK/AMP227dNnfNxxmnw
         VA5Ih2wmyazzUJi8nBe4rJ2XxUbaSBN7ZVblg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=uIgjslz19TE1IKR6MyShYv7M7BkiPEfgON8qvppgv+gB/MzmEKCN34eZTfCp8tsvxc
         Rf137LaJG327PV7qa2So6iuT/f/06IFwD+tHFiyTtdV+wKldcHPpnNk3bapIMFfya/A4
         kA/EdOhmRStIJPMB4o4TnnVZ7+heDLVfraaIs=
Received: by 10.231.123.215 with SMTP id q23mr776514ibr.190.1277476238949; 
	Fri, 25 Jun 2010 07:30:38 -0700 (PDT)
Received: by 10.231.50.129 with HTTP; Fri, 25 Jun 2010 07:30:18 -0700 (PDT)
In-Reply-To: <AANLkTilyvCWyWzqPGxtg9tkRM5SjXxbt50P5zImlxCHD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149686>

Heya,

On Fri, Jun 25, 2010 at 16:24, Laszlo Papp <djszapi@archlinux.us> wrote:
> My friend asked it from me, but I couldn't advise anything to him, but
> this request does make sense by me. So he would like to download a
> part of a git repository and he is not interested in the index and the
> history, so it would be nice to have something like git archive
> --remote or similar command which can do this operation.

Basically what you want is the ability to say "give me the tree and
corresponding blobs for directory foo in revision bar" (where bar is
usually HEAD). This ties in with the work on spare/narrow
checkouts/clones, which seems to have stagnated.

-- 
Cheers,

Sverre Rabbelier
