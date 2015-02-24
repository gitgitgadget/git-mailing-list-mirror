From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: Build error with current source release
Date: Tue, 24 Feb 2015 13:46:26 -0500
Message-ID: <CAPBPrnu74X8p=p+dNz+hYOmc5uiuDiQtTbgXdWt5QBYHv=b2Ug@mail.gmail.com>
References: <03B16590-C319-478F-B19C-7EF3B51952BC@jrw.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "J. R. Westmoreland" <jr@jrw.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 19:46:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQKV5-0006TW-Su
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 19:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbbBXSq2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2015 13:46:28 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:46177 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbbBXSq1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2015 13:46:27 -0500
Received: by pabkx10 with SMTP id kx10so37973815pab.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 10:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=t6AVn7hYmsa+cXdAI1Hm0+Da+G61qSFGViSPAUP+1G4=;
        b=kJ5c9hLCtKXJX1t8TFZONoX3X9gPCCrg1LLXwQ7QaCWxW7zoclELeMrkmFAjggYE12
         hnSatG8nFXHL8r3Q770Y78y78rQfSAsF4c9udplEIezfchKhebgRQKwTDda2/3yQnG4H
         TIIrwvshsbzaT4anpSQRkK2+Y/G5EeuGzpIywm3JJwQzbiH2l/VNwLhONRWKnb2GOs++
         hr4LoI1tkE+p3kUpubcKMTwK0rE/l2Vb/TRTypY7/CQCsDHnsrmzK0unY6x6v0wlb8h6
         wSbksVnibZlXedB2C/YLR8xKut7KU2AWgQW/JzLQ4MzQG5MxUmqokNWO0EyOvtg9sW2b
         OEDw==
X-Received: by 10.68.239.69 with SMTP id vq5mr5873108pbc.96.1424803586777;
 Tue, 24 Feb 2015 10:46:26 -0800 (PST)
Received: by 10.66.149.130 with HTTP; Tue, 24 Feb 2015 10:46:26 -0800 (PST)
In-Reply-To: <03B16590-C319-478F-B19C-7EF3B51952BC@jrw.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264337>

On Tue, Feb 24, 2015 at 9:23 AM, J. R. Westmoreland <jr@jrw.org> wrote:
> Hi
>
> I hope it is okay to ask such a question here.
>
> I cloned the current source tree and tried to build it and I get the =
following error.
> Could someone tell me why and if there is an easy way to fix it?
> I=E2=80=99m running on a Mac and everything ran fine up to this error=
=2E Is is an excerpt from my typescript file.
>
> Script started on Mon Feb 23 13:43:01 2015
>     XMLTO git-add.1
> xmlto: /Users/jr/Documents/projects/git/Documentation/git-add.xml doe=
s not validate (status 3)
> xmlto: Fix document syntax or use --skip-validation option
> I/O error : Attempt to load network entity http://www.oasis-open.org/=
docbook/xml/4.5/docbookx.dtd
> /Users/jr/Documents/projects/git/Documentation/git-add.xml:2: warning=
: failed to load external entity "http://www.oasis-open.org/docbook/xml=
/4.5/docbookx.dtd"
> D DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/do=
cbookx.dtd"

Can you open this link in your browser/do you need a proxy server to
connect to the internet? When I navigate to that URL it loads for me;
I'm wondering if this is a firewall preventing you from accessing the
dtd
