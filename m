From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] index-pack: fix trivial typo in usage string
Date: Sun, 2 May 2010 14:33:40 +0800
Message-ID: <p2pbe6fef0d1005012333tb5cb1487y47512633731a80a0@mail.gmail.com>
References: <ea91a4320bf70e3bb4acee0c9b134338c1f36d51.1272555727.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 02 08:37:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8So2-0005D7-T5
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 08:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386Ab0EBGdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 02:33:41 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:48873 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341Ab0EBGdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 02:33:41 -0400
Received: by iwn12 with SMTP id 12so1966335iwn.15
        for <git@vger.kernel.org>; Sat, 01 May 2010 23:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=/6MSWVEQrb977DhdRn8COdv3gN5o9DePNJ7atC/JhwE=;
        b=lFC7tGS4lipYDRMRpJT0zMoY8uHP1Iv1aR+uwm/EeLyPV2blkPLjmAV+yJaczIfEoc
         qyPR3Bk4YVUOeMytefgdqaOerYxrip7mnWlx+TVsgvnO1rerEfCPAE24PxMbqmgts5ek
         tOYcQVyNIwcqKhFf+mrfe1XfDyoHiqzXhQUrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UJbYyfZfdpbRqYfcasNLdgh4MHF1Fol2ivSy2WfxWVcZdFcW7W3F4mKMo5B/0O7nuI
         ntwZY+vEWkktJzDXvBkWrfZYM/OMdFEiaD+UZjKvFz0Km89TULEJVQ96iyQSYAOrd8hi
         vM/eNFjzKbme/uLcPXrj4JvSsOQ5Gjd44m4vA=
Received: by 10.231.183.133 with SMTP id cg5mr2751779ibb.12.1272782020356; 
	Sat, 01 May 2010 23:33:40 -0700 (PDT)
Received: by 10.231.36.201 with HTTP; Sat, 1 May 2010 23:33:40 -0700 (PDT)
In-Reply-To: <ea91a4320bf70e3bb4acee0c9b134338c1f36d51.1272555727.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146139>

Hi,

On Sun, May 2, 2010 at 2:35 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> -"git index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
> +"git index-pack [-v] [-o <index-file>] [{ --keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";

to save some eyeball-time, the change was s/---keep/--keep/.

-- 
Cheers,
Ray Chuan
