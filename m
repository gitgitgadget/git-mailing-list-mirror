From: Mark Ryden <markryde@gmail.com>
Subject: git diff and getting a list of files which have diffs
Date: Thu, 5 Feb 2009 00:35:22 +0200
Message-ID: <dac45060902041435m3f884475j7f359ee694048ee5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 23:36:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUqMV-0005sd-8n
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 23:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415AbZBDWf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 17:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756064AbZBDWfZ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 17:35:25 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:12686 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436AbZBDWfY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 17:35:24 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1044451yxm.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 14:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=+eU8pOXWiPsuURETiPNiyTxY18Th6fqadyNn26qouZ8=;
        b=gUjIa30IKBzSGODasbN4bKfjRSgWOjwTd8Fmdxp+u0QIDq1m+mszvi8agbJHPjGicF
         oLJMeyXV3uP/NgyeLFFt/w7bbLvHSRTMX/s1spW8yosBT7nwdcixrWa/TPvH9r2sg73a
         veXRLQfSY8BoGXy+jgXnaAzSmtuC3jqoZ6Bsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=V3qBrnkEa4XFI4y3jz9YtAfIq8/Ci1+b+I4K3P8vAPpj5iNpRUOFrdDFps9q+jAD1V
         IWHUfNPkNsmcqtRODudpziYkpc9zDeGgEGC7c4xla9B0b6sarCiOCHyIQpxmd+EmNw6p
         rIleiSDCS6JmWsbKaExqOqiuqTOZ9VfAT9yqc=
Received: by 10.90.63.6 with SMTP id l6mr4484770aga.46.1233786922356; Wed, 04 
	Feb 2009 14:35:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108447>

Hello,
git diff shows the differneces between a tree and the working tree.
Is there a way to get only the list of file names that have such differences
without getting the differences themselves ?
Rgs,
Mark
