From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: pulling git -- version confusion
Date: Mon, 9 Nov 2009 13:15:23 +0530
Message-ID: <f46c52560911082345y71eb12c9w114b799d70720dc6@mail.gmail.com>
References: <f46c52560911082214x81ae8beya139a8bcb3cbcf2a@mail.gmail.com>
	 <fabb9a1e0911082237x462b1203v724b51e309a2d89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 08:53:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7P4J-0007HX-JB
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 08:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbZKIHxd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 02:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbZKIHxd
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 02:53:33 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:41387 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbZKIHxc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 02:53:32 -0500
Received: by pzk26 with SMTP id 26so1946028pzk.4
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 23:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6C44lw4YNDje95gAaZXmQNqBCarnVyUjT9ru5omI6w4=;
        b=VR7rxjA3x6Y4hAgoztFMPwcpl424QF9nHaghaOCEthH6WlJlsEbEhy99Q8W/+XKvde
         BxRlj9AxqCXVloLumTa7sGwNVLGzN1DS5F85U+WQdgd6iWt8P7yZ7oNtnZRhpdY6pCDk
         DdSNfQa6qkgKoOLoAJsLVXDhb59YNwM2ftqjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uRS9A2wNtgkSIv5Dgax4Ih9lE5yieUsVR7ygR8SQ+FS0Hdk8zmY5hOxYTGyeScI8vz
         DXoOOA1umPCSc2vSmVWmvukgYiyx2kqDBV/gPxwSSimckl10jwW8AVxykiI0nANt2/uY
         j2HXeq++WgpnWYa+yfxZ9rqeSlqij7zLvUUyg=
Received: by 10.115.100.30 with SMTP id c30mr13138757wam.211.1257752724048; 
	Sun, 08 Nov 2009 23:45:24 -0800 (PST)
In-Reply-To: <fabb9a1e0911082237x462b1203v724b51e309a2d89@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132448>

On Mon, Nov 9, 2009 at 12:07 PM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> Heya,
>
> On Mon, Nov 9, 2009 at 07:14, Rustom Mody <rustompmody@gmail.com> wro=
te:
>> When I checkout branch next
>> git version becomes =A01.6.0.rc1.194.g9e4e
>
> Try either:
> $ git checkout master
> $ git reset --hard origin/master

Gives me
fatal: ambiguous argument 'origin/master': unknown revision or path
not in the working tree.
Use '--' to separate paths from revisions

>
> or:
> $ git checkout next
> $ git reset --hard origin/next

Likewise here
>
> Followed by:
> $ make
> $ ./git --version
>
> --
> Cheers,
>
> Sverre Rabbelier
>
