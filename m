From: Javier Domingo Cansino <javierdo1@gmail.com>
Subject: Re: Doing a git add '' will add more files then expected
Date: Sun, 23 Nov 2014 20:06:23 +0100
Message-ID: <CALZVapkKFOSQptQX2_A5E9Oankk+ZBQYcALNW0OTzu4aARJx2g@mail.gmail.com>
References: <CAMDzUtyhNKdzHQK2zLEutJRcRUibhO-U6Zh0yJhrx-YxBqP5cQ@mail.gmail.com>
 <87lhn91ynu.fsf@igel.home> <vpqa93p8y9n.fsf@anie.imag.fr> <xmqqh9xxy79x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Guilherme <guibufolo@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 23 20:06:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XscUj-0008Pt-D8
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 20:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbaKWTGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 14:06:45 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:38521 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbaKWTGo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 14:06:44 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so10639850wgh.2
        for <git@vger.kernel.org>; Sun, 23 Nov 2014 11:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5ht+AU/wPZBz9+XXiB8Y5dOHf5B9jh0+Nt+AIzAjFEo=;
        b=qvHpe7bOakDY9VSGkg3aBRHbJ4Hp5EXWfjxOYZy1kceqeJMsv2cNr8t14TEOmmFiKS
         in/6S7SAYxurFxHxiXyOSeb8B1QRNSLVbfXtx93I05tvCcD5GCQeCpfyUjZQ24sWMXpw
         8YncvFohLEkYOIWBNzOD8gDxPKZH2LC5+VBMFfIw5tHrbSOuZxO1XmcTGX9iA7EiXcFF
         b9YqrYCNYL6N4Nqi3+diVEx+dTnk/u3L9PmNWYD8FpTvz+/exmlHRMfaEgLggafC9c8f
         JIOpONOuhAtUiuSQYMIXpIkxco9ia7sh/KzMi0is8Bo67xAAniukTKbNUoxC+vaYXvJO
         K72A==
X-Received: by 10.180.104.170 with SMTP id gf10mr8608826wib.43.1416769603210;
 Sun, 23 Nov 2014 11:06:43 -0800 (PST)
Received: by 10.27.203.85 with HTTP; Sun, 23 Nov 2014 11:06:23 -0800 (PST)
In-Reply-To: <xmqqh9xxy79x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260097>

IMO, if you put an empty string "" you would be implying the same as
with a dot (git add . ).

The important thing is that "git add" without a pathspec returns an
error, as it has always done, mainly because it people tend to work
without gitignoring all the files they should, and allowing such
behaviour would make things harder.

-- 
Javier Domingo Cansino
