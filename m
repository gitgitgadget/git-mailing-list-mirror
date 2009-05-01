From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Fix a bunch of pointer declarations (codestyle)
Date: Fri, 1 May 2009 12:20:08 -0700
Message-ID: <780e0a6b0905011220g42d9784dp186cc7ff7669081e@mail.gmail.com>
References: <1241168796-7222-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 21:20:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzyHm-0008MT-Ik
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 21:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162AbZEATUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2009 15:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755649AbZEATUa
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 15:20:30 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:56841 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbZEATUa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2009 15:20:30 -0400
Received: by an-out-0708.google.com with SMTP id d40so2115894and.1
        for <git@vger.kernel.org>; Fri, 01 May 2009 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SHR258lSOAc4whNbcjRDCK3PwAClWJ39XayzOQXraq4=;
        b=odsxXqXhxzMLnkwTGcSlrFuddTfz6PLiNP05P9VyXvtTAzkA/mmDdmugDpG0EgRrc0
         I1alqUnrmxgQMf4qJgel43nyWDvjfvzatR3TSgSO5L5GFriVyGQu23VWWesbnBEZOwmD
         Sd0xEF+2DdUXAdPa6PMDc8oyxZXcYlhpJKFF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=s53XAOfPBdRtGNYCV5EfUUmmRTFE+xCgrJQ88smxFQQOqkteYsqhfSFnHYzzWG9rCy
         +uvS5bF8iq9PdwrW7hcbiUv3y+UQcgAXLvNDpwtIepUh56muKjM+KqUgGSZ6PRoxht3g
         8SJ0e3MkV46AdiO/LYLRaB6SORATI6LPYRmdw=
Received: by 10.100.252.9 with SMTP id z9mr6584990anh.34.1241205628200; Fri, 
	01 May 2009 12:20:28 -0700 (PDT)
In-Reply-To: <1241168796-7222-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118092>

On Fri, May 1, 2009 at 2:06 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> - =C2=A0 =C2=A0 =C2=A0 *argv =3D xmalloc(sizeof(char*) * size);
> + =C2=A0 =C2=A0 =C2=A0 *argv =3D xmalloc(sizeof(char *) * size);
>

I don't think this is what the coding guidelines is talking about. A
pointer isn't being declared here plus there isn't any variable the
star should be sticking to.
