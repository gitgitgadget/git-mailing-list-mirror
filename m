From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Tue, 12 May 2009 20:40:20 +0200
Message-ID: <46a038f90905121140n61902c61qc3cd41100efee4ae@mail.gmail.com>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
	 <20090512182828.GA26812@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 20:41:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3wty-0008Qd-NU
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 20:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbZELSkV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 14:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbZELSkV
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 14:40:21 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:48140 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbZELSkU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 14:40:20 -0400
Received: by fxm2 with SMTP id 2so157527fxm.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wGchzTGJKSrPrJD97x7ftiY7/s/H3Ba8iG8ciPqmu7k=;
        b=ftnZX1Zp22Ni9nn43h9qG2jTxJFwLBX0OqXZH03hBYBUE5ZyfCxMXZgOMt98Y1mU+f
         nev63tyc44qGoUrazEwgea3rgbjh/2gMcYUBiOXnFLrUl3lDlRwePg3bw0K2UXsVddIl
         qGMHapcTUUZ8sq5o5wNbc0g5omp1688RhsDBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E52pMjjyb3pZfoFn/l8n5TGahssvjQ1ZvQIg3SUhkJGgD33RJWDfrgfVI+x+pATwcv
         h/3okrR1HHyRPuCR8HMPIY8SYnEfZwVul00FxdllYbDMuDQ03pzbulMoUhTi5Eq0CKSY
         FDJ+bHbfgGwk1aGRSoYSV+Z1RVK2idU4rxaZU=
Received: by 10.223.104.74 with SMTP id n10mr16113fao.5.1242153620356; Tue, 12 
	May 2009 11:40:20 -0700 (PDT)
In-Reply-To: <20090512182828.GA26812@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118943>

On Tue, May 12, 2009 at 8:28 PM, Dmitry Potapov <dpotapov@gmail.com> wr=
ote:
> 2. If you really want to be cross-platform portable, you should not u=
se
> =A0 any characters in filenames outside of [A-Za-z0-9._-] (i.e. Porta=
ble
> =A0 Filename Character Set)
> =A0 http://www.opengroup.org/onlinepubs/000095399/basedefs/xbd_chap03=
=2Ehtml#tag_03_276

Would it make sense to have warnings at 'git add' time about

 - filenames outside of that charset (as the strictest mode, perhaps
even default)
 - filenames that have a potential conflict wrt case-sensitivity
 - filenames that have potential conflict in the same tree due to
utf-8 encoding vagaries

MHO is that a strict "start your project portable from day one" mode
is best as a default. But I'd be happy with any default, actually ;-)



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
