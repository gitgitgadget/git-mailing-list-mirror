From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Sun, 3 Jan 2010 11:47:19 +0900
Message-ID: <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
References: <1262182304-19911-1-git-send-email-pclouds@gmail.com> 
	<7v637nzky0.fsf@alter.siamese.dyndns.org> <7vzl4zy5z3.fsf@alter.siamese.dyndns.org> 
	<20100102115041.GA32381@do> <7vtyv4cpna.fsf@alter.siamese.dyndns.org> 
	<fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com> 
	<7v7hs09tpi.fsf@alter.siamese.dyndns.org> <87ljgfgbl0.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 03 03:59:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRGfZ-0004kx-Rc
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 03:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994Ab0ACCrk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jan 2010 21:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790Ab0ACCrk
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 21:47:40 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:38854 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab0ACCrj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jan 2010 21:47:39 -0500
Received: by iwn1 with SMTP id 1so10172828iwn.33
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 18:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=hgSZA52w+vXftRl996uUXJKVqxe02BaAa8gaRw1RJDc=;
        b=PTVfUDAUcIqdlwaMEYWNSinL+WsG3Dby4fvvPnOpJqwJ8eUoI9PfBF9E88Qs96fZs9
         tJp4AYyBxnN3tShUqDPHO/c1vRzSC6SgeHpDQPBb4LwSn2GPxPieSc3hM5FxazrcrpyY
         msL9cfxu4B226V7PYAB8Ct0NSavTSnpno0dT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=AZaXOlNa2OTBJbO//yfmBAf7c6ebFXNbEItbNkpKrlUyuw3Xfc/MP1i/0W/KxaueFW
         VcvNuJuqup5k8a2bbFKhtJlW9W5JU3mdGSIJ5ozfVLoTUaintt5aQPmocfGMcAvxrVk2
         D7fQ/xUSe1C9SbwLK++rOYGR/JUQdW737MigI=
Received: by 10.231.21.157 with SMTP id j29mr3930413ibb.28.1262486859137; Sat, 
	02 Jan 2010 18:47:39 -0800 (PST)
In-Reply-To: <87ljgfgbl0.fsf@catnip.gol.com>
X-Google-Sender-Auth: 8f5dd74c371d9f85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136063>

On Sun, Jan 3, 2010 at 11:35 AM, Miles Bader <miles@gnu.org> wrote:
>> Then please at least make the second grep "grep ext-grep", droping "=
-e --"
>> from it. =A0We assume some implementation of external grep to lack "=
-e"
>> (e.g. Solaris).
>
> Isn't "-e" a "classic" grep option tho?

Hmm, a bit of googling, and it seems that while 7th Edition unix (as
classic as I get) had -e, solaris indeed doesn't....

-miles

--=20
Do not taunt Happy Fun Ball.
