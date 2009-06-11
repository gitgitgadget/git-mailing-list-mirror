From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v2] doc tweak for git-send-email
Date: Thu, 11 Jun 2009 14:57:22 -0700
Message-ID: <4A317DC2.8010304@gmail.com>
References: <4A30568E.7060503@gmail.com> <1244705427-3376-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jun 11 23:59:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEsJL-0002YV-V4
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 23:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbZFKV7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 17:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754545AbZFKV7i
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 17:59:38 -0400
Received: from mail-pz0-f187.google.com ([209.85.222.187]:64591 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328AbZFKV7g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 17:59:36 -0400
Received: by pzk17 with SMTP id 17so194039pzk.33
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 14:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=2ONMa28Z7iQVXTY5WXwWF2OLM0yC0LXVgVR5HsEhKhA=;
        b=a6E5gsK79Di2XtqMJ51tMZE7jxLzn07/u65ijCajxg41jgJmTZe8BsQyno0uR7+u+B
         R0T3lTEnSUvOa/T7qkez4zjWD7oF5d9sOPunOtBfHAgsq5V1j5DZ80SeP5oq6u8fBOSG
         DicEUcquPX9ek8FjRW6Vt2LHmyDCbUP5HVIDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=LUqMPCwAf/WLgVvA5XvqPdTfCFDg2/KegPA3Tp+kIpsFxiZmCGyAy0vpu6Bn2sWTde
         8sZtRaTdLUiGKGoq01etOGyW5D14nvlcYRR5WhISgyuIqr0baUzG0ITdWw+qPylQvdWB
         vmOixArw0GuoLKcQdLHWLVISefUEZoPzSY7UE=
Received: by 10.142.114.20 with SMTP id m20mr1254466wfc.234.1244757579133;
        Thu, 11 Jun 2009 14:59:39 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id 9sm728441wfc.36.2009.06.11.14.59.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 14:59:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <1244705427-3376-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121365>

Paolo Bonzini wrote:
> @@ -14,6 +14,10 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  Takes the patches given on the command line and emails them out.
> +Patches can be specified as files, directories (which will send all
> +files in the directory), or directly as a revision list.  In the
> +last case, any format accepted by linkgit:git-format-patch[1] can
> +be passed to git send-email.
>  
>  The header of the email is configurable by command line options.  If not
>  specified on the command line, the user will be prompted with a ReadLine
>   

Thanks, this is getting better. Just a quick note, the subject of this
patch is sort of vague. You might want to come up with a better one,
especially because the body of the message is clear.
