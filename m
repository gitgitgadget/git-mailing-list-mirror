From: Geoffrey Lee <geoffreyj.lee@gmail.com>
Subject: Re: Newbie: Do I need to download the entire repo to work on just 1 
	file?
Date: Sun, 22 Mar 2009 16:06:20 -0700
Message-ID: <83d7aaa40903221606yd84412cna873554f7f58a75f@mail.gmail.com>
References: <BLU121-W15DB0E5CEBC1DA697E5ED8B4950@phx.gbl>
	 <fabb9a1e0903221600j22cf028fl903aef8076e53777@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 00:07:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlWll-0003J2-Nm
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 00:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663AbZCVXGY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 19:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756574AbZCVXGX
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 19:06:23 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:43815 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492AbZCVXGW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 19:06:22 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2513112wff.4
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 16:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=zaz4BoexU55k7cE9b8VOZvgRvQsCExjG1FmUSL/JrXU=;
        b=PXO9fCKG37HS9eUN/9Vl+gS86J7Ic0eJBRih2VccFj5f0yEbuAUqdA3NcXAm6FrJYp
         8V7I8XTIQbYBZjTHjPqm4hJC1ZYpZKCUGeSUCDZ/P++AXcfcvmLJbT32TPV4W5B2qh+p
         hOr4LLENBED68UFdg2iDKc1QoK5zdnRGKxPQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=bzl5RJQRuavnU8VvYMYMhLIW2o0GSl7LnjYEyw3bxyxXa//Z0gRbrHamgy/k6YoBK2
         lCNP1GakQmi3OTTEBzCEXpg9QWScp0pjiFHoN3HhV0SOw6OK0pK2UM48qQQCUG1bnpoB
         0vqennrIijZj5z7kGpSK0x0RMhT8nkF+QaIaI=
Received: by 10.142.180.20 with SMTP id c20mr2302285wff.174.1237763181030; 
	Sun, 22 Mar 2009 16:06:21 -0700 (PDT)
In-Reply-To: <fabb9a1e0903221600j22cf028fl903aef8076e53777@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114196>

On Sun, Mar 22, 2009 at 4:00 PM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> On Sun, Mar 22, 2009 at 23:08, Anthony Rasmussen <evoluenta@hotmail.c=
om> wrote:
>> Do I have to download the entire rep onto my laptop in order to do t=
his? =C2=A0I have read and read, but I am quite confused :)
>
> Yes, you do, in general though, git repositories are quite compact
> compared to, say, a svn checkouts. It is not unheard of that the full
> git clone is smaller than the same code as svn checkout.

It depends on what you mean by "entire repo". Of course you need all
the source files to compile, but you do not need past revisions. Take
a look at the --depth parameter for git-clone.

-Geoffrey Lee
