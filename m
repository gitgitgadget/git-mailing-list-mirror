From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] completion: remove 'git column' from porcelain commands
Date: Fri, 11 Dec 2015 19:21:51 +0100
Message-ID: <CACsJy8BProX93z3O1=fEOeehVNCgkSh4yukn78Yxija1EgttQw@mail.gmail.com>
References: <1449835500-24844-1-git-send-email-szeder@ira.uka.de> <xmqqegesg8b2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 19:22:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7SKp-0003E7-HN
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 19:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbbLKSWX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2015 13:22:23 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34428 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbbLKSWW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2015 13:22:22 -0500
Received: by lfcy184 with SMTP id y184so11335303lfc.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 10:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VT50cS34YUJC0EKw6jIPkFjTBzZ+Cqed6o6gUNpPE0w=;
        b=Jj8JxlZUejeAhHDzkz1IOi9lQosI4nV1NfG0clz4gKKpYcnFULE8iq3eR4vshkBd8q
         tdV0ydDlM9TQB4buvk+WPu64uaejJ15JkJCzmI2JMI9s3jF7F5vZs5Jbg9Wq8n4nzlut
         0AbhPl7p+W2aKSgXernzABGHurcFpOOffhQrkCxTkg2AdseNMO919Z1n6yFnbT6zKFX8
         9FQflG1QIeqAdtii43H8lXoMlehKVYaWRwn7vuNK1f+GpN5N+K0ptfCmq6yFUPP5BePY
         rPoFGWXfBXL+baUV+5qxKh972ZpMmXO5iYQfb844fj52LOjJjR8/s4uKK98fXFEqoj1g
         9wHg==
X-Received: by 10.25.165.202 with SMTP id o193mr8366429lfe.83.1449858140912;
 Fri, 11 Dec 2015 10:22:20 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Fri, 11 Dec 2015 10:21:51 -0800 (PST)
In-Reply-To: <xmqqegesg8b2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282266>

On Fri, Dec 11, 2015 at 7:16 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> 'git column' is an internal helper, so it should not be offered on
>> 'git <TAB>' along with porcelain commands.
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
>> ---
>
> I think this makes sense.
> Objections?

Not from me.
--=20
Duy
