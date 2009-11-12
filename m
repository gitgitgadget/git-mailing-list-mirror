From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: get git not to care about permissions
Date: Thu, 12 Nov 2009 00:44:08 -0500
Message-ID: <76718490911112144n6837d02cw94d608bcbc74855a@mail.gmail.com>
References: <26268938.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: sconeman <schoen@bu.edu>
X-From: git-owner@vger.kernel.org Thu Nov 12 06:44:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8STh-0007JO-5B
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 06:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbZKLFoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 00:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752577AbZKLFoE
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 00:44:04 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:35123 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbZKLFoD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 00:44:03 -0500
Received: by vws30 with SMTP id 30so520614vws.33
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 21:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GHRsS3dAYXISlZkLzubXvyFKAAllugULCZZd23WNjnY=;
        b=uqUkL/PMk8TpNWRzy/gct7+cLhklz3UPXYQuDjMSEb4WfGamIb9GL17iuXLWVkjSgA
         KdjuJEw6HFugZOPOzDzR58vR0kk+WcXVFPbextgxzxKkUXF7ELrmHMh377iV5M7QUw3+
         zcjkoUiCHuLIg1cdiyUBO/T0axQg/OEi83fcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NznPgvF/D7c+gCdbjmUoPVMeqrBd5cz+ybFeg8Pt25iehtNeiKjNp4fssRSP5JtyuZ
         RhQGJKbdSYTBosKjQ3sa656oH/qL+H8XAftk+QsCM4au9fZjQQpv2xvS9Nl2QGXgd4ge
         lzxo8L7707rJ/ubR6pXarTwIyo5IPodxyjNCY=
Received: by 10.220.122.90 with SMTP id k26mr2978686vcr.69.1258004648740; Wed, 
	11 Nov 2009 21:44:08 -0800 (PST)
In-Reply-To: <26268938.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132739>

On Wed, Nov 11, 2009 at 4:17 PM, sconeman <schoen@bu.edu> wrote:
> does. =C2=A0Git doesn't like this and won't even create a bare reposi=
tory. =C2=A0Is
> there any way I can get git to ignore permissions and just do what it=
 needs
> to do?

And the output from "git init --bare" is?

j.
