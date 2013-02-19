From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Can git restrict source files ?
Date: Tue, 19 Feb 2013 18:55:20 +0100
Message-ID: <CACBZZX7tHpUzW8pKjLi_4qm8w-n=FjResyRwZPK9qsyUzqpsMw@mail.gmail.com>
References: <DE551AEA-5C7D-4A2D-8AB4-33195EF351F8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Juan Pablo <juanpablo8517@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 18:56:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7rQD-0004KY-Jc
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 18:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758741Ab3BSRzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 12:55:41 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:45579 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab3BSRzk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 12:55:40 -0500
Received: by mail-ob0-f179.google.com with SMTP id un3so6907195obb.10
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 09:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=TITR7pLx02oqFS1RJOvHNCr6KCchFVQb7zZlszRtZQo=;
        b=v+mDkmnKyrPHd2cYgEDAluvyxDte35KYpTi08aMxQR5ZoVt27eFBOklmZ64GbOyxo7
         sS5QjkazmAv6I4Df747+fbkfflsQkpscGdYP0jMTijjEvMQiNlkWe2p12ei9kN8WCm5g
         gm6cK9Do+j4yyJKI1OtoTRC02xnIF/57kI3L6Y+Jy8HTdjyshThq1U4NfWyIDcAJWB8j
         96x7wlZG7sW1591HcjBdTi9Fkxy+vjoiFC6s9imdCWpc00JIbarM2I/a+Uwn7v1AJBAa
         M7LD/Y6Y+TbgsO18MvhrBdBBRLwf/POgrhQvA7AxW80eyRUrUaUlnulsXuuMLlin58h3
         SQgg==
X-Received: by 10.60.21.101 with SMTP id u5mr8224358oee.71.1361296540369; Tue,
 19 Feb 2013 09:55:40 -0800 (PST)
Received: by 10.76.167.34 with HTTP; Tue, 19 Feb 2013 09:55:20 -0800 (PST)
In-Reply-To: <DE551AEA-5C7D-4A2D-8AB4-33195EF351F8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216640>

On Tue, Feb 19, 2013 at 5:06 PM, Juan Pablo <juanpablo8517@gmail.com> wrote:
> I have a question, can i control the access to specific files or folders ?? I need that some developers can't see some source files, thank you very much for your time

No, but what you can do is to split these up into different
repositories. E.g. where I work we have a puppet.git and a
secrets.git, the latter contains passwords and other secret data, the
former just uses macros to include that and is accessible to everyone.
