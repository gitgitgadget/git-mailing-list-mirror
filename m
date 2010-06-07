From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] documentation: git-mergetool updated to warn against 
	builtin tools invocations
Date: Mon, 7 Jun 2010 14:50:33 +0200
Message-ID: <AANLkTik4zQTLrLZ3Jr6mXsQ2Pi6j5FbMYNJvmBH51bkE@mail.gmail.com>
References: <1275501453-13081-1-git-send-email-srabot@steek.com> 
	<7vbpbt9f9j.fsf@alter.siamese.dyndns.org> <AANLkTikPHdRWsHUI-YwEkECtIbj425hKxzy8_JrA4_ny@mail.gmail.com> 
	<1275686970.2510.1.camel@kheops>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: sylvain@abstraction.fr
X-From: git-owner@vger.kernel.org Mon Jun 07 14:51:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLbnA-0003hT-Vr
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 14:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966Ab0FGMuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 08:50:55 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64844 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab0FGMuy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 08:50:54 -0400
Received: by vws5 with SMTP id 5so3432717vws.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 05:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=bIbXk5a8QlXT8RLQYrcuzUpHiniEEmI1z2+G38KSSyA=;
        b=Ths6uZmL0ky9UK2VY0d2eHfXBekm4qGYdO64moLHUXjKjUpK60q9eD90Gu1OAkLHxN
         b1LaHjyKGI0GF6u6oHM+L9dt6mQOzJLvbwEwaAW0D+cBBzDoGDpU6JA9ieg6gPHwtpIm
         Gd+MKJD8SDYw57AJqQkDYfQjuP0qaSGD0JFeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WD6ZYaXoYxMBMtgYWs0fT4jMqHISdHOTwO27ctZ+Lsh1n9r40h6/o1sVtHaig9Fbza
         6essUZiX5igazWqDub1bT+uaTkJI18tskgZJ8KJLurTAO2VtGCEtjyMHR+o0z/6MHqEa
         JAjV8I4km9buiZHMui6efyyxA/8N/0/niP8Ik=
Received: by 10.224.64.161 with SMTP id e33mr8632331qai.299.1275915053158; 
	Mon, 07 Jun 2010 05:50:53 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 7 Jun 2010 05:50:33 -0700 (PDT)
In-Reply-To: <1275686970.2510.1.camel@kheops>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148591>

Hi,

Sylvain Rabot wrote:
> I'm about to send a patch, before, can I assume that all users have
> sed ?

Yes. $(git grep sed *.sh) revels that sed is referred to in several
existing shell scripts already.

-- Ram
