From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [PATCH v2] git-gui: Add shortcut keys for Show More/Less Context
Date: Tue, 1 Apr 2008 14:59:01 +0100
Message-ID: <57518fd10804010659t42569632u906f994519d527c6@mail.gmail.com>
References: <1207047243-27738-1-git-send-email-maillist@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Apr 01 16:00:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgh1f-0007e3-Ba
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 15:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbYDAN7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 09:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754922AbYDAN7E
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 09:59:04 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:42729 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394AbYDAN7C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 09:59:02 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1214896rvb.1
        for <git@vger.kernel.org>; Tue, 01 Apr 2008 06:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=EBUQmcreQVi+8z5vO/xAPAtM6eql50RkoEqRqqpPsHU=;
        b=YZ0SAmHUo313da+l1AVrbpPmSK5IiWbyFlIA+KfsiUT9nXCt+zrmI0SEk2VsSVv21vO9e9E0K8HOrYqryHs6KwRNQVks6vNUMkffLr5rGcbqRuuvfJMKoSDfqRBGFWIS9UQuKF1iSsDFqxTg+leKeOnvoSfmpYwzI1+CITaKNMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=WClFdl0GcIK4QvzkLUHx4UQAmq4lJlGevJ4yHkTEdm9JTn3aelLV0azw50kzGzs74M3vSY5J3aQ51KizgTWcQex+y7Q+exNAJJJ/prjStetZB/vQW4+PQpDk96nDaNMe3rwynMxMoLqTAR7BazbsF8/93RW9goUYq4vx1RuPmbo=
Received: by 10.141.177.2 with SMTP id e2mr4288395rvp.268.1207058341418;
        Tue, 01 Apr 2008 06:59:01 -0700 (PDT)
Received: by 10.141.86.15 with HTTP; Tue, 1 Apr 2008 06:59:01 -0700 (PDT)
In-Reply-To: <1207047243-27738-1-git-send-email-maillist@steelskies.com>
Content-Disposition: inline
X-Google-Sender-Auth: 92fadc0656e00343
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78656>

On Tue, Apr 1, 2008 at 11:54 AM, Jonathan del Strother
<maillist@steelskies.com> wrote:
> Bound to Ctrl/Cmd + left & right square brackets, depending on your platform.
>
>  Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
>  ---
>
>  Second attempt to add Show Context shortcuts to git gui.  This new version also adds the items to the Commit menu, complete with accelerator keys to make the shortcut more visible.
>


... I've just noticed that the shortcut keys don't apply while the
diff view has keyboard focus.  Shall I replace "bind $ui_comm ... "
with "bind all ..."  ?
