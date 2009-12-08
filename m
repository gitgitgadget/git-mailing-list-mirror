From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [BUG] Bad msysgit/egit interaction over dotfiles
Date: Tue, 8 Dec 2009 14:34:59 +0100
Message-ID: <40aa078e0912080534x32fe9724xcda47ad46dbdb7c0@mail.gmail.com>
References: <20091208132857.GB5425@linagora.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT ml <git@vger.kernel.org>
To: Yann Dirson <ydirson@linagora.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 14:35:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI0Dh-0005C1-Rf
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 14:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989AbZLHNe4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 08:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbZLHNez
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 08:34:55 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:41658 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809AbZLHNez convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 08:34:55 -0500
Received: by ewy1 with SMTP id 1so2729655ewy.28
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 05:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+NON0LWDSyqD4bETuoNkBR98xof6p4GTBZ3ZDseX+PY=;
        b=i6IBcPyM906h2RJ6ZNCJJAzKIihgKRw0t8MNHip2CnKrxwy07dP82DVxjRKpzEt2h5
         emFi1bS45DvYfF/OTDnrCfBC8BT3dFIpbYKXUlqw2/tmAHIDpqQ/sRN0+sLdpUfgWFyT
         UPX5R4xnnsb8auKAWeZCzZUKIaic4iIQ1s8Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=eEB67Bl4WSi7PEp2xYmsqBpPdLdlynulxgKUNznf0RM8lF3+1bFPCOKTLri9dJgNkb
         pYbbFEe+qUJZpSS45DCvqmt5D0X3TAQQS4bIURl4Hy+RxSlRWc395WHZKTiORkKWjXae
         +mGlH6zp0CVtKsJlzUJHCtQkIWtW8Ua2mvCK0=
Received: by 10.216.93.78 with SMTP id k56mr2907249wef.102.1260279299891; Tue, 
	08 Dec 2009 05:34:59 -0800 (PST)
In-Reply-To: <20091208132857.GB5425@linagora.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134867>

On Tue, Dec 8, 2009 at 2:28 PM, Yann Dirson <ydirson@linagora.com> wrot=
e:
> I'm not sure who's at fault here - namely, I can't see any valid
> reason for eclipse to refuse such writes, but I am not sure it is a
> good reason for msysgit would set the hidden bit either. =A0In either
> case, even if only for the short term, I think msysgit should ensure
> that this bit does not get set (possibly circumventing any magic msys
> would do behind its back).

Setting the config option "core.hidedotfiles" to "false" should
prevent this from happening.

--=20
Erik "kusma" Faye-Lund
