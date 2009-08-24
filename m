From: skillzero@gmail.com
Subject: Re: git list binary and/or non-binary files?
Date: Mon, 24 Aug 2009 15:39:57 -0700
Message-ID: <2729632a0908241539l7243c9a4v170e14140b45cb0b@mail.gmail.com>
References: <2729632a0908241450m1651c77ata9744058c5d42672@mail.gmail.com>
	 <200908250014.03585.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Aug 25 00:40:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfiDX-0001bb-H9
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 00:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbZHXWj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2009 18:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbZHXWj5
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 18:39:57 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:25100 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbZHXWj4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 18:39:56 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1501840qwh.37
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 15:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=T5bM+/+DVMcNSc4WBr70XOKUz42P0LsBq4N92O6/gP0=;
        b=RoQkhqXHUI3VhWmZLc8q9p6HWHpbOxfoz6kr/yrS7bgJEo8gP8e1u4TNVKia2xhx0Y
         XkKS1uOnT9yU/B8ItiizutpxjR5jYUNMVFezQFOu9KOH4/vJ8XXuHHegjavepwO2xqV0
         Pjlbg8FTZmq4EMVbtXHQ7e7+fGh0qF4mW1HUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N1uY0lE88vEaGKJRL3WoOJvg3+Fls/ZZFr3N5e/oM9EIyQl71I7RiEhAniWnGV4Ert
         I7SOYuMmY1VrBroI8+xdx5oHD9pX8uSrRFwGYWpCCGTSNC0bxxRyd7g39ZhEKPEU+Ch2
         Q6ylv00CxWEHmM8qFQUg6fwlxvagiiYBXXDZc=
Received: by 10.224.23.131 with SMTP id r3mr3365140qab.273.1251153597982; Mon, 
	24 Aug 2009 15:39:57 -0700 (PDT)
In-Reply-To: <200908250014.03585.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126980>

On Mon, Aug 24, 2009 at 3:14 PM, Johan Herland<johan@herland.net> wrote=
:

> I use the following to list files that contain CRs, but that are not
> considered binary by Git:
>
> =C2=A0git grep --cached -I -l -e $'\r'

Thanks, that's what I needed. I needed it to build a list to pass to a
script so I used 'git grep -I --name-only -z -e "" | xargs -o ...'
