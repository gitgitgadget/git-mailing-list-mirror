From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Limited git-gui to displaying 5000 new files
Date: Mon, 10 Aug 2009 19:06:57 +0200
Message-ID: <81b0412b0908101006n66672cabi865a980d978c2865@mail.gmail.com>
References: <4A4A77A6.1020905@lawrence.edu> <20090810153859.GT1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dan Zwell <dzwell@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 10 19:07:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaYKy-0007Ez-3M
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 19:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407AbZHJRG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 13:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755377AbZHJRG6
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 13:06:58 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:63966 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990AbZHJRG6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 13:06:58 -0400
Received: by bwz19 with SMTP id 19so2699512bwz.37
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=twJ85l6wVAVkSZ7J8VXOz+adPfmhJCw5RGxhTa9fFac=;
        b=dIfIA0XnsXu2a8NSRC0SjVnEysBQ8j7bn8ucAI9uJsVyeacgXyPlaJccT3ytSNVJVx
         R7i3SsbFUN5IAbtSr3PTeuBRiLaai6g4GyC1UbnZecwl0u7/sYN+TSqHcc+/9u4oliS1
         /faTXSrt99cZbDljoKtLwBIAegy9eR7HrVX98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XXQ7VVZbhUp1IEvYuQvbsnwdhxRZdjQq9xr7fSyoRRlKiWLG4Dy4sAUGDo3PekKv0L
         W7MWkKAAgsxrNhBKy14U7BI4PYSjl1kNpNNGtwppPGRL6rCpGN6fh4DvtTqpGal71g0/
         2c/8+pNxZdRaaXNI0PpMrGy/cj+zVeGjC39FE=
Received: by 10.204.52.72 with SMTP id h8mr770382bkg.23.1249924017975; Mon, 10 
	Aug 2009 10:06:57 -0700 (PDT)
In-Reply-To: <20090810153859.GT1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125490>

On Mon, Aug 10, 2009 at 17:38, Shawn O. Pearce<spearce@spearce.org> wro=
te:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 set warning "Displaying only $display_limit of "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 append warning "[llength $to_display] files."
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 info_popup [mc $warning]
>
> This needs to be in the translated strings.
>

Will do, as soon as this hits git://repo.or.cz/git-gui.git.
Or should I have looked at the internationalization repo
git://repo.or.cz/git-gui/git-gui-i18n.git?
