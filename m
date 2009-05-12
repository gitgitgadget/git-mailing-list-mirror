From: Ping Yin <pkufranky@gmail.com>
Subject: Re: How to create a new commit with the content of some commit?
Date: Tue, 12 May 2009 23:47:42 +0800
Message-ID: <46dff0320905120847wae71bday4d4a890b00abc222@mail.gmail.com>
References: <46dff0320905120735l501dcaf4ia8197d24b7684cfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 12 17:48:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3uDC-0007mR-Ge
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 17:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758441AbZELPro convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 11:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758044AbZELPrn
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 11:47:43 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:63141 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758397AbZELPrm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 11:47:42 -0400
Received: by yx-out-2324.google.com with SMTP id 3so30578yxj.1
        for <git@vger.kernel.org>; Tue, 12 May 2009 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=ZazQeaZ2rT7W5Z+g01WU66gMcFOYwiD7fOnh+/iCanE=;
        b=jmRrmXH7IOONpjmuXrZ17nkTbFdRwCuirLnm+t7n2WDLr6ernUyfKVZZ/M5Ady/fNK
         wZirekmoKjzwvXLgwgGEqkVSp4exBJF6eQqmQkMC6Ry4V2A2u3jefAXz39IOg2WkKx4a
         HxZdx0vI9oq+nGU+hmPtsNBPwZu8cNQ+mUSxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=AZQiiwzy0znY5PZe6085GbTZqyOIj56tVpPwoM3LKvRQ8sf9XT00BkniVSwbTzvg5Y
         2Jhf8L3hFVjWfktes0Q3Es1finWootXUfnZOdOtkm6ETz+B7dOFLMO7LNRBcmJvtlAPA
         z6XjizVDq2OyqB52LzXw8ElXLZg0eOVx/RuY8=
Received: by 10.90.26.3 with SMTP id 3mr7062900agz.27.1242143262837; Tue, 12 
	May 2009 08:47:42 -0700 (PDT)
In-Reply-To: <46dff0320905120735l501dcaf4ia8197d24b7684cfe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118904>

On Tue, May 12, 2009 at 10:35 PM, Ping Yin <pkufranky@gmail.com> wrote:
> a----b
> =C2=A0\----c
>
> Given the graph above, I want to create a commit b1 on top of c, wher=
e
> b1 and b have the same content. i.e.
>
> a----b
> =C2=A0\----c----b1 =C2=A0 =C2=A0( content(b) =3D=3D content(b1) )

More precisely, b1 and b point to the same tree object
