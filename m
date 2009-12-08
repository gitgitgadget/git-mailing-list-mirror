From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH 2/2] git-rm doc: Describe how to sync index & work tree
Date: Tue, 8 Dec 2009 07:12:57 +0100
Message-ID: <6672d0160912072212j5b6f5c0bha57e818ccf975ba6@mail.gmail.com>
References: <4B1D4AFE.6090708@gmail.com>
	 <7vpr6qze4i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 07:13:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHtJo-0005EC-Q3
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 07:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbZLHGMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 01:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbZLHGMw
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 01:12:52 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48297 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242AbZLHGMv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 01:12:51 -0500
Received: by bwz27 with SMTP id 27so4135880bwz.21
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 22:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ej/pyqYizl1otTXnGAmhXJNtTIwvYdhhuIe8gUUxVEc=;
        b=IGrBs6IKntfrswN/xKuR+75CwfB0rLQkYyfr5f1KcSQeLaTziTzaJxX53iFILjIqW0
         Vo+0wJ8fu8HgF74+1ekXmaG3LOkdZmjnd3ROw9hxmrsj9T2e+ic8WkGnJQ/cWIVOTMn+
         sUfMOeFkdNah0XTWTpdVw7Nl/6HR2rPed5cs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GaH47e2arGLh+wDdZq/aEoIDihP7nKsgYGlMa9KvPtuubBQyeplzyz+X8PaX7pOk9x
         sP4fsktbn1CRduzMAQ/1z8CQYbovArLad5tbXfgs0pb3onc3lTbJlqD2A/KoyeR4xobS
         jAHI0vUHKPw52wNG0Pgob6r7UKPjBD/Q3eIvo=
Received: by 10.204.48.194 with SMTP id s2mr7941325bkf.210.1260252777292; Mon, 
	07 Dec 2009 22:12:57 -0800 (PST)
In-Reply-To: <7vpr6qze4i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134821>

2009/12/7 Junio C Hamano <gitster@pobox.com>:
> Looks sensible.
>
> I think mentioning "add -u" in the same section as "commit -a" would =
be
> helpful, as these two are more for user's own development (as opposed=
 to
> vendor-code-drop). =C2=A0I'd perhaps squash something like this in. =C2=
=A0Please say
> "yes", "don't, it is horrible", or something in between ;-)

Yes. :-)

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
