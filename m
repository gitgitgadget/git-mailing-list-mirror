From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Trivial fix: Make all the builtin usage strings to use 
	the same pattern.
Date: Sun, 20 Sep 2009 11:51:02 -0300
Message-ID: <a4c8a6d00909200751r87fdf83oe92e5a2076b1b527@mail.gmail.com>
References: <1253452645-3220-1-git-send-email-tfransosi@gmail.com>
	 <20090920143526.GA22295@dualtron.vpn.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Sun Sep 20 16:54:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpNnk-0008Pl-Kp
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 16:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbZITOvB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Sep 2009 10:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbZITOvB
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 10:51:01 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:58793 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbZITOvA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Sep 2009 10:51:00 -0400
Received: by fxm12 with SMTP id 12so1683067fxm.18
        for <git@vger.kernel.org>; Sun, 20 Sep 2009 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hxXYv8BYDq0HN3TdPQU7OoWIoQJTMaLCnax8fn2xqoY=;
        b=LDsP3ATAghBW+RTjDIJbQEIZhe63jGk2Og7jYdghDbiOfWsx9rRNxOT0odVqn796sp
         Dz+nZt4EVPWxWX5EvNU6yw9urGKe698R5HSVQEx6pM/rXzTWk5RX3lxN7fXiI5Evz/3e
         u8wRwE44wArSIl8Zi0ZhlpauiTztdkxmncbKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OCb7ZOBvTT2I+gSiZ1mxE6Hst7EkUTxY2sIzNwfXaesijjf9EL9hL7HeVXvzCWFIB3
         cqeVvrb1gSANvNgr8PC11sS/Bq+wOYtBAXsMCSuUUb44Lup3CHntIUPzvFO24eZg5OnX
         UUPDlS7m20b3B+1El7NgWNXc7/r1pzNI4SEmw=
Received: by 10.86.240.9 with SMTP id n9mr3592769fgh.70.1253458262949; Sun, 20 
	Sep 2009 07:51:02 -0700 (PDT)
In-Reply-To: <20090920143526.GA22295@dualtron.vpn.rwth-aachen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128848>

On Sun, Sep 20, 2009 at 11:35 AM, Johannes Gilger <heipei@hackvalue.de>=
 wrote:
> On 20/09/09 09:17, Thiago Farina wrote:
>> They follow the pattern of file name:
>> File name pattern: builtin-command-name.c
>> Usage string pattern: builtin_command_name_usage
>> [...]
>> -static char const * const archive_usage[] =3D {
>> +static const char * const archive_usage[] =3D {
>> =A0 =A0 =A0 "git archive [options] <tree-ish> [path...]",
>> =A0 =A0 =A0 "git archive --list",
>> =A0 =A0 =A0 "git archive --remote <repo> [--exec <cmd>] [options] <t=
ree-ish> [path...]",
> Looks like you missed a spot ;)
The change here is about 'char const *' to 'const char *', to match
with the definition in api-parse-options.txt. :)
Is there a reason for archive do not has a builtin- in it file name?
