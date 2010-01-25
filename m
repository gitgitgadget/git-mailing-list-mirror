From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 12:06:21 +0100
Message-ID: <fabb9a1e1001250306l2b9aba53s6a884b618a80063b@mail.gmail.com>
References: <201001250155.47664.robin.rosenberg@dewire.com> 
	<40aa078e1001250211w2dcc5e97vf89f64f136bd2f0@mail.gmail.com> 
	<fabb9a1e1001250222n6912905fqfd2e76f8d4496bb7@mail.gmail.com> 
	<201001251201.23064.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 12:06:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZMmL-000658-PD
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 12:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348Ab0AYLGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 06:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309Ab0AYLGm
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 06:06:42 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:47808 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab0AYLGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 06:06:41 -0500
Received: by pzk28 with SMTP id 28so335684pzk.4
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 03:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=EaXMHqffYmW5I5BTOI5gBNy7EEFk+L5biQcRipnTFhQ=;
        b=S4Lop50xYu4jZcb1+jvTk2YmFRHccmAm65Fkq7fi8WJu7Nlwu2Gqx02a0p10Jnhatq
         z0wMU2E2s0fUlrV7gy3N+NHGpugSrcHh5rYrlGwgIZdWVBrRP0vs+eLiVbueeFQeKPz9
         BA5bj37UmPLyuuLKG/qpvt6z+C74ZL/Ab7NgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=m7FvZVfvystMHOKAW6gZsNJp69MKumj4PzGFVx9e/pBxhqke1MswewbySYnRHFa2n7
         uchMjRSOikdaUCuV8NLvxEjuu1180FtSMFwznRbNrFPZAD0US7bfRwmU1z1J8kUAGV3I
         Ll8QoqQZ/YK6P7G535GLidQgkIyxIUEnAumKg=
Received: by 10.142.151.23 with SMTP id y23mr3387686wfd.269.1264417601151; 
	Mon, 25 Jan 2010 03:06:41 -0800 (PST)
In-Reply-To: <201001251201.23064.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137952>

Heya,

On Mon, Jan 25, 2010 at 12:01, Robin Rosenberg
<robin.rosenberg@dewire.com> wrote:
>> Ah, that's very interesting. Not sure that will help MSysGit a lot though.
>>
>
> Could you perhaps *try* it before claiming it won't work? I suggest you
> use forward slashes to avoid quoting problems.

Actually, I can't, cos I don't have a MSysGit build environment, I'm
just saying that in the environment I tested it in, I didn't have to
log in, so I suspect that it won't work, I'm not claiming anything.


-- 
Cheers,

Sverre Rabbelier
