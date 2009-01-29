From: Tay Ray Chuan <rctay89@gmail.com>
Subject: git clone --bare doesn't create refs/heads/*?
Date: Thu, 29 Jan 2009 22:06:39 +0800
Message-ID: <be6fef0d0901290606q25ad7c82ob250a5f89d4db0cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 15:08:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSXYu-0005eC-8W
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 15:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbZA2OGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 09:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752585AbZA2OGl
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 09:06:41 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:56574 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbZA2OGk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 09:06:40 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1313467wah.21
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 06:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=r72MSOOAMeKraSym/GtZ4NyV0oJ5RBG2yvLaf0XN3oQ=;
        b=BNBxutycQTzPQ9Hf7f+tEd/zdx4Ogn6AX/AD2frS0hEGmbKnmyGFIMkzdSowgNUmIP
         t7t4NwvJ/6LQg3nATNYydX1fEssXG6jrSPbcJwOgdBp4Wvorl6usC/uf4HcBL8Qu/hX8
         sJgR4Wq7JAe04TABnRrISukN/LbRrGhk/KQJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=CfTUxu7tUHSFVfU0mWiThhIJMF5VwEYOWhh+zvKmHKBgWjntCqoBoljBIstJ20iwAB
         dTd24c/Y3MABky1TTqbvM6mahlW8xhHgPF5GoDbSSlMiVCxbX770HyYc6X9/gNR0qlZM
         K+YTVkVyUmhPLpqljRDDZFTX8rIm76Bf9rm3Q=
Received: by 10.114.195.19 with SMTP id s19mr58380waf.123.1233237999547; Thu, 
	29 Jan 2009 06:06:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107679>

Hi,

just like to clarify a doubt of mine.

afaik, a bare repository is just a copy of the .git folder of the
cloned repository. why isn't any of its branches copied too?

-- 
Cheers,
Ray Chuan
