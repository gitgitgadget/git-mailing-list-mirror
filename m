From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] Add more instructions about how to install git.
Date: Tue, 8 Sep 2009 16:37:28 +0200
Message-ID: <40aa078e0909080737x701eb708t766edb024dc30c37@mail.gmail.com>
References: <1252386686-15689-1-git-send-email-tfransosi@gmail.com>
	 <81b0412b0909072244k21a4ddf6vdc38d9f713a4a084@mail.gmail.com>
	 <vpqhbvekldk.fsf@bauges.imag.fr>
	 <a4c8a6d00909080724q1c792f6bs641ea9d000d08b5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 16:38:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml1py-00061z-5E
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 16:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbZIHOhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 10:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbZIHOhf
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 10:37:35 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46936 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbZIHOhc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 10:37:32 -0400
Received: by bwz19 with SMTP id 19so2248166bwz.37
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=IwQdwY7Y2Q0UzWbmRkI0PWQK/dJgItzEZXSH+ma09Mg=;
        b=LrObOz3sCB761uWumHmLSciq4nMmE2zQXMgaPhK92jNbLu/VYCSchS7UlMxHE/iRIl
         JX1ibezjc7T+8viTyAyxORl4094VWde51WaZswIw0waGHwDL5Ot8r9qdFqv9DWX3WSe+
         aIniA+waQQsolNjzhJXoccUIz4rzu+o3f1g9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cr1NqhS74tXGz1iRU3hlE4CunOICm+DivdgMFHtpxWW6Vfm34vS2r//kIztZmy2ipC
         59q08tsuVfrdT9vXEKf7kCAga5cnBUnnrBSo97KXLUeIR1O3C+M0Yn5pyWekwphpAOpz
         E3xXUqmu/F7IvHtoKYSc0Ix/IRyCc40GtTjyo=
Received: by 10.204.34.5 with SMTP id j5mr13349217bkd.5.1252420652847; Tue, 08 
	Sep 2009 07:37:32 -0700 (PDT)
In-Reply-To: <a4c8a6d00909080724q1c792f6bs641ea9d000d08b5a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128009>

On Tue, Sep 8, 2009 at 4:24 PM, Thiago Farina<tfransosi@gmail.com> wrote:
> I tried to being more explicit about what the new users has to do. The
> first instruction that the text says is: "Normaly you can just do
> "make"".
> But the new user, cloning git won't have a configure file, so he can't
> just do "make".

I think you are confused. There's a default Makefile there, so a
normal user CAN just call "make". What a new user can't do, is to call
"./configure" without generating the configure-script first. There are
already instructions on how to do this.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
