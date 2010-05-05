From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: how to squash a few commits in the past
Date: Wed, 5 May 2010 15:19:10 +0200
Message-ID: <w2zf3271551005050619td67d697y97d7e9181c4496fc@mail.gmail.com>
References: <loom.20100503T112508-677@post.gmane.org> <4BDEA0D7.9090201@drmicha.warpmail.net> 
	<hrncm3$pg8$1@dough.gmane.org> <hrnem4$1m0$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Gelonida <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 15:19:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9eVo-0000Mc-EM
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 15:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934759Ab0EENTc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 May 2010 09:19:32 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:38526 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932275Ab0EENTa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 May 2010 09:19:30 -0400
Received: by pxi5 with SMTP id 5so1467729pxi.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 06:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4mp+x1+Wj3CfsKSAA5sG39YhEy3Zac6X2MCynEcLxnI=;
        b=lfSyMEipEdRj4qNzIX37bt673OL+DWkpUxtAJGrsRveBAP2yGyoWB6EpJXDrmw06I5
         zj5EVMipCIjszPz0/IRmR/R8ndk/JuH13+Q8heU/VK267Os/9NG6e2yqUzx0LnZzHbtr
         dhmsdSyy9xV+pGHG3SR0eKwD6xQYFjls+2QTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RqxpcfKdcSAqL2K90kDr5xZKvgKilPGNmkr8OCQ2ft4ggwJhggYY3GeUG1XX/wQPhd
         +zafBrxpqyQnrPSOBl/wOoKrgTjje1dj6NehMna02/PcrRCexMyQ5zd93J2CSfmLJ2Fg
         NdrZeLvITuJTTo+WD31XlXpP8pnMZswskZAnw=
Received: by 10.143.153.24 with SMTP id f24mr4058697wfo.292.1273065570155; 
	Wed, 05 May 2010 06:19:30 -0700 (PDT)
Received: by 10.142.254.21 with HTTP; Wed, 5 May 2010 06:19:10 -0700 (PDT)
In-Reply-To: <hrnem4$1m0$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146391>

Hi,

On Mon, May 3, 2010 at 11:20 PM, Gelonida <gelonida@gmail.com> wrote:
> Is it normal, that git gets lost wehn rebasing such a structure.

While performing an interactive rebase, conflicts can often occur and
this is quite normal.

>> Automatic cherry-pick failed. =C2=A0After resolving the conflicts,
>> mark the corrected paths with 'git add <paths>', and
>> run 'git rebase --continue'
>> Could not apply 67f3f6d... preparation for #241

The problem and solution is described in that message. Open the file,
resolve the conflict and continue the rebase operation.

-- Ram
