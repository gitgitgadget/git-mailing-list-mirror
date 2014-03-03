From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] rebase: new convenient option to edit a single commit
Date: Mon, 3 Mar 2014 15:28:52 -0500
Message-ID: <CAPig+cTn-YcWHsGRKUZWqACJ5ZspWoB+f4i7hNj09_4Ci6odiw@mail.gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 21:28:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKZTu-0007Eg-0F
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 21:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbaCCU2x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2014 15:28:53 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:46758 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332AbaCCU2x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 15:28:53 -0500
Received: by mail-yk0-f171.google.com with SMTP id q9so11825150ykb.2
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 12:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=fnziIwYeqPQ0v3AD6fzUr7x12h1gT/XOBHEr0orNHj8=;
        b=DFsFyS7MgIXo9SMDBTMDp++9ETJGDcYqw7OE2WI2pLAYDq7OjgpsML6w+3CfidNPZO
         XNq+vPs7lE+ZNWxsDcn+NcG7w8QXBwad4tjUgzpYdmBGPRv2aMZ0U8ePRiYZCGrVV0oc
         QcYfCfZP9RqpXnMx++dL9inKexAGgPMdMClFwaXE+vy1pS8GWbJsCkHiXhqokvaW6T5L
         +kI7w3atUOuN1Kk3vMOkqYZTY+HpF/nA+ZDatixfHFSfoLxD+DT2hPFfqRs3D4eVT9Wa
         nec2J5FfT/SIinvGd4HqObgooLNi+D9+GngQ7+FRRP+yp/bT+/aYusMhF/4pziSJTs1n
         DDSw==
X-Received: by 10.236.93.43 with SMTP id k31mr3920287yhf.88.1393878532058;
 Mon, 03 Mar 2014 12:28:52 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Mon, 3 Mar 2014 12:28:52 -0800 (PST)
In-Reply-To: <1393728794-29566-4-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: EoOYzBjXQINuTXV0JI_v46rAVxc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243267>

On Sat, Mar 1, 2014 at 9:53 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> "git rebase -e XYZ" is basically the same as
>
> EDITOR=3D"sed -i '1s/pick XYZ/edit XYZ/' $@" \
> git rebase -i XYZ^
>
> In English, it prepares the todo list for you to edit only commit XYZ
> to save your time. The time saving is only significant when you edit =
a
> lot of commits separately.

Is it correct to single out only "edit" for special treatment? If
allowing "edit" on the command-line, then shouldn't command-line
"reword" also be supported? I, for one, often need to reword a commit
message (or two or three); far more frequently than I need to edit a
commit.

(This is a genuine question about perceived favoritism of "edit", as
opposed to a request to further bloat the interface.)
