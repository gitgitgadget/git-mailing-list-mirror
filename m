From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Trivial fix: Make all the builtin usage strings to use 
	the same pattern.
Date: Mon, 21 Sep 2009 18:39:45 -0300
Message-ID: <a4c8a6d00909211439j3638d924xedccd4c2f8702261@mail.gmail.com>
References: <1253452645-3220-1-git-send-email-tfransosi@gmail.com>
	 <4AB7A534.2070406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 23:40:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpqcT-00077H-KS
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 23:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbZIUVjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2009 17:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbZIUVjo
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 17:39:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:6403 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbZIUVjm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2009 17:39:42 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1016402fge.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2009 14:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sM08FBLB2JVvi/1WNA7XqNS0EeVuM3mNBC1iTIj7NrY=;
        b=K5asRELuEJYB06BBvDjigjeyt4XyAwUlI0slK9c7ugdGSrfT7eUbP3nAqJkh1069yF
         YbjUr+nZEeqWae7ReVTrJ+h6krSt+y3ww65j9wz9/T6R/fEJRS4owchlsme4p64m3AX9
         TCU44dPXIBCJcRWPdfIAkrmmKnzPj16R2k8dk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KSdsODWpITpNf8ozlY7aKDiLaXGQ4vYeYGxM9qzTdse9A4kZBPgmISoakxV0T+6jkV
         BR+qnloIYS0AbNyA0vU5UefV9RLo+ewtKhoTdZrmyhl3DC8J4pacnCZe5aVwypeaMYqZ
         HkgbKvsbIkayphZG3udlk9G3LfZvNBATaDVmQ=
Received: by 10.86.232.5 with SMTP id e5mr173355fgh.27.1253569185626; Mon, 21 
	Sep 2009 14:39:45 -0700 (PDT)
In-Reply-To: <4AB7A534.2070406@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128913>

On Mon, Sep 21, 2009 at 1:09 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Thiago Farina schrieb:
>> They follow the pattern of file name:
>> File name pattern: builtin-command-name.c
>> Usage string pattern: builtin_command_name_usage
>
> Well, file names are not so constant: every now and then an external
> command is turned into a builtin (and the filename is changed), and w=
e
> have even seen that a builtin was turned into an external command.
> Moreover, some commands are implemented in the same file, for example=
 'git
> log' and 'git show'. How about naming the variable after the command =
name?
> E.g.:
>
> command: =A0git cat-file
> variable: git_cat_file_usage
That sounds good, I will follow this pattern in the next patch. So all
existing builtin_command_name_usage will be changed to
git_command_name_usage, command_name_usage to git_command_name_usage,
etc.
