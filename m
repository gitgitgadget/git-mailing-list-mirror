From: Rostislav Svoboda <rostislav.svoboda@gmail.com>
Subject: Re: Best way to merge two repos with same content, different history
Date: Fri, 5 Jun 2009 19:19:51 +0200
Message-ID: <286817520906051019k78dc002cg8006987a7258b6de@mail.gmail.com>
References: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com>
	 <286817520906050953n1afed29cn6c85f219a0c9b8b5@mail.gmail.com>
	 <63BEA5E623E09F4D92233FB12A9F794303117DC1@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Kelly F. Hickel" <kfh@mqsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 19:20:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCd5F-0003lM-5M
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 19:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbZFERTv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 13:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbZFERTu
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 13:19:50 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:65362 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbZFERTu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 13:19:50 -0400
Received: by bwz9 with SMTP id 9so1650308bwz.37
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7VZvjKCH6iFMGnVVhTlDECNBvN89lQ4X1uWXTEmEw1o=;
        b=RbFv14tcOeRNoehCGuTol1kL5uFy/6x1RSRqLqGwVG7BbZAxDZbLfizCzcQyJ60VQH
         XZbciGmU5T2j/5ldalevmAhxIPjaZxExoZt5b/tCP2kdnXL0yon44DfAf6rXp5RE+3/K
         LtpmFnUlZ9H1RbwL4hyrSAIvpRFjyvey63i9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wbNLZP3WHLohDCjyloXMSd7ouwQdSWe0L+tg+WlUJT1IrTW78WNB3k9bepToLs745O
         rytYm4GXlB4IsuojWZbN11sF//txp6tIvY3Vr5Y1gnnRo7eYKEMI8Q6C2dSdMKne9SD6
         Tk/Ao314NdeqNQwY27DUIwI6i9WH18wOeXq8Y=
Received: by 10.204.55.200 with SMTP id v8mr3403053bkg.54.1244222391261; Fri, 
	05 Jun 2009 10:19:51 -0700 (PDT)
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794303117DC1@emailmn.mqsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120815>

On Fri, Jun 5, 2009 at 19:10, Kelly F. Hickel<kfh@mqsoftware.com> wrote=
:
> Bost,
> =A0 =A0 =A0 =A0Thanks, but I'm already working with a local copy of t=
he CVS repo. =A0I've corresponded with Michael Haggerty about the time =
this takes, and there just doesn't seem to be any way to improve the sp=
eed, without making some fairly drastic changes to cvs2git.

uhm, see below

Bost

On Tue, Feb 3, 2009 at 14:55, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
>> If you do not have filesystem access to your CVS repository, you mig=
ht
>> be able to clone it using CVSSuck [2,3].
>
> A substantially faster option would be to go with cvsclone:
>
>        http://samba.org/ftp/tridge/rtc/cvsclone.l
>
> (in my case, cvsclone was not only faster, but it actually worked, to=
o,
> which is more than I could say of CVSSuck).
