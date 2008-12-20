From: "Mark Ryden" <markryde@gmail.com>
Subject: Applying patches from a patch set
Date: Sat, 20 Dec 2008 16:37:42 +0200
Message-ID: <dac45060812200637m49c71aa5x3c25010fa00f4a63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 20 15:39:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE2zK-0002Sw-0R
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 15:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612AbYLTOhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 09:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755530AbYLTOhp
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 09:37:45 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:60856 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbYLTOhn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 09:37:43 -0500
Received: by yw-out-2324.google.com with SMTP id 9so512302ywe.1
        for <git@vger.kernel.org>; Sat, 20 Dec 2008 06:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=zluW58841ru8gGpU0m4fQP/+uh34u1wIkmVZb40Keuk=;
        b=pwwEdFLDIhEduYw0VeSKFULoDexnNB19Ns8RiZSpQVA5luA/81gEhJ77iCVkS0s+0U
         /X6UnIB+H0y+tGmunQWmQlsszC95A6DO5fsupXaRmNV4t12E8fZ0/sx0xjCM/Yz5y4Mv
         jaM8lHyguVnU1J3/ZGdlstG9VOTVv7+l4kUvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=FHVWhaVXPO7GPzJCp7pScC61Nb6xVPYM1eniqdYsnEvokimM8X0ZURKEt+xOxba5so
         UnhMqtwTdhoLm/eF4R2I16dqOmoAESGuH7rZUjhMkxn+NzVmk5EYSMEVx00Nd80eDkR0
         5kSXimkyO5tLtRxuDAGJwY9pg+d+SGnppdgQc=
Received: by 10.90.66.14 with SMTP id o14mr2274976aga.63.1229783862461;
        Sat, 20 Dec 2008 06:37:42 -0800 (PST)
Received: by 10.90.26.11 with HTTP; Sat, 20 Dec 2008 06:37:42 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103649>

Hello,
  I am subscribed to some linux kernel subsystem mailing list; in this
list there are sometimes patchsets with more than
30-40 patches.
I am using gmail web interface client.

In order to apply a patch set I copy and paste each patch from the
patchset into a file, and then apply that patch.
I assume that there is a better way.
Recently I encountered a fatal error when doing so (and I am not sure
what caused it).

So my question is: does anyone know a more elegant way of applying a
large patchset ?
Maybe there is better mail client with which this process can be done easily ?

(I remember there was something called git apply-mbox in the past).

Rgs,
Mark
