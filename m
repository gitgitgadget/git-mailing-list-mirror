From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH/RFC] More friendly message when locking the index fails.
Date: Wed, 4 Feb 2009 12:50:06 +0100
Message-ID: <bd6139dc0902040350n3af5d37ctc6976fd77671fb82@mail.gmail.com>
References: <vpqljsma99t.fsf@bauges.imag.fr>
	 <1233741505-24020-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Feb 04 12:51:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUgIA-0001dv-Ob
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 12:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbZBDLuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 06:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbZBDLuJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 06:50:09 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:26448 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbZBDLuI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 06:50:08 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1202468fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 03:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=2o6g4JNk3T42Js8/QuP3A0QUYT03yu3DXQSyC5vGbN0=;
        b=uh9CW6/+g3ng21jlNdvTUxBVfKN+u4IeaWxX987DgjgD62QqoMVRSMW40FR6Xufo/6
         fNl/CK3Z8oRGHp+kcgudr4j33gTQ/rjPx2yB0M6Ck02M7mJQgP3fsTgYyM/WzI6Wqhi1
         zQhbrahvdl7wnjRrz1y4GEl4e2/nLYSuLDxyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=J0fkJAuHWegNS0NBl0gZiacnAiwZz93Ih6uX0/578AuPvEdoRAjEJpJb5AIBrozns4
         ZVdjvcrMNOMt9G2A0DKNY5vK0arPxmgnJpL6M5za8lVSgqjUoHDc1fx32sSUew1MYlvr
         QGrlKEOm8ot5ynkGB0mEEMfmcEEVNTmdLpyKY=
Received: by 10.86.94.11 with SMTP id r11mr1767917fgb.11.1233748206114; Wed, 
	04 Feb 2009 03:50:06 -0800 (PST)
In-Reply-To: <1233741505-24020-1-git-send-email-Matthieu.Moy@imag.fr>
X-Google-Sender-Auth: 04983dde9a938866
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108336>

On Wed, Feb 4, 2009 at 10:58, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> +                                   "This probably means a git process crashed in this repository earlier.\n"
> +                                   "Make sure no other git process is running and remove the file manually.",
> +                                   get_index_file(), strerror(lock_error));

How about "If no other git process is currently running, this probably
means...." instead? E.g., sometimes I run 'git commit' in one terminal
window, and then switch to another before committing (to review the
diff for example), which would cause an index.lock file to be present
validly.

-- 
Cheers,

Sverre Rabbelier
