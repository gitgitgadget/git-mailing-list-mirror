From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] OPTION_CMDMODE should be used when not accept an
 argument, and OPTION_NUMBER is of special type. So change the mode to OPTION_CMDMODE
Date: Fri, 28 Feb 2014 21:42:21 +0700
Message-ID: <CACsJy8BM=m6=tv2P6F3EAcVPupovSTKC3s+5gkus3V+GZ4owRw@mail.gmail.com>
References: <1393597765-14164-1-git-send-email-sunheehnus@gmail.com> <CAJr59C1qHrQ9qPdDWfGzj9QX3L-EwEcP+updu0SDn24r4i7UMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?B?5a2Z6LWr?= <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 15:42:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJOeP-0003Rp-Hw
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 15:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbaB1Omx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 09:42:53 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:61218 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbaB1Omw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 09:42:52 -0500
Received: by mail-qg0-f43.google.com with SMTP id f51so2287979qge.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 06:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mZvxTQcp0e24qWvXpPs/fAmrgWBQo0aoMHkwqRJfcWk=;
        b=JS2uvoBvOwJJFEPcZ95iLUaaSMJD+MZl3ExnwQ6NbfV9HGx+VP5QhgCp+dNjBHoRkJ
         fi8hkVlHTq0Ocv6i7vcg31kmfB5fbCbUT5A+ytG9KR/wMc/iOXdhqN3ridLH1mUQOwWj
         9ac6zV2IMMX5GQMOBVCqHN6LgAL1LZnsc7lDKLf78m+AI9CkoZhCXuYqn9lHXk0K9lFn
         kx/zx8lKNpLOxDXMNdTBUG22YS1hi9FPDd/CWFpovJUonzepR8ZxYq8Bkwhq6VNXnUVT
         R/Mfv41KjuzIlJCbQhPuSzNXp6+G3JKUWNXxFeI//0o+GMyX2fch+fsrLOejq3XK4fpa
         jpmQ==
X-Received: by 10.140.40.5 with SMTP id w5mr3826390qgw.65.1393598572117; Fri,
 28 Feb 2014 06:42:52 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 28 Feb 2014 06:42:21 -0800 (PST)
In-Reply-To: <CAJr59C1qHrQ9qPdDWfGzj9QX3L-EwEcP+updu0SDn24r4i7UMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242969>

Way too long subject line. Keep it within 70-75 chars. The rest could
be put in the body.

On Fri, Feb 28, 2014 at 9:32 PM, =E5=AD=99=E8=B5=AB <sunheehnus@gmail.c=
om> wrote:
> I am not sure if this is a bug.
> I need your help to find out it.

Tip:git has a wonderful history (most of it anyway). Try "git log
--patch parse-options.[ch]" to understand parse-options evolution. Add
-SOPTION_NUMBER (or -SOPTION_CMDMODE) to limit to only commits whose
diff contains that keyword.
--=20
Duy
