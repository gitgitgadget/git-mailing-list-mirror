From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git status showing phantom modifications
Date: Mon, 25 Jan 2010 19:03:04 +0800
Message-ID: <be6fef0d1001250303p2c12381ao7d3a8a1d48eebb56@mail.gmail.com>
References: <9B3C1167-7667-4B1F-BEE5-F47FE89F8692@xing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Ludwig <michael.ludwig@xing.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 12:03:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZMj5-0004qq-28
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 12:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab0AYLDQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 06:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674Ab0AYLDQ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 06:03:16 -0500
Received: from mail-iw0-f173.google.com ([209.85.223.173]:47185 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab0AYLDP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 06:03:15 -0500
Received: by iwn3 with SMTP id 3so739000iwn.19
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 03:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5w3RrKnQOb/qH/A4W8PVLJHA7v2A1w6Dn2VHdBdHF0A=;
        b=CmKvyF9S1mD7arzNvpkvGVhmnb44rmkdtrKkGf9k9LmC2WImSkDXzJI/h5eX4YbSTw
         3VV2FEw51OTZrKgQZcKTQZCd1CjQuvFkmaOD0FzelcOrQbVHYuP/bZo6eYCJ4aiRIvpK
         0+QYFPHSAatWE2Rgc3K7A0pqtZetxHYsd/bho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M2sIyafuOGXukgOHf7wd7OG5g4nwnPAZgHtUtay89E2VGqXoBXbo/DlUXyduxlJwnz
         4QOs5EnDUYGG0uHqy6YE9wl5rYEv4uCyrczgSLrMntUGNkvmDjfs/a981jajL+AKcLIi
         oSqExDGEfpooK2TWCnpjnPVASferSx4XQgA90=
Received: by 10.231.148.84 with SMTP id o20mr792316ibv.73.1264417384823; Mon, 
	25 Jan 2010 03:03:04 -0800 (PST)
In-Reply-To: <9B3C1167-7667-4B1F-BEE5-F47FE89F8692@xing.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137951>

Hi,

On Mon, Jan 25, 2010 at 6:41 PM, Michael Ludwig <michael.ludwig@xing.co=
m> wrote:
> michael@wladimir:/cygdrive/m/REPOS6.TECH.git/comp :-) git st
> # On branch master
> # Changed but not updated:
> # =A0 (use "git add <file>..." to update what will be committed)
> # =A0 (use "git checkout -- <file>..." to discard changes in working =
directory)
> #
> # =A0 =A0 =A0 modified: =A0 mw/wsdl-version.txt
> # =A0 =A0 =A0 modified: =A0 net/httpsrvr/iis6.wodo
> # =A0 =A0 =A0 ... and about 100 more of that ...

try running git diff. I suspect the changes are to filemodes. What
does your git config look like regarding this (particularly
core.fileMode)?

--=20
Cheers,
Ray Chuan
