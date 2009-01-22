From: Christian MICHON <christian.michon@gmail.com>
Subject: how to force a commit date matching info from a mbox ?
Date: Thu, 22 Jan 2009 23:41:12 +0100
Message-ID: <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 23:43:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ8G2-00026J-Ak
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 23:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbZAVWlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 17:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbZAVWlQ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 17:41:16 -0500
Received: from mail-ew0-f20.google.com ([209.85.219.20]:55545 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbZAVWlP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 17:41:15 -0500
Received: by ewy13 with SMTP id 13so3139141ewy.13
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 14:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Tv2kBu6x1ewFcdLAaV5g7EEHKEJZN3rhVa6nf8+ojqA=;
        b=pkwnW3ihRE8YfzpGjjfGQRsbW69Fvt1In/yRUdapYXoRCSFh3JFqmOhKalP/5pUMbh
         +xEtw3FhS0UxFbOL+G2JoRGNTOjR7HjMJmfWo6DXZp0X4Om5DhhKqkz3SiGRtLnwKGIw
         L7MlVVkfPqmvXObHo37kBs5EayHQT++RdxW/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=DE7l2McMPatORMY2jfG5QVMqXSNEc4I1eInyZhQYfAmW3TtKmfsX1CN/Ws8p3GwGCM
         f0XcCJ/E9DqQ5m9gPPKMP/9xc6fVH2leRjD5LZjcoek7/G3b9BZ16vEaHOhMkvrgZzMW
         KRSwMfsRIsske85jpJIpoqbSvoP5V503pr95s=
Received: by 10.102.234.18 with SMTP id g18mr2915057muh.102.1232664073345; 
	Thu, 22 Jan 2009 14:41:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106790>

Hi list,

I've a big set of patches in a mbox file: there's sufficient info
inside for git-am to work.

Yet, each time I do import these, my sha1sums are changing because of
different commit dates.

I'd like to force the commit date to match the info/date from the time
I received the email (and therefore always get back the right
sha1sums).

is this possible ?

There's hundreds of these patches: I'm looking for the right switch or
1 liner trick instead of a long shell script which will import 1 by 1
the patches and force the commit date by environment.

TIA

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
