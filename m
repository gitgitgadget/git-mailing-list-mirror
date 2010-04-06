From: Scott Chacon <schacon@gmail.com>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Mon, 5 Apr 2010 21:57:11 -0700
Message-ID: <m2md411cc4a1004052157v200f902ek22420456e4a45512@mail.gmail.com>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
	 <1255065768-10428-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 06 06:57:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz0qw-0002zP-JO
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 06:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168Ab0DFE5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 00:57:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:27367 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab0DFE5N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 00:57:13 -0400
Received: by fg-out-1718.google.com with SMTP id d23so511300fga.1
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 21:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d9dEnXhy5nqF7k5BdXum0E6aoZubsOiFukKZEclWJSk=;
        b=GF742TcUAC6GAuxFpg9MFpwa7dSzyCTOs0PWLf3OUO1L0VdTFiAwNQg9/miQFUakvR
         Z/SbS2LBUgqiCukLKabjhfmtxy5n69/GiSoS6qNlZZ4byRvwKLcQmcdVfgv+JocTmNFh
         9cdbmVZc/qv4L1yDLYOluLHtSJ7R0qKuekmUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rWLc6qXb+nT9qSPqInN7ssZN8jNy/Rdq7xsedXqa7bk4OsE08Y7REVhOikAbs0AKBi
         F5IdniFwbTIIpLYzL0MVPAXaAI86XrI9ep7z9TyI3T/mT4ZdikYv1ZJu1w4vt71Gj+sn
         wOgrshbMgiv4LhMRADfdTJIMe731EXmxO5kKw=
Received: by 10.86.53.2 with HTTP; Mon, 5 Apr 2010 21:57:11 -0700 (PDT)
In-Reply-To: <1255065768-10428-2-git-send-email-spearce@spearce.org>
Received: by 10.87.70.7 with SMTP id x7mr1488007fgk.77.1270529831909; Mon, 05 
	Apr 2010 21:57:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144097>

Hey,

On Thu, Oct 8, 2009 at 10:22 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
> =C2=A0Documentation/technical/http-protocol.txt | =C2=A0542 +++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 542 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 Documentation/technical/http-protocol.txt

I just spent a while looking for this in my email archive - why was
this document not added to the technical/ dir?  Can we put it there?

Scott
