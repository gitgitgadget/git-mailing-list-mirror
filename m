From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/1] Add new --index-filter example to git-filter-branch.txt
Date: Wed, 27 Apr 2011 21:24:44 +0200
Message-ID: <BANLkTimPirVXdqwckoqEhU05iqvvpce-8g@mail.gmail.com>
References: <1303927684-6513-1-git-send-email-michael.ocleirigh@rivulet.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Michael O'Cleirigh" <michael.ocleirigh@rivulet.ca>
X-From: git-owner@vger.kernel.org Wed Apr 27 21:25:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFAMc-00050c-ES
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 21:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276Ab1D0TZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 15:25:25 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45968 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab1D0TZY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 15:25:24 -0400
Received: by vws1 with SMTP id 1so1561761vws.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 12:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=JOiP0mYkm+u8sD8eRS25Psb1EKl70jTwphmBnZsg+rk=;
        b=ntZ+GiBW8smzulcEjIVyC9LzDW1U4djaEsfz2+vSIaIaq9500dXHLMsmzoZRLXFNp6
         6AAfqGLLdzPtBwSP9K0xfBgJlo+A9XptQZ9yY6iEY88AsP6YxSo20193hVGGQd6PDuHe
         Aw0aVlpcz/Fbz7OS80Hs5VQW/SrNlH5zI8juE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=AWJMqAHGl/FrYgTaYUZ+Rzrp2jTcbxGEvubETjRBoGPzckkmqrdTCqoU+61Ip5OePN
         kzL2aHTX8BLgCWYGmniLOcYbSbVEdDcNaJSYwJuTNozI1uPrIaKWFZJpgzlLideeFrr4
         ctsi0jUWMY6uYP8nARBkVJhcvgNZGEL38W85Y=
Received: by 10.52.74.74 with SMTP id r10mr3658929vdv.212.1303932324050; Wed,
 27 Apr 2011 12:25:24 -0700 (PDT)
Received: by 10.52.182.230 with HTTP; Wed, 27 Apr 2011 12:24:44 -0700 (PDT)
In-Reply-To: <1303927684-6513-1-git-send-email-michael.ocleirigh@rivulet.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172263>

Heya,

On Wed, Apr 27, 2011 at 20:08, Michael O'Cleirigh
<michael.ocleirigh@rivulet.ca> wrote:
> At work I patched git with the prevously sent --egrep-filter patch that allows
> an irregular history to be retained, like where code reorganization occured and
> you want to keep the history from the original locations.
>
> The comments I recieved at that time was that my case was an --index-filter
> variant.
>
> I've reworked it into an --index-filter using the $GIT_COMMIT variable, tested
> that it works, and have added it as an example to the git-filter-branch
> documentation.

Meta nit: for a 1 patch series we would usually put this kind of
introduction after the --- in the actual patch.

-- 
Cheers,

Sverre Rabbelier
