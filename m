From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: GIT on MinGW problem
Date: Tue, 29 May 2007 14:45:35 -0400
Message-ID: <fcaeb9bf0705291145q6a0d276o6a94ded3c3e0b6d1@mail.gmail.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500>
	 <f3a2ke$9s7$1@sea.gmane.org> <465C064F.B9CE9379@eudaptics.com>
	 <465C1252.9020801@trolltech.com>
	 <Pine.LNX.4.64.0705291305540.4648@racer.site>
	 <465C2516.7040607@trolltech.com>
	 <Pine.LNX.4.64.0705291446170.4648@racer.site>
	 <465C3502.BE134BC9@eudaptics.com>
	 <fcaeb9bf0705290828j3703cfa9g11f2f7afb17a8c91@mail.gmail.com>
	 <465C4B0E.C34795B@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Marius Storm-Olsen" <marius@trolltech.com>, git@vger.kernel.org
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue May 29 20:46:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht6hl-0002Hy-GR
	for gcvg-git@gmane.org; Tue, 29 May 2007 20:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbXE2Spj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 14:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbXE2Spj
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 14:45:39 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:26405 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbXE2Spi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 14:45:38 -0400
Received: by an-out-0708.google.com with SMTP id d31so575595and
        for <git@vger.kernel.org>; Tue, 29 May 2007 11:45:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QX5TmjxZ87wMgF2xF/tmafLCrY4s9qGfhZhgxw/3t0bAtsPczH7kyZfatTO7+Bn7syiyjmz5zatBWz696A9lF8RpYT7fZA04Jg6qsc5Qdec7b3Mrq0v0hOLUQqBYKuo5n+ELDAX1tr1Xil1KerXOe+YU8jqzqZr15GfrAeoAEGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nya5GaP6B5ZNZbJcBuiY43XzR1sDOlRoNXi6wpfvStTHn0MdOnvPUjx6RNXkuqpJdprwJjs00fSCxGnB+Bn0vn4fqLDqsyd4NbQiLUubR5oTrwQ3QfuWmvw1pcs3XBohvnC7v8MUx+nkteJo0wkGrEkp5OiKl1czzIhQ+oFrke4=
Received: by 10.100.165.9 with SMTP id n9mr5409156ane.1180464335115;
        Tue, 29 May 2007 11:45:35 -0700 (PDT)
Received: by 10.100.127.2 with HTTP; Tue, 29 May 2007 11:45:35 -0700 (PDT)
In-Reply-To: <465C4B0E.C34795B@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48705>

On 5/29/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> Nguyen Thai Ngoc Duy wrote:
> > I'd suggest create a small C wrapper to launch gitk. It would be much
> > easier that way IMHO.
>
> Doh! You're right! It's even there already, right before our eyes:
>
> pointy..clicky..pointy..clicky  (aka: cp gitk git-k)
>
> $ git k
>
> :)

Maybe we should teach git.c to try gitk if git-k is not found ;)

> -- Hannes
>
>


-- 
Duy
