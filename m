From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] If deriving SVN_SSH from GIT_SSH on msys, also add quotes
Date: Sat, 23 Jan 2010 12:22:27 +0100
Message-ID: <fabb9a1e1001230322t708756fahce326511d3f0bda5@mail.gmail.com>
References: <4B5ACDD5.8080007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	jugg@hotmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 12:22:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYe4s-0008QV-Je
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 12:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab0AWLWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 06:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222Ab0AWLWs
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 06:22:48 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:65361 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab0AWLWr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 06:22:47 -0500
Received: by pwi21 with SMTP id 21so1335059pwi.21
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 03:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=h5YARIs5/gpIFJ+NDkQYG1itGyOXcrzcES3A/kg+HC8=;
        b=drqb6DmGduUuaeEk+PVFqWbJ8Bo3UFHS0GsljHFeAilkzdRPCFdqmEtoWia1Yjm+fR
         /JI8plVruuu1IMJHoEippArPEmxeZBZB4ExfWxELqi4CJvModj1JLfVuGmhH9ZrxPe9M
         T4LzxDP/dXw0NBt355tdhjuyCFdF8zeV4nHP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ATu/kizUnVPRYxi+eLECO+zJUyoLuMfLeKSB1PPBCvy6o0cdhUD6Y8kOn+UeTKVRJI
         1yoeBaPiPOaO7GS4B9mnR7eZ1yMQcBM83cNPgKIU0kJgAk//suZZwWdCnmWyxYA906co
         TNkHBLFG0S9+NZe8d2f+SyTfxotf/+sSrEoBI=
Received: by 10.142.152.14 with SMTP id z14mr2853539wfd.252.1264245767062; 
	Sat, 23 Jan 2010 03:22:47 -0800 (PST)
In-Reply-To: <4B5ACDD5.8080007@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137837>

Heya,

On Sat, Jan 23, 2010 at 11:22, Sebastian Schuberth <sschuberth@gmail.com> wrote:
> spaces. As GIT_SSH will not work if it contains quotes, it is save to

s/save/safe/

-- 
Cheers,

Sverre Rabbelier
