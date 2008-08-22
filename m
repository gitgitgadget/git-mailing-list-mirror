From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Call Me Gitless
Date: Fri, 22 Aug 2008 13:10:36 -0600
Message-ID: <51419b2c0808221210k6e7defdcw3ba9e4ef89e054e7@mail.gmail.com>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
	 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
	 <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>
	 <48AA7BE9.4040108@sneakemail.com>
	 <7vk5edfn6g.fsf@gitster.siamese.dyndns.org>
	 <ee521d6f0808190157s6a676a75t2ba3ef095f608431@mail.gmail.com>
	 <vpqk5edid2y.fsf@bauges.imag.fr>
	 <ee521d6f0808190309n7f0114a6q2e8113238cb2142b@mail.gmail.com>
	 <48AAAE17.1070800@obry.net> <48AD7895.5010707@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: pascal@obry.net, "Alexander E Genaud" <alex@genaud.net>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Junio C Hamano" <gitster@pobox.com>,
	"=?ISO-8859-1?Q?Lists_Peter_Valdemar_M=F8rch?=" 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: "Paolo Bonzini" <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 21:12:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWc35-0004Q6-9M
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 21:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306AbYHVTKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 15:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755633AbYHVTKj
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 15:10:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:2906 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbYHVTKh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 15:10:37 -0400
Received: by rv-out-0506.google.com with SMTP id k40so558835rvb.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 12:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WMfA9Wsm7QMezI6y6/Sd9gtCeuAJlg8RobLsGq7axMY=;
        b=VQL9QAB9zvDLjKHpyx+pdXEbubTEmG4+xmG5dYYTwdKM8RddRLP27Td5VMd6yRrHz/
         08s/ANgYQvD4fhIM13AmzrAcAWRlTqFZJRFjJdPUwJ6z5zzaDpi3i3MuxxKSeH1OlWTQ
         qrAkA3ACsv5Jxletm8f+pzNGH25kYIphdMyUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=J1UdssHS4DoLTubsEZyUSISn1EJwpqjU0hzSl7LnWSNq94tJdrgD7U/izz7JQLSfXT
         i0s++RddXB9KfKzsY5DJDhdf7jixdtdO4evP5yRHMQ91Z6Exu6fcuKtmdJtbSkfdFd3M
         s2D2K1JyIHc7m4dGoTqUauEPsxXlc4UE9IUus=
Received: by 10.141.136.8 with SMTP id o8mr695920rvn.271.1219432236403;
        Fri, 22 Aug 2008 12:10:36 -0700 (PDT)
Received: by 10.141.5.11 with HTTP; Fri, 22 Aug 2008 12:10:36 -0700 (PDT)
In-Reply-To: <48AD7895.5010707@gnu.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93343>

On Thu, Aug 21, 2008 at 8:15 AM, Paolo Bonzini <bonzini@gnu.org> wrote:
> I used to think that the proposal I saw in another git frontend, which is:
>
>        git diff --cached -->   git diff --staged
>        git diff -->            git diff --unstaged
>        git diff HEAD -->       git diff
>
> was a good one, but it is actually not when you start thinking about what to
> do during a large merge with few conflicts.  In fact, even though I use the
> index almost exclusively when merging (*), I don't mind the few extra
> keystrokes.

If you look a little closer, you'll note that the three lines of this
proposal has an exception specifically for the conflict during merge
case.   :-)

Elijah
