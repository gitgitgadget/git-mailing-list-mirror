From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: "What's cooking" incremental edition
Date: Sun, 10 Jan 2010 15:21:20 -0500
Message-ID: <fabb9a1e1001101221i389c05a8v7ff241859d5e8dae@mail.gmail.com>
References: <7vmy0lpwes.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 10 21:21:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU4IC-0002oH-Tj
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 21:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409Ab0AJUVl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jan 2010 15:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857Ab0AJUVl
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 15:21:41 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:42264 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab0AJUVk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jan 2010 15:21:40 -0500
Received: by pwj9 with SMTP id 9so986939pwj.21
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 12:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nm5GC2yDdOH1VsAPjpYTCQb0OStzrlmH0pUCxkskHdQ=;
        b=huZEroKNegKSYQN8CWl3VTLs/WIcaLV/VVxR87NrEwLDB1HRMgcCPjwzholeeEibUs
         J32QxAEilU5/kSCd5FdL2+7ow2l/cWMqyCqBC/A72Qr1GGs1MPXahv2uRwxMXKNDxURy
         VYgl3dlvCpY7K/DJOFzif2KdYYXnfOyDuLypE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=T+6YyWUVSnulQbrYO7JoOyfbjU3aOQwQ1O/S7UzAIDZ1x6U0nJz+qtQqYi/OIHr0GN
         Lu6bzpQN9ROLFQ0XXH0JdSaTL+kiQb6liz8eO0ngjPCFAwpb3cYGq9NdxfcXewyMmLa9
         dnUCmhq1Mn9lOJV+D76FjRp95yd08EZnhoYxE=
Received: by 10.142.120.2 with SMTP id s2mr4849652wfc.311.1263154900074; Sun, 
	10 Jan 2010 12:21:40 -0800 (PST)
In-Reply-To: <7vmy0lpwes.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136587>

Heya,

On Sun, Jan 10, 2010 at 14:55, Junio C Hamano <gitster@pobox.com> wrote=
:
> =A0* jn/makefile (2010-01-06) 4 commits
> - - Makefile: consolidate .FORCE-* targets
> - - Makefile: learn to generate listings for targets requiring specia=
l flags
> - - Makefile: use target-specific variable to pass flags to cc
> - - Makefile: regenerate assembler listings when asked
> + =A0(merged to 'next' on 2010-01-10 at f5a5d42)
> + + Makefile: consolidate .FORCE-* targets
> + + Makefile: learn to generate listings for targets requiring specia=
l flags
> + + Makefile: use target-specific variable to pass flags to cc
> + + Makefile: regenerate assembler listings when asked

=46wiw, I find it harder to read due to the now ambiguous meaning of th=
e
+ and - (it could either mean something is in pu/next, or that the
topic changed). Of course this is partly caused by the fact that I
don't read emails in fixed font (by default), but perhaps it's worth
considering using different symbols for pu/next-ness?

--=20
Cheers,

Sverre Rabbelier
