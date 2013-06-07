From: Sarma Tangirala <vtangira@buffalo.edu>
Subject: Re: git diff bug?
Date: Fri, 7 Jun 2013 12:01:07 -0400
Message-ID: <CANd8ic+6AtWgbK3S7DMkaOz7K9WJYdq8ozP9mesc-vJRhxLjqg@mail.gmail.com>
References: <CANd8icJ_1mqT9m-n3wPPdjzG1oNjwxfQeUA6YL6KVxbq0iEa1g@mail.gmail.com>
 <51B10236.2030009@ensimag.fr> <7v4ndayjdt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?C=C3=A9lestin_Matte?= <celestin.matte@ensimag.fr>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 18:01:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukz6c-0004xl-FJ
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 18:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076Ab3FGQBa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 12:01:30 -0400
Received: from mail-vb0-f47.google.com ([209.85.212.47]:65221 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982Ab3FGQB3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 12:01:29 -0400
Received: by mail-vb0-f47.google.com with SMTP id x14so2782319vbb.6
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 09:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=+DqNE5L0vQuJOgs1EiHIvnqsPupXaEg2kwPp6yBWRBY=;
        b=Yj/9BK2AMvmDn+EU/Z96/kPqJ4BSmuOR6R8024OesEvGbT0C/VLuCSJaMEEJ/kAlcF
         iOib5W3vKblnFBY7cMDwuyQM4T/YNsiF2hIR4iZDWkzhqbb2kqfLpPbHE6bj+mJKyQQg
         wdyyw7uBX9kWRCnV6W2rhBCwhkdJ+s0MdqZJduLwBTetv3zm1sGoVQWuIlx03klKY31Y
         7uS6bBE1DAtNsRDn9aMNjy5hlDzSorYf/GeKm+apkanhOKbJTzYIu6xdqaExsApHMlyr
         tMHDtuiqiS+6H0yEQw8N9Q89Pjz563pHwIPxCOqXyGQ2ZRCsO2PqnVCN9oURHla5wNES
         WohQ==
X-Received: by 10.52.19.67 with SMTP id c3mr20331074vde.19.1370620888655; Fri,
 07 Jun 2013 09:01:28 -0700 (PDT)
Received: by 10.52.23.143 with HTTP; Fri, 7 Jun 2013 09:01:07 -0700 (PDT)
In-Reply-To: <7v4ndayjdt.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkTXkcbCe9d3bBtwDAKKYnjTbQz854XoLFQsJ3JO6lD0GQPCp//P3koYgZzNvLqEGPiuz0/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226643>

On Thu, Jun 6, 2013 at 6:17 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:
>

> But for a two-endpoint diff Porcelain (not the plumbing diff-files,
> diff-index and diff-tree), I do not think it is particularly a bad
> idea to add such a "typo-detection" feature.

I was wondering if this feature is going to be added and if I could
try implementing it.

--
010
001
111
