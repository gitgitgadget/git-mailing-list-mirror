From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git-send-email.perl defect: address missing trailing > accepted
Date: Wed, 21 Oct 2009 00:56:50 +0200
Message-ID: <40aa078e0910201556h4757dbbdn853be4dd8aa920d0@mail.gmail.com>
References: <1256076767.2029.59.camel@Joe-Laptop.home>
	 <40aa078e0910201529m338ef3d1o4fa1a31c3dcc2a20@mail.gmail.com>
	 <1256078917.2029.77.camel@Joe-Laptop.home>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 01:10:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0NdQ-0007IB-6i
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 00:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbZJTW4r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 18:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbZJTW4r
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 18:56:47 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:34392 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbZJTW4q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 18:56:46 -0400
Received: by fxm18 with SMTP id 18so7039375fxm.37
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 15:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=88Imiv9J8/v4N3fTARKSWxp/56SJQtnH+eHx1BmNqeU=;
        b=Y4WP8mJvyVT+adF7FFC7moLWUEA4uN5XzVxXDUGsomWwrv5HxRLNHSusdfM1XHhHfl
         H+BjBnnb07GGSHi3uU63c+T7SmlZA9Ob7bfS3KyY3tFBBC6+X3Xf/cyA6uckyqEpzkyy
         Ec5nMi+lvSQW9VmScg3qw1Cx6cr8yNlu/NwDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=WgvdbMEiMIeuGZsnuCaS07rX9NJoYJnd10RgJH4jD3D+52LUHe+xxNMr3luiG4gXWC
         mcTpLmuQpEhWIvhKPlAu6P64qu4+stQZzzV3/V82jCfiU6JMIM9nHcS3yAPLOzF9mXlO
         QcyGggBy8Bzsz2X4InVnVAx+TpPT1iKTU/k+s=
Received: by 10.204.7.144 with SMTP id d16mr7025922bkd.209.1256079410158; Tue, 
	20 Oct 2009 15:56:50 -0700 (PDT)
In-Reply-To: <1256078917.2029.77.camel@Joe-Laptop.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130865>

On Wed, Oct 21, 2009 at 12:48 AM, Joe Perches <joe@perches.com> wrote:
>> Something along these lines? Of course, the error message is, uhm,
>> less than helpful :)
>
> Maybe this? =A0Seems to work.
>

Didn't my version work for you? It worked for me.

I find it a bit cleaner to make it a part of the address-sanitizion,
since that needs to be performed for all addresses. I might miss
something vital, though. I don't really speak perl all that well ;)


--=20
Erik "kusma" Faye-Lund
