From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 20:20:55 -0200
Message-ID: <55bacdd30910301520h2678d0c2hd8478716d8ce4a17@mail.gmail.com>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com> 
	<7vljisk1m7.fsf@alter.siamese.dyndns.org> <7viqdwilx2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 23:21:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3zqV-0004SX-6v
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 23:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932980AbZJ3WVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 18:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932978AbZJ3WVL
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 18:21:11 -0400
Received: from mail-gx0-f226.google.com ([209.85.217.226]:62917 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932949AbZJ3WVL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 18:21:11 -0400
Received: by gxk26 with SMTP id 26so759011gxk.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 15:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Pp+rsBzshWdNHj8aQmtvQ+uPLGYHUr9VmmetZqE+qSw=;
        b=RLt3dcxDpq+5koUbmAuw1bv3glHpU0kgB/fidGV+iT+ooAY+UTE8tvW1GXeSAwnr74
         /R5TsrjjJKiro3BQ5vYW4UEJSD9gJtxcOBJXAK1DdH2bQ8SKXYN+7/5rfa0DCd1ZyJ8D
         RxEng/taQVxFfRiOoXSsMidUPm4WvpgbUSCZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vl9XFVkyTh+84VguWWRuSVEOMY7suLj5OPhcJWC3ZBO202W7tlnanGzd5LNYVHSvpI
         Ydb3MWM6xz2i0QvoFDl2LZzWJNkEuQ702NDqqCO7m216yLBzCI77/jOZUpa9xHq4l0v7
         2CthThLzgjHjfJUDDTRPpBL8rJX3pNpH2Xsrk=
Received: by 10.150.240.15 with SMTP id n15mr4005163ybh.212.1256941275086; 
	Fri, 30 Oct 2009 15:21:15 -0700 (PDT)
In-Reply-To: <7viqdwilx2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131766>

2009/10/30 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> ...
>> I agree that the issue the patch addresses is worth improving, and I=
 think
>> it is sensible to default to reuse the timestamp for -C and not to r=
euse
>> for --amend. =C2=A0I am not sure about -c myself, but it probably sh=
ouldn't
>> reuse the timestamp by default.
>
> So after realizing that this was about "author" timestamp, I am resci=
nding
> this comment about the change of the default for -c and --amend.

Actually I am only changing the default for -c and I see it useful.
At least with me I normally use -c only to use messages of commits as
template.

> But everything else still stands. =C2=A0IOW, I still (1) do think the=
 issue is
> worth addressing (thanks Erick), (2) the log message can be improved,=
 and
> (3) --(old|new)-timestamp should be --[no-]reuse-timestamp.
>
(1) You are very welcome! :-)
(2) As you demand.
(3) I prefer the other way just because of saving some typing and
being more concise in my point of view.  But you know you decide it.
