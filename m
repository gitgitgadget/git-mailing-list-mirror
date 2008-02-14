From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: Using kdiff3 to compare two different revisions of a folder
Date: Wed, 13 Feb 2008 22:36:34 -0200
Message-ID: <b8bf37780802131636q698ebb21kc415328c04d8425d@mail.gmail.com>
References: <b8bf37780802121744i62849a53rfa71cc0571aec3a@mail.gmail.com>
	 <200802132338.18449.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 01:37:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPS6C-0007Jj-P3
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 01:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765135AbYBNAgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 19:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762464AbYBNAgh
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 19:36:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:49687 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760647AbYBNAgg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Feb 2008 19:36:36 -0500
Received: by ug-out-1314.google.com with SMTP id z38so899417ugc.16
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 16:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fkTVVKNpRUN+Sv9J68oguqWhEZyUH5EQRMswS9u1NRU=;
        b=Wu3OfMsARhtnuOhjKSAKrQL71PPZUYyno6iNQze/AP8yci1OMf4+svBjP5Mk835tY3IxFn6yhx3MpezjgX7AUKipvxXj8NWKYAX8OTB4JBkKZOummMUOD5WEgjIkhtOci9HUjNkEJXsYM/mi7cFC/I2gV3mOW/+HUjRKvA3NhJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PoVGOdGyVchmiSe0/WnEPUOO/PgSMEBWDGurJq5wte1rYW6aFePQo72KigAIUDZvIHvCpbBvLY3HwGRTiNQE86B4OXa3JvQw9+pXV3GkPzOL1gSKyidXkYa1HTFos+yo+/dJ9/Xt9uGzJ+XPxxfXvbwbWrtyHXRUMJvGZtKL3ME=
Received: by 10.78.204.7 with SMTP id b7mr1193532hug.74.1202949394824;
        Wed, 13 Feb 2008 16:36:34 -0800 (PST)
Received: by 10.78.100.15 with HTTP; Wed, 13 Feb 2008 16:36:34 -0800 (PST)
In-Reply-To: <200802132338.18449.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73832>

> >     Is there a better way to do this kind of comparison?
>
> Yes.
>         git diff <whatever options> | kompare -
>

Thanks, Robin! It works too.

--=20
[]s,
Andr=E9 Goddard
