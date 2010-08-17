From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: gitk: Removing Stacked Git branches from the --all view
Date: Tue, 17 Aug 2010 12:42:11 -0500
Message-ID: <AANLkTi=4Jr6KknLyBUe_+bQ4zue2KGNjxJtY8Ja6LmAT@mail.gmail.com>
References: <4C6A25E5.5050707@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 19:42:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlQBL-0002wV-2O
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 19:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757847Ab0HQRmd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 13:42:33 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35571 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0HQRmc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 13:42:32 -0400
Received: by ywh1 with SMTP id 1so2611279ywh.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=iWWppiS68/YyxN8EqfPkHeca+hHvAJ0fhHTn/gzhNqk=;
        b=hhMtS0XDZjHR048yzVTeBxG0WXMFwC/TNNsegUcqVgUj/0HQavLIWcNPREAnjT6J9G
         ojmePYeGB0in0Nrnc0RU465V4vXolsep8EwsZXAOOGCXR6F9yju3Og6JbhQymTQIS+WL
         kVkDcPFXmpPCiIonfcIh9Tgeh3hvAt01hM7g0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=K1fxYYqk35OX1JhELyBnWAxcE5ybLM7tKf93T54pN+2fkYn7KOZbpXMdA0VFKqJE2i
         WEj6m0Tj46sOHIeylTnZ96/B5GzMtb2zAATW50cfP08OgPP0+jE36zRLkDJoKR8kuJiX
         TYM5hxezzJHOgfT4nYXA0WfsQdVmZDf01pLTA=
Received: by 10.150.58.20 with SMTP id g20mr7751099yba.0.1282066951494; Tue,
 17 Aug 2010 10:42:31 -0700 (PDT)
Received: by 10.150.98.8 with HTTP; Tue, 17 Aug 2010 10:42:11 -0700 (PDT)
In-Reply-To: <4C6A25E5.5050707@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153768>

Heya,

On Tue, Aug 17, 2010 at 01:02, Joshua Jensen <jjensen@workspacewhiz.com=
> wrote:
> I've been playing around with various 'git log' options, but I'm not =
finding
> one that gives me the gitk --all view as if StGit were never attached=
 to the
> repository. =C2=A0(Speaking of StGit and apps that store metadata in =
branches...
> it would be awesome to have a filter that knocks those branches out o=
f ALL
> views of the data.)

It would be easier if StGit DTRT and stored its metadata in a stgit/
namespace. That way you could just do `gitk --branches=3Drefs/heads/`.
There's (afaik) no way to specify what refs not to show, you'd need to
teach 'git rev-list' a way to ignore a ref space. You'd have to teach
it how to interpret something like `git rev-list --all --not
--branches=3Drefs/heads/*.stgit`.

--=20
Cheers,

Sverre Rabbelier
