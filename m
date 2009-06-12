From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Who uses Signed-off-by and DCO?
Date: Fri, 12 Jun 2009 07:56:16 -0700
Message-ID: <8c9a060906120756u194b783dp4d809d7f3d6921b3@mail.gmail.com>
References: <20090612084207.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 16:56:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF8BT-0008Pm-Hx
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 16:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbZFLO4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 10:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbZFLO4f
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 10:56:35 -0400
Received: from mail-pz0-f187.google.com ([209.85.222.187]:45531 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbZFLO4e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 10:56:34 -0400
Received: by pzk17 with SMTP id 17so635766pzk.33
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Aq4kFKeGKCc7K3mOoAENvurNYt6kelCOomTRS9lohqI=;
        b=UEOkrLX8QDixh6cM1tHwKfYk6mHVn9b1aol++AKBXvesnqZloIbSgLlRFyw7Oq4qeW
         S8BJi+WI6V3s5hxkwO/c2Sq57tj7yJuWAr3HGPxJbaieDeDAh3UdmdMqtDvdI56XiW7j
         rcP1RWqqgGG3fdd48aLrhiIvwF3VKsrE0OXLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ut+6HSysiLKx7Xys0AH8rKqTi1V+yhQS6o3RSe36+g7915v+iOkGyvNPjWGW3feu9B
         BoscCBlpU+pzQYrXyJ5gUwu4Kwp4Bv9lVUQrOwc+ANKsUTic0E0HMtqrCvWbIQ7TCR05
         vTxu0ewenqGR284gqiuRyrIIu9Ttum5XtZyoA=
Received: by 10.142.166.7 with SMTP id o7mr1459820wfe.239.1244818596050; Fri, 
	12 Jun 2009 07:56:36 -0700 (PDT)
In-Reply-To: <20090612084207.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121427>

On Thu, Jun 11, 2009 at 16:42, Nanako Shiraishi<nanako3@lavabit.com> wr=
ote:
> git provides options and configuration variables to easily handle the=
 Signed-off-by tag line. It is used to certify that the sender certifie=
s the patch with the Developer's Certificate of Origin.
>
> I have read SubmittingPatches document and understand this convention=
 is used by the Linux Kernel Project.
>
> I was giving a git introduction to students in my lab, and this quest=
ion came up from one of them. How widely is this convention used? Are t=
here projects other than the Linux Kernel and git itself?
>
> --
> Nanako Shiraishi
> http://ivory.ap.teacup.com/nanako3/
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

GitHub uses it for the Fork Queue.  Whenever you pull in someone's
changes through the Fork Queue, it will add a SOB line for the person
pulling in the changes.  In this case it appears to be an "I approve
these incoming changes", instead of the DCO.  I honestly couldn't say
how common it is for projects that aren't on GitHub to use the SOB in
this manner, however.
