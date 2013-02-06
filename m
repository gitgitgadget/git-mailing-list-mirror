From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git-svn problems with white-space in tag names
Date: Wed, 6 Feb 2013 10:26:42 +0100
Message-ID: <CABPQNSbRU2=a0ONGDKH4O_HTyMuEGFcVfTSRuEY3BRSh_5whdA@mail.gmail.com>
References: <CAK3CF+4GPKBfAmgsHYnf_6nCCOCe-1d31cGsWp4jkKC28cZr0g@mail.gmail.com>
 <CAK3CF+46a2LsrZ0ef5Bc2XfwCVv1LVk6YbMasa6e5kx-Dp3JTg@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Hans-Juergen Euler <waas.nett@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 10:27:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U31IC-0004OV-1k
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 10:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160Ab3BFJ1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 04:27:25 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:60337 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab3BFJ1X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 04:27:23 -0500
Received: by mail-ie0-f180.google.com with SMTP id bn7so1639639ieb.11
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 01:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=tVLBnvW7F4pE9bF/3MUBgiZZf15Wb1xrKgSZ9wTLSig=;
        b=E/vMr/maW00/r/eR7QIDv3wU4UV+gpii61AptWYHKJGXj12ddaSwUNLLlCRe5YfVTt
         QsckpdRBLvy/XyhcGF89boWW/GeRC7CPYQvD1QKK6TFMgR2QbuNcQZX3ldLLbJ+ZLYOv
         +iiWLVZKYhvyR6xYGBw0qe6y7Rks1rvVfag4l6ZCZk3pe+p5hE6d/ERlrnDKSzYKknpj
         cMiI0lV4R5QdGQH3A0k+1+nFJWtRwKRAfCNGrxj4190eUaoChZicIj0yVqkbblnhAUER
         WurA+TEKzKVZrCE8PC8I4cv00m3+5dbegvsuX9TpRbFBZazONXZJnd5cC6j0djoH5KYi
         /5LQ==
X-Received: by 10.42.27.74 with SMTP id i10mr27672274icc.47.1360142842914;
 Wed, 06 Feb 2013 01:27:22 -0800 (PST)
Received: by 10.64.14.161 with HTTP; Wed, 6 Feb 2013 01:26:42 -0800 (PST)
In-Reply-To: <CAK3CF+46a2LsrZ0ef5Bc2XfwCVv1LVk6YbMasa6e5kx-Dp3JTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215567>

On Sun, Jan 27, 2013 at 3:12 PM, Hans-Juergen Euler <waas.nett@gmail.com> wrote:
> This seems to be a problem of the windows version. At least with its
> complete severity. Installed git on Ubuntu in a virtual machine was
> able to clone the subversion repos past the tag with the white-space
> at the end. I am not sure but apparently this tag has not been
> converted.
>
> The git repos I could copy from Ubuntu to windows. So far no problems
> seen in this copy on windows.
>

The cause of the problem is that the tagname isn't a valid filename on
Windows, which git requires it to be.
