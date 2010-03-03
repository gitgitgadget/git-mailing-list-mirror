From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: split up a repository
Date: Tue, 2 Mar 2010 20:40:57 -0500
Message-ID: <32541b131003021740n32535fbbh802af418ea0898aa@mail.gmail.com>
References: <20100302011226.76fda85d@gmail.com> <fabb9a1e1003020240h81f3e99wea1185c080a03b0@mail.gmail.com> 
	<20100303002132.5df20326@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Levente Kovacs <leventelist@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 02:41:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmdaV-0002zv-Jv
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 02:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942Ab0CCBlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 20:41:18 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51714 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab0CCBlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 20:41:17 -0500
Received: by gwb15 with SMTP id 15so480167gwb.19
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 17:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=rXtuwrQC7oYyhs16+QRsDL++SLfoPwR/9SWmXxywd5g=;
        b=IzsPpFN/Jn3aM2thKnUcWQDxPcdCEfF/ljoFdW46Vsz9/ZSDnNOvbKZZDO/z6n9+Xv
         ApvHBVlTtITqBVsxZKQgKpV/78+Ky8PHE0I9H19SpGaYOmCOb6Vw3IQnNF1XKBBlKOrM
         rDuidmU7cJiWVx8T9G6YvbPJwz2F1YB4yTGVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OUNi6cmJEt6Vd0dSy5Fb60AV2l1qNVrcbNrIHapzBhbCw1Vn7i2SV7OvXAn3VLnVGD
         GcA9Ba8OtE/mo79z7duEj7BmX9qnwmsXqZ3oCtXep+/RPu/PoQPIYSkzSVonDMYoNg2H
         A0ZiJoWBWVbl2BEYKwKtyfmTct1anbDamVd8g=
Received: by 10.150.214.12 with SMTP id m12mr306297ybg.342.1267580477112; Tue, 
	02 Mar 2010 17:41:17 -0800 (PST)
In-Reply-To: <20100303002132.5df20326@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141430>

On Tue, Mar 2, 2010 at 6:21 PM, Levente Kovacs <leventelist@gmail.com> wrote:
> On Tue, 2 Mar 2010 11:40:41 +0100
> Ok. Really newbie question here. Just before I start to mess up my
> repositories. I've cloned the git-subtree, and the install script would put
> the script into /usr/lib/git-core. Is there any way to install the script
> somewhere under /usr/local ?

The actual function of git-subtree is one single file.  You can just
copy it to wherever you like.  Personally, I add the git-subtree
source directory to my PATH from .bashrc... but I guess I'm special
because I also change my version of git-subtree a lot :)

Make sure to run 'make test' first so you know it's working on your computer.

And I'll second Sverre's suggestion to *always* back up your
repository before doing weird stuff (although git-subtree is designed
to refuse to overwrite existing branches, and nobody has ever reported
it damaging anything).

Have fun,

Avery
