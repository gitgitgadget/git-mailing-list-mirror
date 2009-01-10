From: "Changsheng Jiang" <jiangzuoyan@gmail.com>
Subject: Re: SSH_ASKPASS
Date: Sun, 11 Jan 2009 01:13:26 +0800
Message-ID: <eafc0afe0901100913w6a461605qf48d7eb7169d50f4@mail.gmail.com>
References: <1231584934701-2137400.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Henk <henk_westhuis@hotmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 18:14:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLhQC-0002v8-S2
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 18:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbZAJRNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 12:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbZAJRN3
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 12:13:29 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:10892 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbZAJRN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 12:13:28 -0500
Received: by rv-out-0506.google.com with SMTP id k40so9478891rvb.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 09:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QsyumJxF/tU8jLWXrly/R01EPQoArIBNuigM4LWbpJk=;
        b=jEe1RdlhQVdD6s0k3ioRgKitCDR4rYrBkysYe9tx0Q1VaPrZ/ekJRWH5HRHNAcBk6K
         uUImSVWE0nIyVoLuGr3DlpRadqE9AUVu1HLW8y8eVT0KI9plRxNXB+0160WaD6Orznnb
         V0QM2LA+L/mfrc7x3wlixMXnjNwop7rM1fzik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NqyxfK0YXCFL9fmJfPE5i9OErXe1lu0Us5h9S0+c7TylR09RsmV2UOeq+eaqlEc/5u
         R4uQQXR65s4n9CgMlDOdfmlBGherZa/I7V8NlMUBIFtlZXqK9c06q1SbBEShZIyMTW0j
         uDfbroBoIdjvnGexf17V3IUIVU4FwLzotgbx4=
Received: by 10.110.8.5 with SMTP id 5mr2387005tih.12.1231607606725;
        Sat, 10 Jan 2009 09:13:26 -0800 (PST)
Received: by 10.110.53.1 with HTTP; Sat, 10 Jan 2009 09:13:26 -0800 (PST)
In-Reply-To: <1231584934701-2137400.post@n2.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105130>

Why you don't setup a pair of keys, then you will not need to enter
passwords?

Yours Sincerely,
Changsheng Jiang

On Sat, Jan 10, 2009 at 18:55, Henk <henk_westhuis@hotmail.com> wrote:
>
> Hi,
>
> I'm trying to get "git push" to use git-gui--askpass to ask me for the
> password instead of promting me on the command promt. I need this because I
> start the "git push" command from code and there is no terminal where ssh
> can ask the user for a password. I tried writing the following tcl script
> that allmost is what I need:
>
> set env(SSH_ASKPASS) "C:/Program
> Files/Git/libexec/git-core/git-gui--askpass"
> exec ssh git@github.com
>
> Ssh will now ask me for the password using git-gui--askpass. But now the
> standardout is also shown in a dialog, and not on the standardout of the
> process. Looking at the git-gui scripts didn't help me, because I have
> absolutely zero experience in tcl.
>
> I also tried not using a tcl script, but setting SSH_ASKPASS as an
> environment variable in windows. This doesn't seem to work, ssh will still
> prompt me for a password.
>
> Anyone can help me write a script that asks for the password using
> SSH_ASKPASS but still prints the output on standardout?
>
> I use Windows btw.
>
> Henk
> --
> View this message in context: http://n2.nabble.com/SSH_ASKPASS-tp2137400p2137400.html
> Sent from the git mailing list archive at Nabble.com.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
