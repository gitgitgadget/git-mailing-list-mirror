From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] init-db: support --import to add all files and commit 
	right after init
Date: Wed, 25 Mar 2009 13:27:52 +1100
Message-ID: <fcaeb9bf0903241927h5b4d20b9r30fd67c26e63c6f5@mail.gmail.com>
References: <1237946996-5287-1-git-send-email-pclouds@gmail.com> 
	<20090325021458.GY23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 03:29:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmIsA-00079H-1W
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 03:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbZCYC2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 22:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbZCYC2K
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 22:28:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:10423 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbZCYC2J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 22:28:09 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2591828rvb.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 19:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZvBhpMSU2taEVNN+3rfErWQ23v4LcWzDlspZTjOWpqk=;
        b=qLuYP5x6yoF0DyyHvDzzSyZgd9M320a/BdPxZK4BgUSC1F8UzE+5Dk7dtGDpAztIjQ
         0su/y2H05adZHsghX0tuk5s8t+TZtml9DSuzA3V1sJYOeL0UBxKLVWgyMA4cq01Skj4Q
         Z9nRFF0qIUUBL/Zm0jHlVRCZ3oqAhenOK8vnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qwmUdOwjvatrbgWHc2GgSKk5CM7SU73TFoxxp5Hg4kG8W+4vOVjTF27Skz7SaNMRdi
         iNGX1ZCNW3sWWW91kHyd3+T0Z0cJcz//gCWhDW8Paa4owXbWQyX8OiAsXoITWBbXvYzy
         l3s2JuP83294lpV+70mOUs2bS8Cxb03J7VzI4=
In-Reply-To: <20090325021458.GY23521@spearce.org>
Received: by 10.142.13.13 with SMTP id 13mr3675248wfm.150.1237948087995; Tue, 
	24 Mar 2009 19:28:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114543>

On Wed, Mar 25, 2009 at 1:14 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Nguy???n Th??i Ng???c Duy <pclouds@gmail.com> wrote:
>> This is equivalent to "git init;git add .;git commit -q -m blah".
>> I find myself doing that too many times, hence this shortcut.
>
> Why not:
>
> =C2=A0git config --global alias.init-import '!git init && git add . &=
& git commit -q'

1. less setup on new machine
2. fast-import support (not yet though)
--=20
Duy
