From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 15:42:02 +1000
Message-ID: <BANLkTikiuBkF00WeanBV8X8JeooMReHcHA@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<7vwrig9ta7.fsf@alter.siamese.dyndns.org>
	<BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
	<7vsjt49stq.fsf@alter.siamese.dyndns.org>
	<BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
	<7vk4eg9rsf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 07:42:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QExVq-0003KH-DU
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 07:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab1D0FmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 01:42:05 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55693 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab1D0FmD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 01:42:03 -0400
Received: by ewy4 with SMTP id 4so402666ewy.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 22:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=PJso4TzAtHtonGQI7lcdb/HxCCnfmHcS5j4nHJdjeX4=;
        b=o+F+vwo/4fWxMwudcD7tAj/MCno/dlkdVs1Eik1UZkYpgGs72PrJzVishx4EcxfVUZ
         j7now/xbLDgLCa9YEsbHHxwR8g4fZwz8CN4CRi2dGEB9PiftNZXqgTbWo2Ptcts1TQIF
         F4S9UGRFaUDmtAyEBC3X6AxwbwzWe9Vr9ogo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=x7XDhoaqjKG/UXx+hegHLeGXK4Om2NtW22veduv9HEAcO3WuAIW1i/5nMiL6mmiK2i
         JiWpdWaBOyOV1keZcP1D0D71XKvGbHsYBDb1rSquAsBGSe9TdJAtUE4u+X5/CgVEZHRg
         pQLBbvocWwr85TpqaHKUz8QqeMjeRxIcH7oH0=
Received: by 10.14.10.130 with SMTP id 2mr729276eev.181.1303882922512; Tue, 26
 Apr 2011 22:42:02 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Tue, 26 Apr 2011 22:42:02 -0700 (PDT)
In-Reply-To: <7vk4eg9rsf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172177>

On Wed, Apr 27, 2011 at 3:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> My thoughts about this are inspired by how the node project manages
>> packages with its npm package manager and also the fact that I have
>> several ideas on the boil at the moment that would definitely benefit
>> from a standard way to manage these concerns.
>
> Sounds like you have a plan ;-)
>
> It would be ideal if you can arrange things so that the only thing the
> user needs to do is to point your package manager to one subdirectory of
> contrib/ and everything necessary would be installed...
>
>
>
>

By that you mean the contrib/ directory as the repository of
extensions, with one such extension being the plugin manager itself?

jon.
