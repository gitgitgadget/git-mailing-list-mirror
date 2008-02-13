From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Using kdiff3 to compare two different revisions of a folder
Date: Tue, 12 Feb 2008 23:44:07 -0200
Message-ID: <b8bf37780802121744i62849a53rfa71cc0571aec3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 02:44:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP6g1-0002uU-QA
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 02:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbYBMBoL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2008 20:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbYBMBoL
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 20:44:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:8615 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbYBMBoJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 20:44:09 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1552941nfb.21
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 17:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=v2BVx1prJJt3qybMVYJtGUArS7RSW0GbRaKf6565bwQ=;
        b=k0XcjSGTN/3KR7WMPsaQ58qDjfbyuWDkm0mhRjxdiHORTKMz4WPciAffARo240N4vlGamnINoE1howH/yxjry3HWx3qK7iLPNciKGLl3avAwN3AKigl49aA6CKSzeVsfvaQa8oZO33bB5vAuop3WUwU5lo84xPq1BxhsHpSEQnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mpmutK5zaUJQQwUvFUS63Ci23eukm/jNXUk7yHoGAA4huY/EzfDR7po7nYB944yk4XRhZj+JM3uUjyCNW0+lCa2kTBdXURFhXb6fA9YZ4OBpeACqbD+N4xD5AnPPJAekW2M4S3LEi3EeslY8MuHO9OIqGqX8yVlCQQlayea65ho=
Received: by 10.78.193.19 with SMTP id q19mr3831699huf.69.1202867047999;
        Tue, 12 Feb 2008 17:44:07 -0800 (PST)
Received: by 10.78.100.15 with HTTP; Tue, 12 Feb 2008 17:44:07 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73733>

Hi, all!

    I would like to use kdiff3 to compare some folder like "include"
between two different revisions.
    It would be something like "git diff v2.5:makefile HEAD:makefile",
but for an entire folder.

    Kdiff3 give me a quick glance of its nice graphical output of the
differences, without have to resort to looking/parsing 'git log'
output.
    For now, easiest way for me is to keep my tree replicated in two
different folders pointing to different revisions then use it.

    Is there a better way to do this kind of comparison?

Thanks in advance,
--=20
[]s,
Andr=E9 Goddard
