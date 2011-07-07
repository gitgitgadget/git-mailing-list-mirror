From: jon <jon.rafkind@gmail.com>
Subject: 1.7.6 configure bugs
Date: Thu, 07 Jul 2011 14:41:40 -0600
Message-ID: <4E161A04.8090700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 22:42:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QevOU-00018q-OC
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 22:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875Ab1GGUlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 16:41:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61099 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab1GGUlt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 16:41:49 -0400
Received: by iwn6 with SMTP id 6so1178571iwn.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 13:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=SCLac74D9h4P296ZhsEGw8hAOGGkxqc6BAHmx6CU0bI=;
        b=VJpEn9blOJ4rHYrVxyr8OntusVLyl36KxCSCF0w4Nz2enTqfabq/CcVi/bKwG3cl8S
         GSgOGjsNx6r3DCVrGEaEffqUWiTNsNhNj+dIHUZ8nLuMa9Aw7LB42AEa3BzA/EnmrkS3
         D+OTYM+33RnHEuYy26SARxt93jLibUkRjSd3s=
Received: by 10.43.51.71 with SMTP id vh7mr462122icb.260.1310071308089;
        Thu, 07 Jul 2011 13:41:48 -0700 (PDT)
Received: from [192.168.40.36] (crystalis.cs.utah.edu [155.98.68.48])
        by mx.google.com with ESMTPS id x13sm5636617ibh.67.2011.07.07.13.41.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jul 2011 13:41:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176780>

'configure' in git 1.7.6 does not check for the presence of zlib.h nor
tclsh. Compilation will fail without zlib.h and converting the languages
will fail without tclsh

make[1]: Entering directory `/home/user/tmp/git-1.7.6/git-gui'
tclsh po/po2msg.sh --statistics --tcl -l de -d po/ po/de.po
make[1]: tclsh: Command not found

I am not registered on the list so please CC me for future correspondence.
